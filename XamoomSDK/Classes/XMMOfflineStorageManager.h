//
//  XMMOfflineStorageManager.h
//  XamoomSDK
//
//  Created by Raphael Seher on 29/09/2016.
//  Copyright © 2016 xamoom GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "XMMOfflineFileManager.h"

@interface XMMOfflineStorageManager : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) XMMOfflineFileManager *fileManager;

extern NSString *const kManagedContextReadyNotification;

+ (instancetype)sharedInstance;

#pragma mark - CoreData

- (NSError *)save;

- (NSArray *)fetchAll:(NSString *)entityType;

- (NSArray *)fetch:(NSString *)entityType predicate:(NSPredicate *)predicate;

- (NSArray *)fetch:(NSString *)entityType jsonID:(NSString *)jsonID;

- (void)deleteAllEntities;

@end
