//
//  TSDKProfileTimer.m
//  SDKPlayground
//
//  Created by Jason Rahaim on 8/29/15.
//  Copyright © 2015 TeamSnap. All rights reserved.
//

#import "TSDKProfileTimer.h"

@interface TSDKProfileTimer()

@property (strong, nonatomic) NSMutableDictionary *timers;
@property (strong, nonatomic) NSMutableDictionary *totalTimes;

@end

@implementation TSDKProfileTimer

+ (instancetype) sharedInstance {
    static TSDKProfileTimer *_sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[TSDKProfileTimer alloc] init];
    });
    
    return _sharedInstance;
}

-(instancetype) init {
    self = [super init];
    if (self) {
        _timers = [[NSMutableDictionary alloc] init];
        _totalTimes = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void) startTimeWithId:(id)timerId {
    if (!timerId) {
        NSLog(@"About to crash: %@",[NSThread callStackSymbols]);
    }
    [self.timers setObject:[NSDate date] forKey:timerId];
}

-(NSTimeInterval) getElapsedTimeForId:(id)timerId {
    NSTimeInterval elapsedTime = [[NSDate date] timeIntervalSinceDate:[self.timers objectForKey:timerId]];
    [self addElapsedTime:elapsedTime toTotalForId:timerId];
    return elapsedTime;
}

-(NSTimeInterval) getElapsedTimeForId:(id)timerId  logResult:(BOOL)logResult {
    NSTimeInterval elepasedTime = [self getElapsedTimeForId:timerId];
    if (logResult) {
        NSLog(@"Elapsed %@\n %f (%f)", timerId, elepasedTime, [self cumulativeTimeForId:timerId]);
    }
    return elepasedTime;
}

-(void) addElapsedTime:(NSTimeInterval)elapsedTime toTotalForId:(id)timerId {
    NSNumber *totalTimeNumber = [_totalTimes objectForKey:timerId];
    NSTimeInterval totalTime = elapsedTime;
    if (totalTimeNumber) {
        totalTime = elapsedTime + [totalTimeNumber floatValue];
    }
    NSNumber *ETN = [NSNumber numberWithFloat:totalTime];
    [_totalTimes setObject:ETN forKey:timerId];
}

-(NSTimeInterval) cumulativeTimeForId:(id)timerId {
    NSNumber *totalTimeNumber = [_totalTimes objectForKey:timerId];
    if (totalTimeNumber) {
        return [totalTimeNumber floatValue];
    } else {
        return 0.00;
    }
}

- (void)resetTimerWithId:(id)timerId {
    [self.totalTimes removeObjectForKey:timerId];
    [self.timers removeObjectForKey:timerId];
}

- (void)resetAllTimers {
    [self.totalTimes removeAllObjects];
    [self.timers removeAllObjects];
}

@end
