//
//  XMMMenuItemTest.m
//  XamoomSDK
//
//  Created by Raphael Seher on 06/10/2016.
//  Copyright © 2016 xamoom GmbH. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XMMMenuItem.h"
#import "XMMCDMenuItem.h"

@interface XMMMenuItemTest : XCTestCase

@end

@implementation XMMMenuItemTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMenuItemResourceName {
  XCTAssertTrue([[XMMMenuItem resourceName] isEqualToString:@"content"]);
}

- (void)testInitWithCoreDataObject {
  XMMMenuItem *testItem = [[XMMMenuItem alloc] init];
  testItem.ID = @"1";
  testItem.contentTitle = @"Test";
  testItem.category = 2;
  
  XMMCDMenuItem *savedMenuItem = [XMMCDMenuItem insertNewObjectFrom:testItem];
  
  XMMMenuItem *newMenuItem = [[XMMMenuItem alloc] initWithCoreDataObject:savedMenuItem];
  
  XCTAssertTrue([newMenuItem.ID isEqualToString:testItem.ID]);
  XCTAssertTrue([newMenuItem.contentTitle isEqualToString:testItem.contentTitle]);
  XCTAssertEqual(newMenuItem.category, testItem.category);
}

@end