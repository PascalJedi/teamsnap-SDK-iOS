//
//  NSMutableDictionary+refreshCollectionData.m
//  TeamSnapSDK
//
//  Created by Jason Rahaim on 1/11/16.
//  Copyright © 2016 teamsnap. All rights reserved.
//

#import "NSMutableDictionary+refreshCollectionData.h"

@implementation NSMutableDictionary (refreshCollectionData)

- (void)refreshCollectionObject:(TSDKCollectionObject *)object {
    TSDKCollectionObject *storedObject = [self objectForKey:object.objectIdentifier];
    if (storedObject) {
        [storedObject updateWithCollectionFromObject:object];
    } else {
        [self setObject:object forKey:object.objectIdentifier];
    }
}

@end
