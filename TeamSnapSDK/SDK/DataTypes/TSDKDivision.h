// Copyright (c) 2015 TeamSnap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSDKCollectionObject.h"
#import "TSDKObjectsRequest.h"

@interface TSDKDivision : TSDKCollectionObject

@property (nonatomic, weak) NSString *_Nullable sportId; //Example: 7
@property (nonatomic, weak) NSString *_Nullable leagueUrl; //Example:
@property (nonatomic, assign) BOOL isArchived; //Example: <null>
@property (nonatomic, weak) NSString *_Nullable postalCode; //Example: 75233
@property (nonatomic, weak) NSString *_Nullable timeZoneOffset; //Example: -06:00
@property (nonatomic, weak) NSString *_Nullable country; //Example: United States
@property (nonatomic, weak) NSDate *_Nullable updatedAt; //Example: 2016-08-12T21:38:13Z
@property (nonatomic, assign) NSInteger leftBoundary; //Example: 1
@property (nonatomic, assign) NSInteger rightBoundary; //Example: 6
@property (nonatomic, weak) NSString *_Nullable parentId; //Example: <null>
@property (nonatomic, assign) BOOL isDeletable; //Example: 0
@property (nonatomic, weak) NSString *_Nullable rootId; //Example: 60360
@property (nonatomic, weak) NSString *_Nullable timeZoneIanaName; //Example: America/Chicago
@property (nonatomic, assign) BOOL isDisabled; //Example: 0
@property (nonatomic, weak) NSString *_Nullable name; //Example: Test League
@property (nonatomic, weak) NSString *_Nullable planId; //Example: 33
@property (nonatomic, weak) NSString *_Nullable leagueName; //Example: **NULL**
@property (nonatomic, weak) NSString *_Nullable timeZoneDescription; //Example: Central Time (US & Canada)
@property (nonatomic, weak) NSString *_Nullable seasonName; //Example:
@property (nonatomic, weak) NSString *_Nullable locationCountry; //Example: United States
@property (nonatomic, weak) NSString *_Nullable timeZone; //Example: Central Time (US & Canada)
@property (nonatomic, assign) BOOL isAncestorArchived; //Example: 0
@property (nonatomic, weak) NSDate *_Nullable createdAt; //Example: 2016-01-05T22:59:32Z
@property (nonatomic, weak) NSString *_Nullable parentDivisionName; //Example:
@property (nonatomic, weak) NSString *_Nullable billingAddress; //Example:
@property (nonatomic, weak) NSURL *_Nullable linkParent;
@property (nonatomic, weak) NSURL *_Nullable linkChildren;
@property (nonatomic, weak) NSURL *_Nullable linkAncestors;
@property (nonatomic, weak) NSURL *_Nullable linkDescendants;
@property (nonatomic, weak) NSURL *_Nullable linkRegistrationForms;
@property (nonatomic, weak) NSURL *_Nullable linkPlan;
@property (nonatomic, weak) NSURL *_Nullable linkTeams;
@property (nonatomic, weak) NSURL *_Nullable linkDivisionEvents;
@property (nonatomic, weak) NSURL *_Nullable linkDivisionPreferences;

//Create root divisions, this is an internal command only accessible to internal TeamSnap services.
//+(void)actionCreateRootPostalcode:(NSString *_Nonnull)postalCode country:(NSString *_Nonnull)country timeZone:(NSString *_Nonnull)timeZone name:(NSString *_Nonnull)name teamsInPlan:(NSString *_Nonnull)teamsInPlan sportId:(NSString *_Nonnull)sportId WithCompletion:(TSDKCompletionBlock _Nullable)completion;

//Update the root division plan. This is an internal command only accessible to internal TeamSnap services.
//+(void)actionUpdatePlanPlanid:(NSString *_Nonnull)planId divisionId:(NSString *_Nonnull)divisionId WithCompletion:(TSDKCompletionBlock _Nullable)completion;

//Finds all active trial divisions for a given user. Excludes archived and disabled divisions.
//+(void)queryActiveTrialsUserid:(NSString *_Nonnull)userId WithCompletion:(TSDKCompletionBlock _Nullable)completion;

//+(void)querySearchIsroot:(NSString *_Nonnull)isRoot pageNumber:(NSString *_Nonnull)pageNumber id:(NSString *_Nonnull)id isTrial:(NSString *_Nonnull)isTrial parentId:(NSString *_Nonnull)parentId userId:(NSString *_Nonnull)userId pageSize:(NSString *_Nonnull)pageSize WithCompletion:(TSDKCompletionBlock _Nullable)completion;

//Beta: (This endpoint subject to change) Returns all the nested set descendants of the given division.
//+(void)queryDescendantsId:(NSString *_Nonnull)id WithCompletion:(TSDKCompletionBlock _Nullable)completion;

//Beta: (This endpoint subject to change) Returns all the nested set ancestors of the given division.
//+(void)queryAncestorsId:(NSString *_Nonnull)id WithCompletion:(TSDKCompletionBlock _Nullable)completion;

//Beta: (This endpoint subject to change) Returns all the nested set children of the given division.
//+(void)queryChildrenId:(NSString *_Nonnull)id WithCompletion:(TSDKCompletionBlock _Nullable)completion;

//Beta: (This endpoint subject to change) Returns all the nested set leaves of the given division. A leaf is a division that has no child divisions.
//+(void)queryLeavesId:(NSString *_Nonnull)id WithCompletion:(TSDKCompletionBlock _Nullable)completion;

@end

@interface TSDKDivision (ForwardedMethods)

-(void)getParentWithConfiguration:(TSDKRequestConfiguration *_Nullable)configuration completion:(TSDKArrayCompletionBlock _Nonnull)completion;
-(void)getChildrenWithConfiguration:(TSDKRequestConfiguration *_Nullable)configuration completion:(TSDKArrayCompletionBlock _Nonnull)completion;
-(void)getAncestorsWithConfiguration:(TSDKRequestConfiguration *_Nullable)configuration completion:(TSDKArrayCompletionBlock _Nonnull)completion;
-(void)getDescendantsWithConfiguration:(TSDKRequestConfiguration *_Nullable)configuration completion:(TSDKArrayCompletionBlock _Nonnull)completion;
-(void)getRegistrationFormsWithConfiguration:(TSDKRequestConfiguration *_Nullable)configuration completion:(TSDKArrayCompletionBlock _Nonnull)completion;
-(void)getPlanWithConfiguration:(TSDKRequestConfiguration *_Nullable)configuration completion:(TSDKPlanArrayCompletionBlock _Nonnull)completion;
-(void)getTeamsWithConfiguration:(TSDKRequestConfiguration *_Nullable)configuration completion:(TSDKTeamArrayCompletionBlock _Nonnull)completion;
-(void)getDivisionEventsWithConfiguration:(TSDKRequestConfiguration *_Nullable)configuration completion:(TSDKArrayCompletionBlock _Nonnull)completion;
-(void)getDivisionPreferencesWithConfiguration:(TSDKRequestConfiguration *_Nullable)configuration completion:(TSDKArrayCompletionBlock _Nonnull)completion;


@end
