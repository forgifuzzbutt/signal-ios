//
// Copyright 2018 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//

#import "OWSUnknownProtocolVersionMessage.h"
#import <SignalServiceKit/SignalServiceKit-Swift.h>

NS_ASSUME_NONNULL_BEGIN

NSUInteger const OWSUnknownProtocolVersionMessageSchemaVersion = 1;

@interface OWSUnknownProtocolVersionMessage ()

@property (nonatomic) NSUInteger protocolVersion;
// If nil, the invalid message was sent by a linked device.
@property (nonatomic, nullable) SignalServiceAddress *sender;
@property (nonatomic, readonly) NSUInteger unknownProtocolVersionMessageSchemaVersion;

@end

#pragma mark -

@implementation OWSUnknownProtocolVersionMessage

- (instancetype)initWithThread:(TSThread *)thread
                        sender:(nullable SignalServiceAddress *)sender
               protocolVersion:(NSUInteger)protocolVersion
{
    self = [super initWithThread:thread
                       timestamp:0
                      serverGuid:nil
                     messageType:TSInfoMessageUnknownProtocolVersion
             infoMessageUserInfo:nil];

    if (self) {
        if (sender) {
            OWSAssertDebug(sender.isValid);
        }

        _protocolVersion = protocolVersion;
        _sender = sender;
        _unknownProtocolVersionMessageSchemaVersion = OWSUnknownProtocolVersionMessageSchemaVersion;
    }

    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (!self) {
        return self;
    }

    if (_unknownProtocolVersionMessageSchemaVersion < 1) {
        NSString *_Nullable phoneNumber = [coder decodeObjectForKey:@"senderId"];
        if (phoneNumber) {
            _sender = [SignalServiceAddress legacyAddressWithServiceIdString:nil phoneNumber:phoneNumber];
        }
    }

    _unknownProtocolVersionMessageSchemaVersion = OWSUnknownProtocolVersionMessageSchemaVersion;

    return self;
}

// --- CODE GENERATION MARKER

// This snippet is generated by /Scripts/sds_codegen/sds_generate.py. Do not manually edit it, instead run
// `sds_codegen.sh`.

// clang-format off

- (instancetype)initWithGrdbId:(int64_t)grdbId
                      uniqueId:(NSString *)uniqueId
             receivedAtTimestamp:(uint64_t)receivedAtTimestamp
                          sortId:(uint64_t)sortId
                       timestamp:(uint64_t)timestamp
                  uniqueThreadId:(NSString *)uniqueThreadId
                   attachmentIds:(NSArray<NSString *> *)attachmentIds
                            body:(nullable NSString *)body
                      bodyRanges:(nullable MessageBodyRanges *)bodyRanges
                    contactShare:(nullable OWSContact *)contactShare
                       editState:(TSEditState)editState
                 expireStartedAt:(uint64_t)expireStartedAt
                       expiresAt:(uint64_t)expiresAt
                expiresInSeconds:(unsigned int)expiresInSeconds
                       giftBadge:(nullable OWSGiftBadge *)giftBadge
               isGroupStoryReply:(BOOL)isGroupStoryReply
              isViewOnceComplete:(BOOL)isViewOnceComplete
               isViewOnceMessage:(BOOL)isViewOnceMessage
                     linkPreview:(nullable OWSLinkPreview *)linkPreview
                  messageSticker:(nullable MessageSticker *)messageSticker
                   quotedMessage:(nullable TSQuotedMessage *)quotedMessage
    storedShouldStartExpireTimer:(BOOL)storedShouldStartExpireTimer
           storyAuthorUuidString:(nullable NSString *)storyAuthorUuidString
              storyReactionEmoji:(nullable NSString *)storyReactionEmoji
                  storyTimestamp:(nullable NSNumber *)storyTimestamp
              wasRemotelyDeleted:(BOOL)wasRemotelyDeleted
                   customMessage:(nullable NSString *)customMessage
             infoMessageUserInfo:(nullable NSDictionary<InfoMessageUserInfoKey, id> *)infoMessageUserInfo
                     messageType:(TSInfoMessageType)messageType
                            read:(BOOL)read
                      serverGuid:(nullable NSString *)serverGuid
             unregisteredAddress:(nullable SignalServiceAddress *)unregisteredAddress
                 protocolVersion:(NSUInteger)protocolVersion
                          sender:(nullable SignalServiceAddress *)sender
{
    self = [super initWithGrdbId:grdbId
                        uniqueId:uniqueId
               receivedAtTimestamp:receivedAtTimestamp
                            sortId:sortId
                         timestamp:timestamp
                    uniqueThreadId:uniqueThreadId
                     attachmentIds:attachmentIds
                              body:body
                        bodyRanges:bodyRanges
                      contactShare:contactShare
                         editState:editState
                   expireStartedAt:expireStartedAt
                         expiresAt:expiresAt
                  expiresInSeconds:expiresInSeconds
                         giftBadge:giftBadge
                 isGroupStoryReply:isGroupStoryReply
                isViewOnceComplete:isViewOnceComplete
                 isViewOnceMessage:isViewOnceMessage
                       linkPreview:linkPreview
                    messageSticker:messageSticker
                     quotedMessage:quotedMessage
      storedShouldStartExpireTimer:storedShouldStartExpireTimer
             storyAuthorUuidString:storyAuthorUuidString
                storyReactionEmoji:storyReactionEmoji
                    storyTimestamp:storyTimestamp
                wasRemotelyDeleted:wasRemotelyDeleted
                     customMessage:customMessage
               infoMessageUserInfo:infoMessageUserInfo
                       messageType:messageType
                              read:read
                        serverGuid:serverGuid
               unregisteredAddress:unregisteredAddress];

    if (!self) {
        return self;
    }

    _protocolVersion = protocolVersion;
    _sender = sender;

    return self;
}

// clang-format on

// --- CODE GENERATION MARKER

- (NSString *)infoMessagePreviewTextWithTransaction:(SDSAnyReadTransaction *)transaction
{
    return [self messageTextWithTransaction:transaction];
}

- (NSString *)messageTextWithTransaction:(SDSAnyReadTransaction *)transaction
{
    if (!self.sender.isValid) {
        // This was sent from a linked device.
        if (self.isProtocolVersionUnknown) {
            return OWSLocalizedString(@"UNKNOWN_PROTOCOL_VERSION_NEED_TO_UPGRADE_FROM_LINKED_DEVICE",
                @"Info message recorded in conversation history when local user receives an "
                @"unknown message from a linked device and needs to "
                @"upgrade.");
        } else {
            return OWSLocalizedString(@"UNKNOWN_PROTOCOL_VERSION_UPGRADE_COMPLETE_FROM_LINKED_DEVICE",
                @"Info message recorded in conversation history when local user has "
                @"received an unknown unknown message from a linked device and "
                @"has upgraded.");
        }
    }

    NSString *senderName = [self.contactManagerObjC displayNameStringForAddress:self.sender transaction:transaction];

    if (self.isProtocolVersionUnknown) {
        if (senderName.length > 0) {
            return [NSString
                stringWithFormat:OWSLocalizedString(@"UNKNOWN_PROTOCOL_VERSION_NEED_TO_UPGRADE_WITH_NAME_FORMAT",
                                     @"Info message recorded in conversation history when local user receives an "
                                     @"unknown message and needs to "
                                     @"upgrade. Embeds {{user's name or phone number}}."),
                senderName];
        } else {
            OWSFailDebug(@"Missing sender name.");

            return OWSLocalizedString(@"UNKNOWN_PROTOCOL_VERSION_NEED_TO_UPGRADE_WITHOUT_NAME",
                @"Info message recorded in conversation history when local user receives an unknown message and needs "
                @"to "
                @"upgrade.");
        }
    } else {
        if (senderName.length > 0) {
            return [NSString
                stringWithFormat:OWSLocalizedString(@"UNKNOWN_PROTOCOL_VERSION_UPGRADE_COMPLETE_WITH_NAME_FORMAT",
                                     @"Info message recorded in conversation history when local user has received an "
                                     @"unknown message and has "
                                     @"upgraded. Embeds {{user's name or phone number}}."),
                senderName];
        } else {
            OWSFailDebug(@"Missing sender name.");

            return OWSLocalizedString(@"UNKNOWN_PROTOCOL_VERSION_UPGRADE_COMPLETE_WITHOUT_NAME",
                @"Info message recorded in conversation history when local user has received an unknown message and "
                @"has upgraded.");
        }
    }
}

- (BOOL)isProtocolVersionUnknown
{
    return self.protocolVersion > (unsigned int)SSKProtos.currentProtocolVersion;
}

@end

NS_ASSUME_NONNULL_END
