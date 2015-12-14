//
// Created by Jason Rahaim on 1/29/15.
// Copyright (c) 2015 TeamSnap. All rights reserved.
//

#import "TSDKTeam.h"
#import "TSDKObjectsRequest.h"
#import "TSDKProfileTimer.h"
#import "TSDKEvent.h"
#import "TSDKMember.h"
#import "TSDKTeamSnap.h"
#import "TSDKPlan.h"
#import "TSDKTeamResults.h"
#import "TSDKTeamPreferences.h"
#import "NSMutableDictionary+integerKey.h"

@interface TSDKTeam()
@property (nonatomic, strong) NSMutableDictionary *members;
@property (nonatomic, strong) NSMutableDictionary *events;

@property (nonatomic, strong) NSMutableArray *sortedEvents;
@property (nonatomic, strong) NSMutableArray *sortedMembers;

@end

@implementation TSDKTeam {
    
}

@dynamic canExportMedia, leagueUrl, isInLeague, hasReachedRosterLimit, timeZoneOffset, locationLatitude, updatedAt, hasExportableMedia, timeZoneIanaName, locationPostalCode, name, locationLongitude, planId, leagueName, timeZoneDescription, rosterLimit, seasonName, locationCountry, divisionName, createdAt, isArchivedSeason, sportId, linkTeamMediaGroups, linkContactEmailAddresses, linkAvailabilities, linkForumTopics, linkMembersPreferences, linkOwner, linkDivisionMembersPreferences, linkTeamMediumComments, linkForumSubscriptions, linkEvents, linkTeamPaypalPreferences, linkForumPosts, linkTeamMedia, linkSport, linkCalendarWebcal, linkContacts, linkMembersCsvExport, linkTrackedItemStatuses, linkManagers, linkLeagueRegistrantDocuments, linkDivisionLocations, linkOpponents, linkCalendarHttpGamesOnly, linkCustomData, linkTeamPreferences, linkCalendarHttp, linkDivisionTeamStandings, linkPaymentNotes, linkPlan, linkTeamFees, linkMemberPhoneNumbers, linkMemberLinks, linkDivisionMembers, linkBroadcastEmailAttachments, linkTeamStatistics, linkMemberEmailAddresses, linkStatistics, linkMembers, linkSponsors, linkMemberBalances, linkBroadcastSmses, linkMemberStatistics, linkStatisticGroups, linkOpponentsResults, linkPaypalCurrency, linkTrackedItems, linkAssignments, linkTeamResults, linkLeagueCustomData, linkStatisticData, linkContactPhoneNumbers, linkMemberFiles, linkMemberPayments, linkLeagueCustomFields, linkCustomFields, linkLocations, linkBroadcastEmails, linkEventsCsvExport, linkCalendarWebcalGamesOnly, linkTeamPublicSite;

+ (NSString *)SDKType {
    return @"team";
}


- (id)init {
    self = [super init];
    if (self) {
        _members = [[NSMutableDictionary alloc] init];
        _events = [[NSMutableDictionary alloc] init];
        _membersUpdated = nil;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _members = [aDecoder decodeObjectForKey:@"membersArray"];
        _events = [aDecoder decodeObjectForKey:@"eventsArray"];
    }
    return self;
}

- (instancetype)initWithName:(NSString *)name locationCountry:(NSString *)locationContry locationPostalCode:(NSString *)locationPostalCode ianaTimeZoneName:(NSString *)ianaTimeZoneName sportId:(NSInteger)sportId {
    self = [self init];
    if (self) {
        self.name = name;
        self.locationCountry = locationContry;
        self.locationPostalCode = locationPostalCode;
        self.timeZoneIanaName  = ianaTimeZoneName;
        self.collection.data[@"time_zone"] = ianaTimeZoneName;
        self.sportId = sportId;
    }
    return self;
}

- (void)setTimeZone:(NSTimeZone *)timeZone {
    [self setTimeZoneIanaName:timeZone.name];
}

- (NSTimeZone *)timeZone {
    return [NSTimeZone timeZoneWithName:self.timeZoneIanaName];
}

- (TSDKPlan *)plan {
    return [[TSDKTeamSnap sharedInstance] planWithId:self.planId];
}

- (void)setPlan:(TSDKPlan *)plan {
    self.planId = plan.objectIdentifier;
}

- (void)getTeamPreferencesWithCompletion:(TSDKArrayCompletionBlock)completion {
    [super arrayFromLink:[self linkTeamPreferences] WithCompletion:^(BOOL success, BOOL complete, NSArray *objects, NSError *error) {
        if (success && objects.count>=1) {
            [self processBulkLoadedObject:[objects objectAtIndex:0]];
        }
        if (completion) {
            completion(success, YES, objects, error);
        }
    }];
}

- (void)getTeamResultsWithCompletion:(TSDKArrayCompletionBlock)completion {
    [super arrayFromLink:[self linkTeamResults] WithCompletion:^(BOOL success, BOOL complete, NSArray *objects, NSError *error) {
        if (success && objects.count>=1) {
            [self processBulkLoadedObject:[objects objectAtIndex:0]];
        }
        if (completion) {
            completion(success, YES, objects, error);
        }
    }];
}

#pragma mark -
#pragma mark TSDKProcessBulkObjectProtocol
- (BOOL)processBulkLoadedObject:(TSDKCollectionObject *)bulkObject {
    BOOL lProcessed = NO;
    
    NSLog(@"\nProcess Team: %@ (%ld) - %@ (%ld)", self.name, (long)self.objectIdentifier, [bulkObject class], (long)bulkObject.objectIdentifier);
    if ([bulkObject isKindOfClass:[TSDKEvent class]]) {
        [self addEvent:(TSDKEvent *)bulkObject];
        self.eventsUpdated = [NSDate date];
        lProcessed = YES;
    } else if ([bulkObject isKindOfClass:[TSDKMember class]]) {
        [self addMember:(TSDKMember *)bulkObject];
        self.membersUpdated = [NSDate date];
        lProcessed = YES;
    } else if ([bulkObject isKindOfClass:[TSDKTeamPreferences class]]) {
        NSLog(@"\nProcess Team Preferences: %@ (%ld)", self.name, (long)self.objectIdentifier);
        self.teamPrefrences = (TSDKTeamPreferences *)bulkObject;
        lProcessed = YES;
    } else if ([bulkObject isKindOfClass:[TSDKTeamResults class]]) {
        self.teamResults = (TSDKTeamResults *)bulkObject;
        lProcessed = YES;
    }
    if (!lProcessed && [bulkObject.collection.data objectForKey:@"member_id"]) {
        NSInteger memberId = [[bulkObject.collection.data objectForKey:@"member_id"] integerValue];
        TSDKMember *member = [self memberWithID:memberId];
        if (member) {
            lProcessed = [member processBulkLoadedObject:(TSDKCollectionObject *)bulkObject];
        }
    }
    return lProcessed;
}

- (void)addEvent:(TSDKEvent *)event {
    [self.events setObject:event forIntegerKey:event.objectIdentifier];
    [self dirtySortedEventLists];
}

- (void)addMember:(TSDKMember *)member {
    [member setTeam:self];
    [self.members setObject:member forIntegerKey:member.objectIdentifier];
    [self dirtySortedMemberLists];
}

- (TSDKMember *)memberWithID:(NSInteger)memberId {
    return [self.members objectForIntegerKey:memberId];
}

- (NSArray *)membersWithUserId:(NSInteger)userId {
    NSArray *arrayOfMembers = [self.members allValues];
    
    NSIndexSet *indexSet = [arrayOfMembers indexesOfObjectsPassingTest:^BOOL(TSDKMember *member, NSUInteger idx, BOOL * _Nonnull stop) {
        return (member.userId == userId);
    }];
    return [arrayOfMembers objectsAtIndexes:indexSet];
}

- (void)dirtySortedEventLists {
    self.sortedEvents = nil;
}

- (void)dirtySortedMemberLists {
    self.sortedMembers = nil;
}

- (NSArray *)sortedMembers {
    if (!_sortedMembers) {
        _sortedMembers = [NSMutableArray arrayWithArray:[_members allValues]];
        [_sortedMembers sortUsingComparator:^NSComparisonResult(TSDKMember *member1, TSDKMember *member2) {
            return [member1.fullName compare:member2.fullName];
        }];
    }
    return _sortedMembers;
}

- (NSArray *)eventsSorted {
    if (!self.sortedEvents) {
        self.sortedEvents = [NSMutableArray arrayWithArray:[self.events allValues]];
        [self.sortedEvents sortUsingComparator:^NSComparisonResult(TSDKEvent *event1, TSDKEvent *event2) {
            return [event1.startDate compare:event2.startDate];
        }];
    }
    return self.sortedEvents;
}

- (void)bulkLoadImportantDataWithCompletion:(TSDKArrayCompletionBlock)completion {
    [[TSDKProfileTimer sharedInstance] startTimeWithId:@"BulkLoadTeamImportant"];
    [TSDKObjectsRequest bulkLoadTeamData:self types:@[@"team", @"event", @"member", @"custom_field", @"custom_datum", @"league_custom_field", @"league_custom_datum",@"location", @"opponent", @"team_preferences", @"plan"] completion:^(BOOL success, BOOL complete, NSArray *objects, NSError *error) {
        [[TSDKProfileTimer sharedInstance] getElapsedTimeForId:@"BulkLoadTeamImportant" logResult:YES];
        if (completion) {            
            completion(success, complete, objects, error);
        }
    }];
}


- (void)bulkLoadDataWithCompleteion:(TSDKArrayCompletionBlock)completion {
    [[TSDKProfileTimer sharedInstance] startTimeWithId:@"BulkLoadTeam"];
    [TSDKObjectsRequest bulkLoadTeamData:self types:@[@"team", @"team_results", @"event", @"member", @"assignment", @"broadcast_email", @"broadcast_sms", @"custom_field", @"custom_datum", @"league_custom_field", @"league_custom_datum", @"forum_topic", @"forum_post", @"location", @"opponent", @"team_fee", @"tracked_item", @"tracked_item_status", @"team_statistic",@"statistic", @"statistic_datum", @"statistic_group", @"sport",@"member_statistic", @"team_preferences", @"plan"] completion:^(BOOL success, BOOL complete, NSArray *objects, NSError *error) {
        [[TSDKProfileTimer sharedInstance] getElapsedTimeForId:@"BulkLoadTeam" logResult:YES];
        if (completion) {
            completion(success, complete, objects, error);
        }
    }];
}

- (void)membersWithCompletion:(TSDKArrayCompletionBlock)completion {
    if (self.membersUpdated && self.sortedMembers) {
        if (completion) {
            completion(YES, YES, self.sortedMembers, nil);
        }
    } else {
        [TSDKObjectsRequest listRosterForTeam:self completion:^(BOOL success, BOOL complete, NSArray *objects, NSError *error) {
            [self.members removeAllObjects];
            for (TSDKMember *member in objects) {
                [self.members setObject:member forIntegerKey:member.objectIdentifier];
            }
            self.membersUpdated = [NSDate date];
            if (completion) {
                completion(success, complete, self.sortedMembers, error);
            }
        }];
    }
}

- (void)allEventsWithCompletion:(TSDKArrayCompletionBlock)completion {
    if (self.eventsUpdated) {
        if (completion) {
            completion(YES, YES, self.eventsSorted, nil);
        }
    } else {
        [TSDKObjectsRequest listEventsForTeam:self completion:^(BOOL success, BOOL complete, NSArray *objects, NSError *error) {
            if (completion) {
                completion(success, complete, objects, error);
            }
        }];
    }
}

- (void)eventsInDateRange:(NSDate *)startDate endDate:(NSDate *)endDate completion:(TSDKArrayCompletionBlock)completion {
    [TSDKObjectsRequest listEventsForTeam:self startDate:(NSDate *)startDate endDate:(NSDate *)endDate completion:^(BOOL success, BOOL complete, NSArray *objects, NSError *error) {
        if (completion) {
            completion(success, complete, objects, error);
        }
    }];
}

- (void)trackedItems:(TSDKArrayCompletionBlock)completion {
    [TSDKObjectsRequest listTrackedItemsForTeam:self completion:^(BOOL success, BOOL complete, NSArray *objects, NSError *error) {
        if (completion) {
            completion(success, complete, objects, error);
        }
    }];
    
}

-(void)getTeamLogoWithCompletion:(TSDKImageCompletionBlock)completion {
    if ([self.teamPrefrences linkTeamLogo]) {
        [self.teamPrefrences getTeamLogoWithCompletion:completion];
    } else {
        if (completion) {
            completion(nil);
        }
    }
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    //[coder encodeObject:_rosters forKey:@"rosterArray"];
    //[coder encodeObject:_events forKey:@"eventsArray"];
}

@end