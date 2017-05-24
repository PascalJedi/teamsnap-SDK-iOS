//
//  TSDKCollectionObject.h
//  TeamSnapSDK
//
//  Created by Jason Rahaim on 1/17/14.
//  Copyright (c) 2014 TeamSnap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSDKRequestConfiguration.h"
#import <CoreGraphics/CGBase.h>
#import "TSDKObjectsRequest.h"
#import "TSDKCollectionQuery.h"
#import "TSDKCollectionCommand.h"

NS_ASSUME_NONNULL_BEGIN

@class TSDKCollectionJSON;

@protocol TSDKCollectionObjectBundledDataProtocol <NSObject>

+ (NSURL *_Nullable)bundledFileURL;

@end

@interface TSDKCollectionObject : NSObject <NSCoding>

@property (nonatomic, strong) TSDKCollectionJSON *_Nullable collection;
@property (nonatomic, strong) NSMutableDictionary *_Nullable changedValues;
@property (nonatomic, assign) BOOL logHeader;
@property (nonatomic, strong) NSDate *_Nullable lastUpdate;

- (instancetype )initWithCollection:(TSDKCollectionJSON *)collection;
+ (id _Nullable)objectWithObject:(TSDKCollectionObject *)originalObject;
+ (void)dumpClassSelectorInfo;
+(NSDictionary *_Nullable)template;
+(NSDictionary *_Nullable)templateForClass:(NSString *)className;
+(void)setTemplate:(NSDictionary *_Nullable)template;
+(void)setTemplate:(NSDictionary *_Nullable)template forClass:(NSString *_Nullable)className;
+(NSMutableDictionary *_Nullable)commands;
+(TSDKCollectionCommand *_Nullable)commandForKey:(NSString *)commandName;
+(NSMutableDictionary *_Nullable)commandsForClass:(NSString *)className;
+(TSDKCollectionCommand *_Nullable)commandForClass:(NSString *)className forKey:(NSString *)commandName;

+ (NSMutableDictionary *_Nullable)queries;
+(TSDKCollectionQuery *_Nullable)queryForKey:(NSString *)commandName;
+(NSMutableDictionary *_Nullable)queriesForClass:(NSString *)className;
+(TSDKCollectionQuery *_Nullable)queryForClass:(NSString *)className forKey:(NSString *)queryName;

+(NSURL *_Nullable)classURL;
+(void)setClassURL:(NSURL *_Nullable)URL;

+ (NSString *_Nullable)SDKType;
+ (NSString *_Nullable)SDKREL;
+ (NSString *_Nullable)completionBlockTypeName;
+ (NSString *_Nullable)completionBlockArrayDescription;

- (NSString *)objectIdentifier;
- (NSString * )objectIdentifierForKey:(NSString *)key;
- (BOOL)isEqualToCollectionObject:(TSDKCollectionObject *)collectionObject;

- (NSDictionary *_Nullable)dataToSave;
- (NSString *_Nullable)getString:(NSString *)key;
- (void)setString:(NSString *_Nullable)value forKey:(NSString *)aKey;
- (NSInteger)getInteger:(NSString *)key;
- (void)setInteger:(NSInteger)value forKey:(NSString *)aKey;
- (NSDate *_Nullable)getDate:(NSString *)key;
- (void)setDate:(NSDate *_Nullable)value forKey:(NSString *)aKey;
- (BOOL)getBool:(NSString *)key;
- (void)setBool:(BOOL)value forKey:(NSString *)aKey;
- (CGFloat)getCGFloat:(NSString *)key;
- (void)setCGFloat:(CGFloat)value forKey:(NSString *)aKey;

- (void)setArray:(NSArray <NSString *> *_Nullable)value forKey:(NSString *)aKey;
- (NSArray <NSString *> *_Nullable)getArrayForKey:(NSString *)key;

- (NSURL *_Nullable)getLink:(NSString *)aKey;
- (void)encodeWithCoder:(NSCoder *)coder;
- (BOOL)isNewObject;
- (void)undoChanges;
- (void)saveWithCompletion:(TSDKSaveCompletionBlock _Nullable)completion;
- (void)saveWithCustomURLQuery:(NSArray <NSURLQueryItem *> * )queryItems completion:(TSDKSaveCompletionBlock _Nullable)completion;
- (void)deleteWithCompletion:(TSDKSimpleCompletionBlock _Nullable)completion;

- (void)refreshDataWithCompletion:(TSDKArrayCompletionBlock _Nullable)completion;
+ (void)arrayFromFileLink:(NSURL *)link completion:(TSDKArrayCompletionBlock _Nullable)completion;
- (void)arrayFromLink:(NSURL *)link searchParams:(NSDictionary <NSString *, id>*_Nullable)searchParams withConfiguration:(TSDKRequestConfiguration *_Nullable)configuration completion:(TSDKArrayCompletionBlock _Nullable) completion;
- (void)arrayFromLink:(NSURL *)link withConfiguration:(TSDKRequestConfiguration *_Nullable)configuration completion:(TSDKArrayCompletionBlock _Nullable)completion;

- (BOOL)writeToFileURL:(NSURL *)fileURL;
+ (instancetype _Nullable)collectionObjectFromDataInFileURL:(NSURL *)fileURL;

@end

NS_ASSUME_NONNULL_END
