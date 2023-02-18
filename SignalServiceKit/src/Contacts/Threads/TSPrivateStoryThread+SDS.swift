//
// Copyright 2022 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//

import Foundation
import GRDB
import SignalCoreKit

// NOTE: This file is generated by /Scripts/sds_codegen/sds_generate.py.
// Do not manually edit it, instead run `sds_codegen.sh`.

// MARK: - Typed Convenience Methods

@objc
public extension TSPrivateStoryThread {
    // NOTE: This method will fail if the object has unexpected type.
    class func anyFetchPrivateStoryThread(
        uniqueId: String,
        transaction: SDSAnyReadTransaction
    ) -> TSPrivateStoryThread? {
        assert(!uniqueId.isEmpty)

        guard let object = anyFetch(uniqueId: uniqueId,
                                    transaction: transaction) else {
                                        return nil
        }
        guard let instance = object as? TSPrivateStoryThread else {
            owsFailDebug("Object has unexpected type: \(type(of: object))")
            return nil
        }
        return instance
    }

    // NOTE: This method will fail if the object has unexpected type.
    func anyUpdatePrivateStoryThread(transaction: SDSAnyWriteTransaction, block: (TSPrivateStoryThread) -> Void) {
        anyUpdate(transaction: transaction) { (object) in
            guard let instance = object as? TSPrivateStoryThread else {
                owsFailDebug("Object has unexpected type: \(type(of: object))")
                return
            }
            block(instance)
        }
    }
}

// MARK: - SDSSerializer

// The SDSSerializer protocol specifies how to insert and update the
// row that corresponds to this model.
class TSPrivateStoryThreadSerializer: SDSSerializer {

    private let model: TSPrivateStoryThread
    public required init(model: TSPrivateStoryThread) {
        self.model = model
    }

    // MARK: - Record

    func asRecord() throws -> SDSRecord {
        let id: Int64? = model.grdbId?.int64Value

        let recordType: SDSRecordType = .privateStoryThread
        let uniqueId: String = model.uniqueId

        // Properties
        let conversationColorName: String = model.conversationColorNameObsolete
        let creationDate: Double? = archiveOptionalDate(model.creationDate)
        let isArchived: Bool = model.isArchivedObsolete
        let lastInteractionRowId: UInt64 = model.lastInteractionRowId
        let messageDraft: String? = model.messageDraft
        let mutedUntilDate: Double? = archiveOptionalDate(model.mutedUntilDateObsolete)
        let shouldThreadBeVisible: Bool = model.shouldThreadBeVisible
        let contactPhoneNumber: String? = nil
        let contactUUID: String? = nil
        let groupModel: Data? = nil
        let hasDismissedOffers: Bool? = nil
        let isMarkedUnread: Bool = model.isMarkedUnreadObsolete
        let lastVisibleSortIdOnScreenPercentage: Double = model.lastVisibleSortIdOnScreenPercentageObsolete
        let lastVisibleSortId: UInt64 = model.lastVisibleSortIdObsolete
        let messageDraftBodyRanges: Data? = optionalArchive(model.messageDraftBodyRanges)
        let mentionNotificationMode: UInt = model.mentionNotificationMode.rawValue
        let mutedUntilTimestamp: UInt64 = model.mutedUntilTimestampObsolete
        let allowsReplies: Bool? = model.allowsReplies
        let lastSentStoryTimestamp: UInt64? = archiveOptionalNSNumber(model.lastSentStoryTimestamp, conversion: { $0.uint64Value })
        let name: String? = model.name
        let addresses: Data? = optionalArchive(model.addresses)
        let storyViewMode: UInt = model.storyViewMode.rawValue

        return ThreadRecord(delegate: model, id: id, recordType: recordType, uniqueId: uniqueId, conversationColorName: conversationColorName, creationDate: creationDate, isArchived: isArchived, lastInteractionRowId: lastInteractionRowId, messageDraft: messageDraft, mutedUntilDate: mutedUntilDate, shouldThreadBeVisible: shouldThreadBeVisible, contactPhoneNumber: contactPhoneNumber, contactUUID: contactUUID, groupModel: groupModel, hasDismissedOffers: hasDismissedOffers, isMarkedUnread: isMarkedUnread, lastVisibleSortIdOnScreenPercentage: lastVisibleSortIdOnScreenPercentage, lastVisibleSortId: lastVisibleSortId, messageDraftBodyRanges: messageDraftBodyRanges, mentionNotificationMode: mentionNotificationMode, mutedUntilTimestamp: mutedUntilTimestamp, allowsReplies: allowsReplies, lastSentStoryTimestamp: lastSentStoryTimestamp, name: name, addresses: addresses, storyViewMode: storyViewMode)
    }
}
