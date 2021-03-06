//
//  TSDKTrackedItem.h
//  SDKPlayground
//
// Copyright (c) 2015 TeamSnap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSDKCollectionObject.h"
#import "TSDKObjectsRequest.h"

@interface TSDKTrackedItem : TSDKCollectionObject

@property (nonatomic, strong) NSDate *_Nullable createdAt; //Example: 2015-02-25T16:52:38Z
@property (nonatomic, strong) NSDate *_Nullable updatedAt; //Example: 2015-02-25T16:52:38Z
@property (nonatomic, strong) NSString *_Nullable name; //Example: Birth Certificate
@property (nonatomic, strong) NSString *_Nullable teamId; //Example: 71118
@property (nonatomic, strong) NSURL *_Nullable linkTeam;
@property (nonatomic, strong) NSURL *_Nullable linkTrackedItemStatuses;

@end

@interface TSDKTrackedItem (ForwardedMethods)

-(void)getTeamWithConfiguration:(TSDKRequestConfiguration *_Nullable)configuration completion:(TSDKTeamArrayCompletionBlock _Nullable)completion;
-(void)getTrackedItemStatusesWithConfiguration:(TSDKRequestConfiguration *_Nullable)configuration completion:(TSDKTrackedItemStatusArrayCompletionBlock _Nullable)completion;

@end
