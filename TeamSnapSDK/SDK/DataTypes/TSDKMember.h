//
//  TSDKRoster.h
//  SDKPlayground
//
// Copyright (c) 2015 TeamSnap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSDKCollectionObject.h"
#import "TSDKObjectsRequest.h"
#import "TSDKProcessBulkObjectProtocol.h"
#import "TSDKMessage.h"
#import "TSDKMessageRecipient.h"
#import "TSDKMessageSender.h"

@protocol TSDKMemberOrContactProtocol <NSObject>

@property (nonatomic, assign) BOOL isPushable; //Example: 1
@property (nonatomic, assign) BOOL isInvitable; //Example: 0
@property (nonatomic, weak) NSString *addressCity; //Example:
@property (nonatomic, assign) BOOL isAddressHidden; //Example: 0
@property (nonatomic, weak) NSString *addressZip; //Example: **NULL**
@property (nonatomic, weak) NSString *invitationCode; //Example: d3e4bd58170967126b089212
@property (nonatomic, assign) NSInteger userId; //Example: **NULL**
@property (nonatomic, weak) NSString *addressState; //Example:
@property (nonatomic, assign) BOOL isAlertable; //Example: 0
@property (nonatomic, weak) NSString *lastName; //Example: Rahaim
@property (nonatomic, assign) BOOL isEmailable; //Example: 0
@property (nonatomic, weak) NSString *addressStreet1; //Example:
@property (nonatomic, weak) NSString *addressStreet2; //Example:
@property (nonatomic, weak) NSString *invitationDeclined; //Example: **NULL**
@property (nonatomic, weak) NSString *firstName; //Example: Jack
@property (nonatomic, weak) NSDate *createdAt; //Example: 2015-11-02T19:01:32Z
@property (nonatomic, weak) NSDate *updatedAt; //Example: 2015-11-18T02:20:03Z
@property (nonatomic, assign) NSInteger teamId; //Example: 71118

@property (readonly) NSString *fullName;
@end

@interface TSDKMember : TSDKCollectionObject <TSDKProcessBulkObjectProtocol, TSDKMessageRecipient, TSDKMessageSender, TSDKMemberOrContactProtocol>

@property (nonatomic, assign) BOOL isPushable; //Example: 1
@property (nonatomic, weak) NSString *lastName; //Example: Invite
@property (nonatomic, weak) NSDate *createdAt; //Example: 2015-11-02T19:01:32Z
@property (nonatomic, assign) NSInteger teamId; //Example: 71118
@property (nonatomic, weak) NSString *hideAddress; //Example: **NULL**
@property (nonatomic, assign) BOOL isOwnershipPending; //Example: <null>
@property (nonatomic, weak) NSString *addressStreet2; //Example: **NULL**
@property (nonatomic, weak) NSString *addressState; //Example: **NULL**
@property (nonatomic, assign) BOOL hasFacebookPostScoresEnabled; //Example: 0
@property (nonatomic, weak) NSString *hideAge; //Example: **NULL**
@property (nonatomic, weak) NSString *invitationDeclined; //Example: **NULL**
@property (nonatomic, assign) BOOL isInvitable; //Example: 1
@property (nonatomic, weak) NSString *addressZip; //Example: **NULL**
@property (nonatomic, weak) NSString *lastLoggedInAt; //Example: **NULL**
@property (nonatomic, weak) NSString *invitationCode; //Example: d3e4bd58170967126b089212
@property (nonatomic, weak) NSString *position; //Example: **NULL**
@property (nonatomic, weak) NSDate *birthday; //Example:
@property (nonatomic, assign) BOOL isEmailable; //Example: 1
@property (nonatomic, assign) BOOL isInvited; //Example: 1
@property (nonatomic, assign) BOOL isActivated; //Example: 0
@property (nonatomic, weak) NSString *addressStreet1; //Example: **NULL**
@property (nonatomic, assign) BOOL isNonPlayer; //Example: 0
@property (nonatomic, weak) NSString *addressCity; //Example: **NULL**
@property (nonatomic, assign) BOOL isAgeHidden; //Example: <null>
@property (nonatomic, weak) NSString *firstName; //Example: 2nd
@property (nonatomic, assign) BOOL isManager; //Example: 0
@property (nonatomic, weak) NSString *jerseyNumber; //Example: **NULL**
@property (nonatomic, assign) NSInteger userId; //Example: **NULL**
@property (nonatomic, weak) NSString *gender; //Example: Male
@property (nonatomic, assign) BOOL isOwner; //Example: 0
@property (nonatomic, assign) BOOL isAddressHidden; //Example: <null>
@property (nonatomic, weak) NSDate *updatedAt; //Example: 2015-11-18T02:20:03Z
@property (nonatomic, assign) BOOL isAlertable; //Example: 0
@property (nonatomic, weak) NSURL *linkBroadcastEmails;
@property (nonatomic, weak) NSURL *linkBroadcastEmailAttachments;
@property (nonatomic, weak) NSURL *linkMemberLinks;
@property (nonatomic, weak) NSURL *linkMemberPreferences;
@property (nonatomic, weak) NSURL *linkTeam;
@property (nonatomic, weak) NSURL *linkMemberPhoneNumbers;
@property (nonatomic, weak) NSURL *linkMessages;
@property (nonatomic, weak) NSURL *linkMemberEmailAddresses;
@property (nonatomic, weak) NSURL *linkStatisticData;
@property (nonatomic, weak) NSURL *linkForumSubscriptions;
@property (nonatomic, weak) NSURL *linkLeagueCustomData;
@property (nonatomic, weak) NSURL *linkContactPhoneNumbers;
@property (nonatomic, weak) NSURL *linkContactEmailAddresses;
@property (nonatomic, weak) NSURL *linkTeamMedia;
@property (nonatomic, weak) NSURL *linkTrackedItemStatuses;
@property (nonatomic, weak) NSURL *linkForumTopics;
@property (nonatomic, weak) NSURL *linkTeamMediumComments;
@property (nonatomic, weak) NSURL *linkCustomFields;
@property (nonatomic, weak) NSURL *linkAssignments;
@property (nonatomic, weak) NSURL *linkCustomData;
@property (nonatomic, weak) NSURL *linkMemberStatistics;
@property (nonatomic, weak) NSURL *linkAvailabilities;
@property (nonatomic, weak) NSURL *linkMemberBalances;
@property (nonatomic, weak) NSURL *linkForumPosts;
@property (nonatomic, weak) NSURL *linkBroadcastAlerts;
@property (nonatomic, weak) NSURL *linkMemberPayments;
@property (nonatomic, weak) NSURL *linkLeagueCustomFields;
@property (nonatomic, weak) NSURL *linkLeagueRegistrantDocuments;
@property (nonatomic, weak) NSURL *linkContacts;
@property (nonatomic, weak) NSURL *linkMemberFiles;
@property (nonatomic, weak) NSURL *linkMemberPhoto;
@property (nonatomic, weak) NSURL *linkMemberThumbnail;

//+(void)actionRemoveMemberPhotoWithCompletion:(TSDKCompletionBlock)completion; //(null)
//+(void)actionDisableMemberWithCompletion:(TSDKCompletionBlock)completion; //(null)
//+(void)actionUploadMemberPhotoWithCompletion:(TSDKCompletionBlock)completion; //(null)
//+(void)actionGenerateMemberThumbnailWithCompletion:(TSDKCompletionBlock)completion; //(null)
//+(void)actionImportFromTeamWithCompletion:(TSDKCompletionBlock)completion; //(null)

// Not AutoGenerated:
#if TARGET_OS_IPHONE
-(void)getMemberPhotoWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKImageCompletionBlock)completion;
-(void)getMemberThumbnailWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKImageCompletionBlock)completion;
#endif

-(TSDKTeam *)team;
@property (strong, nonatomic) NSMutableDictionary *contacts;
@property (strong, nonatomic) NSMutableDictionary *emailAddresses;
@property (strong, nonatomic) NSMutableDictionary *phoneNumbers;


- (BOOL)isAtLeastManager;
- (BOOL)isAtLeastOwner;

- (NSInteger)age;

@end

@interface TSDKMember (ForwardedMethods)

-(void)getBroadcastEmailsWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKBroadcastEmailArrayCompletionBlock)completion;
-(void)getBroadcastEmailAttachmentsWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKArrayCompletionBlock)completion;
-(void)getMemberLinksWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKArrayCompletionBlock)completion;
-(void)getMemberPreferencesWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKMemberPreferencesArrayCompletionBlock)completion;
-(void)getTeamWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKTeamArrayCompletionBlock)completion;
-(void)getMemberPhoneNumbersWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKMemberPhoneNumberArrayCompletionBlock)completion;
-(void)getMessagesWithConfiguration:(TSDKRequestConfiguration *)configuration type:(TSDKMessageType)type completion:(TSDKMessagesArrayCompletionBlock)completion;
-(void)getMemberEmailAddressesWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKMemberEmailAddressArrayCompletionBlock)completion;
-(void)getStatisticDataWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKStatisticDatumArrayCompletionBlock)completion;
-(void)getForumSubscriptionsWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKForumSubscriptionArrayCompletionBlock)completion;
-(void)getLeagueCustomDataWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKArrayCompletionBlock)completion;
-(void)getContactPhoneNumbersWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKContactPhoneNumberArrayCompletionBlock)completion;
-(void)getContactEmailAddressesWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKContactEmailAddressArrayCompletionBlock)completion;
-(void)getTeamMediaWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKArrayCompletionBlock)completion;
-(void)getTrackedItemStatusesWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKTrackedItemStatusArrayCompletionBlock)completion;
-(void)getForumTopicsWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKForumTopicArrayCompletionBlock)completion;
-(void)getTeamMediumCommentsWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKTeamMediumCommentArrayCompletionBlock)completion;
-(void)getCustomFieldsWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKCustomFieldArrayCompletionBlock)completion;
-(void)getAssignmentsWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKAssignmentArrayCompletionBlock)completion;
-(void)getCustomDataWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKCustomDatumArrayCompletionBlock)completion;
-(void)getMemberStatisticsWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKMemberStatisticArrayCompletionBlock)completion;
-(void)getAvailabilitiesWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKAvailabilityArrayCompletionBlock)completion;
-(void)getMemberBalancesWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKMemberBalanceArrayCompletionBlock)completion;
-(void)getUserWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKUserArrayCompletionBlock)completion;
-(void)getForumPostsWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKForumPostArrayCompletionBlock)completion;
-(void)getBroadcastAlertsWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKBroadcastAlertArrayCompletionBlock)completion;
-(void)getMemberPaymentsWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKMemberPaymentArrayCompletionBlock)completion;
-(void)getLeagueCustomFieldsWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKArrayCompletionBlock)completion;
-(void)getLeagueRegistrantDocumentsWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKArrayCompletionBlock)completion;
-(void)getContactsWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKContactArrayCompletionBlock)completion;
-(void)getMemberFilesWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKArrayCompletionBlock)completion;

@end
