//
//  TSDKRequestConfiguration.m
//  TeamSnapSDK
//
//  Created by Jason Rahaim on 2/22/16.
//  Copyright © 2016 teamsnap. All rights reserved.
//

#import "TSDKRequestConfiguration.h"

@implementation TSDKRequestConfiguration

- (instancetype)init {
    self = [super init];
    if (self) {
        _forceReload = NO;
    }
    return self;
}

@end
