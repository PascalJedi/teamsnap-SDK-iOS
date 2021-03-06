//
//  TSDKMemberAssignment.h
//  SDKDeveloperTools
//
// Copyright (c) 2015 TeamSnap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSDKCollectionObject.h"
#import "TSDKObjectsRequest.h"

@interface TSDKMemberAssignment : TSDKCollectionObject

@property (nonatomic, strong) NSString *_Nullable updatedAt; //Example: **NULL**
@property (nonatomic, strong) NSString *_Nullable createdAt; //Example: **NULL**
@property (nonatomic, assign) BOOL managerCreated; //Example: 1
@property (nonatomic, strong) NSString *_Nullable assignmentId; //Example: 242266
@property (nonatomic, strong) NSString *_Nullable memberId; //Example: 1282395
@property (nonatomic, strong) NSString *_Nullable eventId; //Example: 2781974
@property (nonatomic, strong) NSString *_Nullable teamId; //Example: 71118
@property (nonatomic, strong) NSURL *_Nullable linkMember;
@property (nonatomic, strong) NSURL *_Nullable linkAssignment;
@property (nonatomic, strong) NSURL *_Nullable linkEvent;
@property (nonatomic, strong) NSURL *_Nullable linkTeam;


@end

@interface TSDKMemberAssignment (ForwardedMethods)

-(void)getMemberWithConfiguration:(TSDKRequestConfiguration *_Nullable)configuration completion:(TSDKMemberArrayCompletionBlock _Nullable)completion;
-(void)getAssignmentWithConfiguration:(TSDKRequestConfiguration *_Nullable)configuration completion:(TSDKAssignmentArrayCompletionBlock _Nullable)completion;
-(void)getEventWithConfiguration:(TSDKRequestConfiguration *_Nullable)configuration completion:(TSDKEventArrayCompletionBlock _Nullable)completion;
-(void)getTeamWithConfiguration:(TSDKRequestConfiguration *_Nullable)configuration completion:(TSDKTeamArrayCompletionBlock _Nullable)completion;


@end
