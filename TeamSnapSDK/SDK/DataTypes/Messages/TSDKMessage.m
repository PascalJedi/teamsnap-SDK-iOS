//
//  TSDKMessage.m
//  TeamSnapSDK
//
//  Created by Skyler Seamans on 3/9/16.
//  Copyright © 2016 teamsnap. All rights reserved.
//

#import "TSDKMessage.h"
#import "TSDKMember.h"

@interface TSDKMessage()

@property (nonatomic, weak) NSString *messageType; //Example: Email

@end

@implementation TSDKMessage

@dynamic status, memberId, userId, updatedAt, subject, senderType, recipientNames, flags, body, pushed, contactId, messageId, emailed, readAt, senderName, recipients, createdAt, smsed, divisionId, senderId, teamId, linkMember, linkSender, linkDivision, linkTeam, linkUser, messageType;

+ (NSString *)SDKType {
    return @"message";
}

- (TSDKMessageType)getMessageType {
    if([self.messageType isEqualToString:@"Alert"]) {
        return TSDKMessageTypeAlert;
    } else if([self.messageType isEqualToString:@"Email"]) {
        return TSDKMessageTypeEmail;
    } else {
        return TSDKMessageTypeUnknown;
    }
}

+ (void)actionMarkMessageAsRead:(TSDKMessage *)message completion:(TSDKCompletionBlock)completion {    
    TSDKCollectionCommand *command = [[TSDKMessage commands] objectForKey:@"mark_message_as_read"];
    command.data[@"id"] = [NSNumber numberWithInteger:message.objectIdentifier];
    
    [command executeWithCompletion:^(BOOL success, BOOL complete, TSDKCollectionJSON *objects, NSError *error) {
        if (completion) {
            completion(success, complete, objects, error);
        }
    }];
}

- (void)markMessageAsReadWithCompletion:(TSDKCompletionBlock _Nullable)completion {
    [TSDKMessage actionMarkMessageAsRead:self completion:completion];
}

@end
