//
// Created by Jason Rahaim on 1/30/15.
// Copyright (c) 2015 TeamSnap. All rights reserved.
//

#import "TSDKEvent.h"
#import "NSDate+TSDKConveniences.h"
#import "TSDKAvailabilityGroups.h"
#import "TSDKMember.h"
#import "TSDKOpponent.h"
#import "TSDKTeamSnap.h"
#import "TSDKRootLinks.h"
#import "TSDKCompletionBlockTypes.h"
#import "TSDKEventLineup.h"

NSString * const kRepeatingTypeCode = @"repeating_type_code";

@implementation TSDKEvent {

}

@dynamic opponentName, locationName, uniform, teamId, iconColor, createdAt, opponentId, isGame, label, gameType, shootoutPointsForTeam, shootoutPointsForOpponent, timeZoneDescription, tracksAvailability, isCanceled, sourceTimeZoneIanaName, divisionLocationId, additionalLocationDetails, endDate, isTbd, resultsUrl, isLeagueControlled, name, isShootout, pointsForTeam, locationId, minutesToArriveEarly, formattedResults, startDate, doesntCountTowardsRecord, timeZone, pointsForOpponent, gameTypeCode, timeZoneOffset, arrivalDate, updatedAt, isOvertime, repeatingUuid, results, notes, timeZoneIanaName, durationInMinutes, linkAvailabilities, linkAssignments, linkLocation, linkEventStatistics, linkDivisionLocation, linkSuggestedAssignments, linkMemberAssignments, linkOpponent, linkTeam, linkStatisticData, linkCalendarSingleEvent, linkAssignmentsTeam, linkHealthCheckQuestionnaires;

+ (NSString *)SDKType {
    return @"event";
}

+(void)actionUpdateFinalScoreForEvent:(TSDKEvent *)event completion:(TSDKCompletionBlock)completion {
    if (event) {
        TSDKCollectionCommand *command = [self commandForKey:@"update_final_score"];
        
        TSDKCollectionCommand *commandToSend = [command copy];
        
        for (NSString *key in command.data) {
            if ([event collectionObjectForKey:key]) {
                [commandToSend.data setObject:[event collectionObjectForKey:key] forKey:key];
            } else {
                [commandToSend.data setObject:[NSNull null] forKey:key];
            }
        }
        
        [commandToSend executeWithCompletion:^(BOOL success, BOOL complete, TSDKCollectionJSON *objects, NSError *error) {
            if (completion) {
                completion(success, complete, objects, error);
            }
        }];
    } else {
        completion(NO, NO, nil, nil);
    }

}

- (void)updateFinalScoreWithCompletion:(TSDKSimpleCompletionBlock)completion {
    [TSDKEvent actionUpdateFinalScoreForEvent:self completion:^(BOOL success, BOOL complete, TSDKCollectionJSON *objects, NSError *error) {
        if (success) {
            NSArray *events = [TSDKObjectsRequest SDKObjectsFromCollection:objects];
            if (events.count>0) {
                [self updateWithCollectionFromObject:events.firstObject];
            }
        }
        if (completion) {
            completion(success, error);
        }
    }];
}

- (void)setNotifyTeamAsMember:(TSDKMember *)member {
    if (member) {
        [self setBool:YES forKey:@"notify_team"];
        [self setString:member.objectIdentifier forKey:@"notify_team_as_member_id"];
    } else {
        [self removeCollectionObjectForKey:@"notify_team_as_member_id"];
        [self setBool:NO forKey:@"notify_team"];
    }
}

- (void)saveWithCompletion:(TSDKSaveCompletionBlock)completion {
    // if they call save, don't notify team;
    [TSDKEvent saveEvent:self notifyTeamAsMember:nil completion:^(BOOL success, BOOL complete, NSArray<TSDKEvent *> * _Nullable events, NSError * _Nullable error) {
        if(completion) {
            completion(success, [events firstObject], error);
        }
    }];
}

+ (void)saveEvent:(TSDKEvent * _Nonnull)event notifyTeamAsMember:(TSDKMember * _Nullable)member completion:(TSDKEventArrayCompletionBlock _Nullable)completion {
    [event setNotifyTeamAsMember:member];
    // Until we have better support for Repeating events make sure repeating_include is set to "none"
    if (event.repeatingUuid && ([event getString:@"repeating_include"] == nil)) {
        [event setChangedValue:event.repeatingUuid forKey:@"repeating_uuid"];
        [event setEditMode:TSDKEventEditModeSingle];
    }
    [event saveWithURL:[event urlForSave] completion:completion];
}

- (void)deleteWithCompletion:(TSDKSimpleCompletionBlock)completion {
    [self deleteAndShouldNotifyTeamAsRosterMember:nil completion:completion];
}

- (void)deleteAndShouldNotifyTeamAsRosterMember:(TSDKMember *)member completion:(TSDKSimpleCompletionBlock)completion {
    [self setNotifyTeamAsMember:member];

    if (self.repeatingUuid && ([self getString:@"repeating_include"] == nil)) {
        [self setChangedValue:self.repeatingUuid forKey:@"repeating_uuid"];
        [self setString:@"none" forKey:@"repeating_include"];
    }
    [super deleteWithCompletion:completion];
}


-(void)getAvailabilitiesWithConfiguration:(TSDKRequestConfiguration *)configuration completion:(TSDKAvailabilityGroupCompletionBlock)completion {
    [self arrayFromLink:self.linkAvailabilities withConfiguration:configuration completion:^(BOOL success, BOOL complete, NSArray *objects, NSError *error) {
        TSDKAvailabilityGroups *availability = nil;
        if (success) {
            availability = [[TSDKAvailabilityGroups alloc] initWithAvailabilityArray:objects];
        }
        if (completion) {
            completion(success, complete, availability, error);
        }
    }];
}

- (TSDKEventEditMode)editMode {
    if(self.repeatingUuid.length == 0) {
        return TSDKEventEditModeSingle;
    } else {
        NSString *repeatingMode  = [[self getString:@"repeating_include"] lowercaseString];
        if([repeatingMode isEqualToString:@"all"]) {
            return TSDKEventEditModeRepeatingAll;
        } else if([repeatingMode isEqualToString:@"future"]) {
            return TSDKEventEditModeRepeatingFuture;
        } else {
            return TSDKEventEditModeSingle;
        }
    }
}

- (void)setEditMode:(TSDKEventEditMode)editMode {
    switch (editMode) {
        case TSDKEventEditModeSingle:
            [self setString:@"none" forKey:@"repeating_include"];
            break;
        case TSDKEventEditModeRepeatingAll:
            [self setString:@"all" forKey:@"repeating_include"];
        case TSDKEventEditModeRepeatingFuture:
            [self setString:@"future" forKey:@"repeating_include"];
    }
}

- (NSComparisonResult)compareStartDate:(TSDKEvent *)compareEvent {
    if (self.isTbd && compareEvent.isTbd) {
        return [self.startDate compare:compareEvent.startDate];
    } else if (self.isTbd && (compareEvent.isTbd == NO)) {
        if ([self isSameDayAs:compareEvent]) {
            return NSOrderedAscending;
        } else {
            return [self.startDate compare:compareEvent.startDate];
        }
    } else if ((self.isTbd == NO)  && compareEvent.isTbd) {
        if ([self isSameDayAs:compareEvent]) {
            return NSOrderedDescending;
        } else {
            return [self.startDate compare:compareEvent.startDate];
        }
    } else {
        return [self.startDate compare:compareEvent.startDate];
    }
}

- (BOOL)isSameDayAs:(TSDKEvent *)eventToCompare {
    NSCalendar *firstEventCal = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *firstEventTimeZone = [NSTimeZone timeZoneWithName:self.timeZoneIanaName];
    if(firstEventTimeZone) {
        firstEventCal.timeZone = firstEventTimeZone;
    }
    
    NSCalendar *secondEventCal = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *secondEventTimeZone = [NSTimeZone timeZoneWithName:eventToCompare.timeZoneIanaName];
    if(secondEventTimeZone) {
        secondEventCal.timeZone = secondEventTimeZone;
    }
    
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [firstEventCal components:unitFlags fromDate:self.startDate];
    NSDateComponents* comp2 = [secondEventCal components:unitFlags fromDate:eventToCompare.startDate];
    
    return ([comp1 day] == [comp2 day] &&
            [comp1 month] == [comp2 month] &&
            [comp1 year]  == [comp2 year]);
}

- (NSString *_Nullable)displayNameWithShortLabelPreference:(BOOL)preferShortLabel {
    if (self.isGame && self.opponentName.length > 0) {
        if ([[self.gameType uppercaseString] isEqualToString:@"AWAY"]) {
            if ((self.label) && (![self.label isEqualToString:@""])) {
                return [NSString stringWithFormat:NSLocalizedString(@"EVENT-%1$@ at %2$@", @"Indicating there is an Event Named #1 at opponent #2"), self.label, self.opponentName];
            } else {
                return [NSString stringWithFormat:NSLocalizedString(@"EVENT-at %@", @"Indicating there is an Event at OPPONENT"), self.opponentName];
            }
        } else {
            if (self.label && (![self.label isEqualToString:@""])) {
                return [NSString stringWithFormat:NSLocalizedString(@"EVENT-%1$@ vs. %2$@", @"Indicating there is an Event Named #1 against opponent #2"), self.label, self.opponentName];
            } else {
                return [NSString stringWithFormat:NSLocalizedString(@"EVENT-vs. %@", @"Indicating there is an Event against OPPONENT"), self.opponentName];
            }
        }
    } else {
        if(preferShortLabel && self.label.length) {
            return self.label;
        }
        
        if (!self.name || (self.name.length == 0)) {
            return NSLocalizedString(@"Event", nil);
        } else {
            return self.name;
        }
    }
}

- (TSDKRepeatingEventTypeCode)repeatingTypeCode {
    if ([self collectionObjectForKey:kRepeatingTypeCode]) {
        return [self getInteger:kRepeatingTypeCode];
    } else {
        return TSDKEventDoesNotRepeat;
    }
}

- (void)setRepeatingTypeCode:(TSDKRepeatingEventTypeCode)repeatingTypeCode {
    if (repeatingTypeCode == 0) {
        [self removeCollectionObjectForKey:kRepeatingTypeCode];
    } else {
        [self setInteger:repeatingTypeCode forKey:kRepeatingTypeCode];
    }
}

- (TSDKGameTypeCode)gameTypeCode {
    NSInteger typeCode = [self getInteger:@"game_type_code"];
    if (typeCode == NSNotFound) {
        return TSDKGameTypeCodeUnknown;
    } else {
        return typeCode;
    }
}

+ (void)getEventWithId:(NSString * _Nonnull)eventId teamId:(NSString * _Nonnull)teamId completion:(TSDKEventCompletionBlock _Nonnull)completion {
    NSURL *baseEventSearchURL = [[[[TSDKTeamSnap sharedInstance] rootLinks] linkEvents] URLByAppendingPathComponent:@"search"];
    if(baseEventSearchURL) {
        NSDictionary *searchParams = @{@"team_id" : teamId, @"id" : eventId};
        [TSDKEvent arrayFromLink:baseEventSearchURL searchParams:searchParams withConfiguration:[TSDKRequestConfiguration defaultRequestConfiguration] completion:^(BOOL success, BOOL complete, NSArray * _Nonnull objects, NSError * _Nullable error) {
            TSDKEvent *matchingEvent;
            for(TSDKEvent *event in objects) {
                if([event.objectIdentifier isEqualToString:eventId]) {
                    matchingEvent = event;
                }
            }
            if(matchingEvent) {
                completion(YES, matchingEvent, nil);
            } else {
                completion(NO, nil, error);
            }
        }];
    } else {
        completion(NO, nil, nil);
    }
}

@end
