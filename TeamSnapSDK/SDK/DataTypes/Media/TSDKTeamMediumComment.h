//
//  TSDKTeamMediumComment.h
//  TeamSnapSDK
//
// Copyright (c) 2015 TeamSnap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSDKCollectionObject.h"
#import "TSDKObjectsRequest.h"

@interface TSDKTeamMediumComment : TSDKCollectionObject

@property (nonatomic, strong) NSString *_Nullable teamMediumId; //Example: 4147693
@property (nonatomic, strong) NSDate *_Nullable createdAt; //Example: 2016-02-23T14:50:45.000+00:00
@property (nonatomic, strong) NSString *_Nullable memberId; //Example: 993324
@property (nonatomic, strong) NSDate *_Nullable updatedAt; //Example: 2016-02-23T14:50:45.000+00:00
@property (nonatomic, strong) NSString *_Nullable comment; //Example: Up
@property (nonatomic, strong) NSURL *_Nullable linkTeam;
@property (nonatomic, strong) NSURL *_Nullable linkMember;
@property (nonatomic, strong) NSURL *_Nullable linkTeamMedium;

@end

@interface TSDKTeamMediumComment (ForwardedMethods)

-(void)getTeamWithConfiguration:(TSDKRequestConfiguration *_Nullable)configuration completion:(TSDKTeamArrayCompletionBlock _Nullable)completion;
-(void)getMemberWithConfiguration:(TSDKRequestConfiguration *_Nullable)configuration completion:(TSDKMemberArrayCompletionBlock _Nullable)completion;
-(void)getTeamMediumWithConfiguration:(TSDKRequestConfiguration *_Nullable)configuration completion:(TSDKArrayCompletionBlock _Nullable)completion;

@end
