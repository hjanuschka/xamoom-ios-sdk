//
//  XMMOfflineApi.h
//  XamoomSDK
//
//  Created by Raphael Seher on 10/10/2016.
//  Copyright © 2016 xamoom GmbH. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "XMMOptions.h"
#import "XMMParamHelper.h"
#import "XMMSpot.h"
#import "XMMStyle.h"
#import "XMMSystem.h"
#import "XMMMenu.h"
#import "XMMMenuItem.h"
#import "XMMContent.h"
#import "XMMContentBlock.h"
#import "XMMMarker.h"

@interface XMMOfflineApi : NSObject

- (void)contentWithID:(NSString *)contentID completion:(void(^)(XMMContent *content, NSError *error))completion;

- (void)contentWithLocationIdentifier:(NSString *)locationIdentifier completion:(void (^)(XMMContent *content, NSError *error))completion;

- (void)contentsWithLocation:(CLLocation *)location pageSize:(int)pageSize cursor:(NSString *)cursor sort:(XMMContentSortOptions)sortOptions completion:(void (^)(NSArray *contents, bool hasMore, NSString *cursor, NSError *error))completion;

@end