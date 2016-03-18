//
//  TSDKNotification.h
//  TeamSnapSDK
//
//  Created by Jason Rahaim on 3/17/16.
//  Copyright © 2016 teamsnap. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * _Nonnull const TSDKNotificationsForObject;
extern NSString * _Nonnull const TSDKNotificationsForObjectClass;

extern NSString * _Nonnull const TSDKObectSaved;
extern NSString * _Nonnull const TSDKObjectAdded;
extern NSString * _Nonnull const TSDKObjectRefreshed;
extern NSString * _Nonnull const TSDKObjectDeleted;

@class  TSDKCollectionObject;

@interface TSDKNotifications : NSObject

+ (void)postSavedObject:(TSDKCollectionObject * _Nonnull)notificationObject;
+ (void)postNewObject:(TSDKCollectionObject * _Nonnull)notificationObject;
+ (void)postRefreshedObject:(TSDKCollectionObject * _Nonnull)notificationObject;
+ (void)postDeletedObject:(TSDKCollectionObject * _Nonnull)notificationObject;

+ (void)listenToChangesToObject:(TSDKCollectionObject * _Nonnull)collectionObject withObserver:(id _Nonnull)observer selector:(SEL _Nonnull)selector;
+ (void)listenToAllObjectChangesObserver:(id _Nonnull)observer selector:(SEL _Nonnull)selector;
+ (void)listenToChangesToObjectClass:(Class _Nonnull)class withObserver:(id _Nonnull)observer selector:(SEL _Nonnull)selector;

@end
