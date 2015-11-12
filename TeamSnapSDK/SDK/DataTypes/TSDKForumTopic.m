//
//  TSDKForumTopic.m
//  SDKPlayground
//
//  Created by Jason Rahaim on 9/1/15.
//  Copyright (c) 2015 TeamSnap. All rights reserved.
//

#import "TSDKForumTopic.h"
#import "TSDKTeamSnap.h"
#import "TSDKDataRequest.h"
#import "TSDKRootLinks.h"
#import "TSDKForumPost.h"

@implementation TSDKForumTopic
@dynamic title, isAnnouncement, teamId, linkForumSubscriptions, linkTeam, linkForumPosts;

+ (NSString *)SDKType {
    return @"forum_topic";
}

+(void)addNewTopicWithTitle:(NSString *)title isAnnouncement:(BOOL)isAnnouncement forTeamId:(NSInteger)teamId withCompletion:(TSDKCompletionBlock)completion {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    if (title && title.length>0) {
        [data setObject:title forKey:@"title"];
    }
    if (isAnnouncement) {
        [data setObject:@"true" forKey:@"is_announcement"];
    } else {
        [data setObject:@"false" forKey:@"is_announcement"];
    }
    
    [data setObject:[NSNumber numberWithInteger:teamId] forKey:@"team_id"];
    [TSDKDataRequest requestObjectsForPath:[[[TSDKTeamSnap sharedInstance] rootLinks] linkForumTopics] sendDataDictionary:data method:@"POST" withCompletion:^(BOOL success, BOOL complete, TSDKCollectionJSON *objects, NSError *error) {
        if (completion) {
            completion(success, complete, objects, error);
        }
    }];
}

@end
