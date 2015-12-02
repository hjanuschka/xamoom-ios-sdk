//
//  Tests.m
//  Tests
//
//  Created by Raphael Seher on 23.11.15.
//  Copyright © 2015 xamoom GmbH. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import <xamoom-ios-sdk/XMMEnduserApi.h>

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp {
  [super setUp];
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  [super tearDown];
}

- (void)testThatSharedInstanceReturnsXMMEnduserApi {
  XCTAssertNotNil([XMMEnduserApi sharedInstance]);
}

- (void)testThatSharedInstanceReturnsSameInstance {
  XMMEnduserApi *api = [XMMEnduserApi sharedInstance];
  XCTAssertEqualObjects(api, [XMMEnduserApi sharedInstance]);
}

- (void)testThatSharedInstanceIsXMMEnduserApi {
  XCTAssertTrue([XMMEnduserApi sharedInstance].class == [XMMEnduserApi class]);
}

- (void)testThatInitReturnsXMMEnduserApi {
  XMMEnduserApi *api = [[XMMEnduserApi alloc] init];
  XCTAssertNotNil(api);
  XCTAssertTrue(api.class == [XMMEnduserApi class]);
  XCTAssertNotNil([XMMEnduserApi sharedInstance].systemLanguage);
  XCTAssertTrue([[XMMEnduserApi sharedInstance].qrCodeViewControllerCancelButtonTitle isEqualToString:@"Cancel"]);
  XCTAssertNotNil([XMMEnduserApi sharedInstance].objectManager);
}

- (void)testThatInitSetsProperties {
  XCTAssertNotNil([XMMEnduserApi sharedInstance].systemLanguage);
  XCTAssertTrue([[XMMEnduserApi sharedInstance].qrCodeViewControllerCancelButtonTitle isEqualToString:@"Cancel"]);
}

- (void)testThatAPIKeyGetsSet {
  NSString *apikey = @"Hellyeah";
  [[XMMEnduserApi sharedInstance] setApiKey:apikey];
  
  NSString *checkApikey = [[XMMEnduserApi sharedInstance].objectManager.defaultHeaders valueForKey:@"Authorization"];
  XCTAssertEqual(apikey, checkApikey);
}

#pragma mark - Systemlanguage

- (void)testThatSystemLanguageGetsSet {
  NSLog(@"Test Suite - testSystemLanguage");
  
  XCTAssertNotNil([XMMEnduserApi sharedInstance].systemLanguage, @"api.systemLanguage should not be nil");
}

- (void)testThatInitReturnsLanguageWithoutRegionCode {
  XMMEnduserApi *api = [[XMMEnduserApi alloc] init];
  api.systemLanguage = @"en";
}

#pragma mark - contentWithId

- (void)testThatContentWithContentIdCallsApiPostWithPath {
  id mockedApi = OCMPartialMock([[XMMEnduserApi alloc] init]);
  
  [[[mockedApi stub] andDo:^(NSInvocation *invocation) {
    void (^stubResponse)(XMMContentById *result);
    [invocation getArgument:&stubResponse atIndex:5];
    XMMContentById *content = [[XMMContentById alloc] init];
    content.systemName = @"Hello";
    stubResponse(content);
  }] apiPostWithPath:[OCMArg any] andDescriptor:[OCMArg any] andParams:[OCMArg any] completion:[OCMArg any] error:[OCMArg any]];
  
  [mockedApi contentWithContentId:@"1" includeStyle:NO includeMenu:NO withLanguage:@"de" full:NO completion:^(XMMContentById *result) {
    XCTAssertEqual(result.systemName, @"Hello");
  } error:nil];
  
  OCMVerify([mockedApi apiPostWithPath:[OCMArg isEqual:@"xamoomEndUserApi/v1/get_content_by_content_id_full"]
                         andDescriptor:[OCMArg any]
                             andParams:[OCMArg any]
                            completion:[OCMArg any]
                                 error:[OCMArg any]]);
}

- (void)testThatContentWithContentIdCreatesParametersWithFalse {
  id mockedApi = OCMPartialMock([[XMMEnduserApi alloc] init]);
  
  NSDictionary *checkDict = @{@"content_id":@"1",
                              @"include_style":@"False",
                              @"include_menu":@"False",
                              @"language":@"de",
                              @"full":@"False",};
  
  [mockedApi contentWithContentId:@"1"
                     includeStyle:NO
                      includeMenu:NO
                     withLanguage:@"de"
                             full:NO completion:nil error:nil];
  
  OCMVerify([mockedApi apiPostWithPath:[OCMArg any]
                         andDescriptor:[OCMArg any]
                             andParams:[OCMArg isEqual:checkDict]
                            completion:[OCMArg any]
                                 error:[OCMArg any]]);
}

- (void)testThatContentWithContentIdCreatesParametersWithTrue {
  id mockedApi = OCMPartialMock([[XMMEnduserApi alloc] init]);
  
  NSDictionary *checkDict = @{@"content_id":@"1",
                              @"include_style":@"True",
                              @"include_menu":@"True",
                              @"language":@"de",
                              @"full":@"True",};
  
  [mockedApi contentWithContentId:@"1"
                     includeStyle:YES
                      includeMenu:YES
                     withLanguage:@"de"
                             full:YES completion:nil error:nil];
  
  OCMVerify([mockedApi apiPostWithPath:[OCMArg any]
                         andDescriptor:[OCMArg any]
                             andParams:[OCMArg isEqual:checkDict]
                            completion:[OCMArg any]
                                 error:[OCMArg any]]);
}

- (void)testThatContentWithContentIdHandlesNilLanguage {
  id mockedApi = OCMPartialMock([[XMMEnduserApi alloc] init]);
  
  NSDictionary *checkDict = @{@"content_id":@"1",
                              @"include_style":@"True",
                              @"include_menu":@"True",
                              @"language":@"en",
                              @"full":@"True",};
  
  [mockedApi contentWithContentId:@"1"
                     includeStyle:YES
                      includeMenu:YES
                     withLanguage:nil
                             full:YES completion:nil error:nil];
  
  OCMVerify([mockedApi apiPostWithPath:[OCMArg any]
                         andDescriptor:[OCMArg any]
                             andParams:[OCMArg isEqual:checkDict]
                            completion:[OCMArg any]
                                 error:[OCMArg any]]);
}

#pragma mark - contentWithLocationIdentifier

- (void)testThatContentWithLocationIdentifierCallsApiPostWithPath {
  id mockedApi = OCMPartialMock([[XMMEnduserApi alloc] init]);
  
  [[[mockedApi stub] andDo:^(NSInvocation *invocation) {
    void (^stubResponse)(XMMContentByLocationIdentifier *result);
    [invocation getArgument:&stubResponse atIndex:5];
    XMMContentByLocationIdentifier *content = [[XMMContentByLocationIdentifier alloc] init];
    content.systemName = @"Hello";
    stubResponse(content);
  }] apiPostWithPath:[OCMArg any] andDescriptor:[OCMArg any] andParams:[OCMArg any] completion:[OCMArg any] error:[OCMArg any]];
  
  [mockedApi contentWithLocationIdentifier:@"1" majorId:nil includeStyle:NO includeMenu:NO withLanguage:@"de" completion:^(XMMContentByLocationIdentifier *result) {
    XCTAssertEqual(result.systemName, @"Hello");
  } error:nil];
  
  OCMVerify([mockedApi apiPostWithPath:[OCMArg isEqual:@"xamoomEndUserApi/v1/get_content_by_location_identifier"]
                         andDescriptor:[OCMArg any]
                             andParams:[OCMArg any]
                            completion:[OCMArg any]
                                 error:[OCMArg any]]);
}

- (void)testThatContentWithLocationIdentifierCreatesParameters {
  id mockedApi = OCMPartialMock([[XMMEnduserApi alloc] init]);
  
  NSDictionary *checkDict = @{@"location_identifier":@"1",
                              @"include_style":@"False",
                              @"include_menu":@"False",
                              @"language":@"de",};
  
  [mockedApi contentWithLocationIdentifier:@"1"
                                   majorId:nil
                              includeStyle:NO
                               includeMenu:NO
                              withLanguage:@"de" completion:nil error:nil];
  
  OCMVerify([mockedApi apiPostWithPath:[OCMArg any]
                         andDescriptor:[OCMArg any]
                             andParams:[OCMArg isEqual:checkDict]
                            completion:[OCMArg any]
                                 error:[OCMArg any]]);
}

- (void)testThatContentWithLocationIdentifierCreatesParametersWithBeaconMajor {
  id mockedApi = OCMPartialMock([[XMMEnduserApi alloc] init]);
  
  NSDictionary *checkDict = @{@"location_identifier":@"1",
                              @"ibeacon_major":@"2",
                              @"include_style":@"False",
                              @"include_menu":@"False",
                              @"language":@"de",};
  
  [mockedApi contentWithLocationIdentifier:@"1"
                                   majorId:@"2"
                              includeStyle:NO
                               includeMenu:NO
                              withLanguage:@"de" completion:nil error:nil];
  
  OCMVerify([mockedApi apiPostWithPath:[OCMArg any]
                         andDescriptor:[OCMArg any]
                             andParams:[OCMArg isEqual:checkDict]
                            completion:[OCMArg any]
                                 error:[OCMArg any]]);
}

- (void)testThatContentWithLocationIdentifierHandlesNilLanguage {
  id mockedApi = OCMPartialMock([[XMMEnduserApi alloc] init]);
  
  NSDictionary *checkDict = @{@"location_identifier":@"1",
                              @"ibeacon_major":@"2",
                              @"include_style":@"False",
                              @"include_menu":@"False",
                              @"language":@"en",};
  
  [mockedApi contentWithLocationIdentifier:@"1"
                                   majorId:@"2"
                              includeStyle:NO
                               includeMenu:NO
                              withLanguage:nil completion:nil error:nil];
  
  
  
  OCMVerify([mockedApi apiPostWithPath:[OCMArg any]
                         andDescriptor:[OCMArg any]
                             andParams:[OCMArg isEqual:checkDict]
                            completion:[OCMArg any]
                                 error:[OCMArg any]]);
}

#pragma mark - contentWithLocation

- (void)testThatContentWithLocationCallsApiPostWithPath {
  id mockedApi = OCMPartialMock([[XMMEnduserApi alloc] init]);
  
  [[[mockedApi stub] andDo:^(NSInvocation *invocation) {
    void (^stubResponse)(XMMContentByLocation *result);
    [invocation getArgument:&stubResponse atIndex:5];
    XMMContentByLocation *content = [[XMMContentByLocation alloc] init];
    stubResponse(content);
  }] apiPostWithPath:[OCMArg any] andDescriptor:[OCMArg any] andParams:[OCMArg any] completion:[OCMArg any] error:[OCMArg any]];
  
  [mockedApi contentWithLat:@"46.6247222" withLon:@"14.3052778" withLanguage:@"de" completion:^(XMMContentByLocation *result) {
    XCTAssertNotNil(result);
  } error:nil];
  
  OCMVerify([mockedApi apiPostWithPath:[OCMArg isEqual:@"xamoomEndUserApi/v1/get_content_by_location"]
                         andDescriptor:[OCMArg any]
                             andParams:[OCMArg any]
                            completion:[OCMArg any]
                                 error:[OCMArg any]]);
}

- (void)testThatContentWithLocationCreatesParameters {
  id mockedApi = OCMPartialMock([[XMMEnduserApi alloc] init]);
  
  NSDictionary *checkDict = @{@"location":
                                @{@"lat":@"46.6247222",
                                  @"lon":@"14.3052778",
                                  },
                              @"language":@"de",
                              };
  
  [mockedApi contentWithLat:@"46.6247222"
                    withLon:@"14.3052778"
               withLanguage:@"de"
                 completion:nil error:nil];
  
  OCMVerify([mockedApi apiPostWithPath:[OCMArg any]
                         andDescriptor:[OCMArg any]
                             andParams:[OCMArg isEqual:checkDict]
                            completion:[OCMArg any]
                                 error:[OCMArg any]]);
}

- (void)testThatContentWithLocationHandlesNilLanguage {
  id mockedApi = OCMPartialMock([[XMMEnduserApi alloc] init]);
  
  [mockedApi contentWithLat:@"46.6247222"
                    withLon:@"14.3052778"
               withLanguage:nil
                 completion:nil error:nil];
  
  NSDictionary *checkDict = @{@"location":
                                @{@"lat":@"46.6247222",
                                  @"lon":@"14.3052778",
                                  },
                              @"language":@"en",
                              };
  
  OCMVerify([mockedApi apiPostWithPath:[OCMArg any]
                         andDescriptor:[OCMArg any]
                             andParams:[OCMArg isEqual:checkDict]
                            completion:[OCMArg any]
                                 error:[OCMArg any]]);
}

#pragma mark - spotMapWithTags

- (void)testThatSpotMapWithTagsCallsApiGetWithPath {
  id mockedApi = OCMPartialMock([[XMMEnduserApi alloc] init]);
  
  NSString *checkPath = [NSString stringWithFormat:@"xamoomEndUserApi/v1/spotmap/%i/%@/%@", 0, @"Tag1,Tag2", @"de"];
  checkPath = [checkPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  
  [[[mockedApi stub] andDo:^(NSInvocation *invocation) {
    void (^stubResponse)(XMMSpotMap *result);
    [invocation getArgument:&stubResponse atIndex:5];
    XMMSpotMap *content = [[XMMSpotMap alloc] init];
    stubResponse(content);
  }] apiGetWithPath:[OCMArg any] andDescriptor:[OCMArg any] andParams:[OCMArg any] completion:[OCMArg any] error:[OCMArg any]];
  
  [mockedApi spotMapWithMapTags:@[@"Tag1", @"Tag2"] withLanguage:@"de" completion:^(XMMSpotMap *result) {
    XCTAssertNotNil(result);
  } error:nil];
  
  OCMVerify([mockedApi apiGetWithPath:[OCMArg isEqual:checkPath] andDescriptor:[OCMArg any] andParams:nil completion:[OCMArg any] error:[OCMArg any]]);
}

- (void)testThatSpotMapWithTagsHandlesUmlautsInTags {
  id mockedApi = OCMPartialMock([[XMMEnduserApi alloc] init]);
  
  NSString *checkPath = [NSString stringWithFormat:@"xamoomEndUserApi/v1/spotmap/%i/%@/%@", 0, @"Täg1,Täg2", @"de"];
  checkPath = [checkPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  
  [mockedApi spotMapWithMapTags:@[@"Täg1", @"Täg2"] withLanguage:@"de" completion:^(XMMSpotMap *result) {
    XCTAssertNotNil(result);
    
    OCMVerify([mockedApi apiGetWithPath:[OCMArg isEqual:checkPath] andDescriptor:[OCMArg any] andParams:nil completion:[OCMArg any] error:[OCMArg any]]);
    
  } error:nil];
  
}

- (void)testThatSpotMapWithTagsHandlesNilLanguage {
  id mockedApi = OCMPartialMock([[XMMEnduserApi alloc] init]);
  
  NSString *checkPath = [NSString stringWithFormat:@"xamoomEndUserApi/v1/spotmap/%i/%@/%@", 0, @"Tag", @"en"];
  checkPath = [checkPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  
  [mockedApi spotMapWithMapTags:@[@"Tag"] withLanguage:nil completion:nil error:nil];
  
  OCMVerify([mockedApi apiGetWithPath:[OCMArg isEqual:checkPath] andDescriptor:[OCMArg any] andParams:nil completion:[OCMArg any] error:[OCMArg any]]);
}

#pragma mark - contentListWithPageSize

- (void)testThatContentListWithPageSizeCallsApiGetWithPath {
  id mockedApi = OCMPartialMock([[XMMEnduserApi alloc] init]);
  
  NSString *checkPath = [NSString stringWithFormat:@"xamoomEndUserApi/v1/content_list/%@/%i/%@/%@", @"de", 5, @"null", @"Tag"];
  checkPath = [checkPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  
  [[[mockedApi stub] andDo:^(NSInvocation *invocation) {
    void (^stubResponse)(XMMContentList *result);
    [invocation getArgument:&stubResponse atIndex:5];
    XMMContentList *content = [[XMMContentList alloc] init];
    stubResponse(content);
  }] apiGetWithPath:[OCMArg any] andDescriptor:[OCMArg any] andParams:[OCMArg any] completion:[OCMArg any] error:[OCMArg any]];
  
  [mockedApi contentListWithPageSize:5 withLanguage:@"de" withCursor:nil withTags:@[@"Tag"] completion:^(XMMContentList *result) {
    XCTAssertNotNil(result);
  } error:nil];
  
  OCMVerify([mockedApi apiGetWithPath:[OCMArg isEqual:checkPath] andDescriptor:[OCMArg any] andParams:nil completion:[OCMArg any] error:[OCMArg any]]);
}

- (void)testThatContentListWithPageSizeHandlesNilLanguage {
  id mockedApi = OCMPartialMock([[XMMEnduserApi alloc] init]);
  
  NSString *checkPath = [NSString stringWithFormat:@"xamoomEndUserApi/v1/content_list/%@/%i/%@/%@", @"en", 5, @"null", @"Tag"];
  checkPath = [checkPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  
  [mockedApi contentListWithPageSize:5 withLanguage:nil withCursor:nil withTags:@[@"Tag"] completion:nil error:nil];
  
  OCMVerify([mockedApi apiGetWithPath:[OCMArg isEqual:checkPath] andDescriptor:[OCMArg any] andParams:nil completion:[OCMArg any] error:[OCMArg any]]);
}

- (void)testThatContentListWithPageSizeHandlesNilTags {
  id mockedApi = OCMPartialMock([[XMMEnduserApi alloc] init]);
  
  NSString *checkPath = [NSString stringWithFormat:@"xamoomEndUserApi/v1/content_list/%@/%i/%@/%@", @"en", 5, @"null", @"null"];
  checkPath = [checkPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  
  [mockedApi contentListWithPageSize:5 withLanguage:nil withCursor:nil withTags:nil completion:nil error:nil];
  
  OCMVerify([mockedApi apiGetWithPath:[OCMArg isEqual:checkPath] andDescriptor:[OCMArg any] andParams:nil completion:[OCMArg any] error:[OCMArg any]]);
}

#pragma mark - closestSpotsWithLat

- (void)testThatClosestSpotsWithLatCallsApiGetWithPath {
  id mockedApi = OCMPartialMock([[XMMEnduserApi alloc] init]);
  
  [[[mockedApi stub] andDo:^(NSInvocation *invocation) {
    void (^stubResponse)(XMMClosestSpot *result);
    [invocation getArgument:&stubResponse atIndex:5];
    XMMClosestSpot *content = [[XMMClosestSpot alloc] init];
    stubResponse(content);
  }] apiPostWithPath:[OCMArg any] andDescriptor:[OCMArg any] andParams:[OCMArg any] completion:[OCMArg any] error:[OCMArg any]];
  
  [mockedApi closestSpotsWithLat:46.6247222 withLon:14.3052778 withRadius:1000 withLimit:10 withLanguage:@"de" completion:^(XMMClosestSpot *result) {
    XCTAssertNotNil(result);
  } error:nil];
  
  OCMVerify([mockedApi apiPostWithPath:[OCMArg isEqual:@"xamoomEndUserApi/v1/get_closest_spots"]
                         andDescriptor:[OCMArg any]
                             andParams:[OCMArg any]
                            completion:[OCMArg any]
                                 error:[OCMArg any]]);
}

- (void)testThatClosestSpotsWithLatCreatesParameters {
  id mockedApi = OCMPartialMock([[XMMEnduserApi alloc] init]);
  
  NSDictionary *checkDict = @{@"location":
                                @{@"lat":@"46.624722",
                                  @"lon":@"14.305278",
                                  },
                              @"radius":@"1000",
                              @"limit":@"10",
                              @"language":@"de",
                              };
  
  [mockedApi closestSpotsWithLat:46.624722 withLon:14.305278 withRadius:1000 withLimit:10 withLanguage:@"de" completion:nil error:nil];
  
  OCMVerify([mockedApi apiPostWithPath:[OCMArg isEqual:@"xamoomEndUserApi/v1/get_closest_spots"]
                         andDescriptor:[OCMArg any]
                             andParams:[OCMArg isEqual:checkDict]
                            completion:[OCMArg any]
                                 error:[OCMArg any]]);
}

- (void)testThatClosestSpotsWithLatHandlesNil {
  id mockedApi = OCMPartialMock([[XMMEnduserApi alloc] init]);
  
  NSDictionary *checkDict = @{@"location":
                                @{@"lat":@"46.624722",
                                  @"lon":@"14.305278",
                                  },
                              @"radius":@"1000",
                              @"limit":@"10",
                              @"language":@"en",
                              };
  
  [mockedApi closestSpotsWithLat:46.624722 withLon:14.305278 withRadius:1000 withLimit:10 withLanguage:nil completion:nil error:nil];
  
  OCMVerify([mockedApi apiPostWithPath:[OCMArg isEqual:@"xamoomEndUserApi/v1/get_closest_spots"]
                         andDescriptor:[OCMArg any]
                             andParams:[OCMArg isEqual:checkDict]
                            completion:[OCMArg any]
                                 error:[OCMArg any]]);
}

#pragma mark - geofenceAnalytics

- (void)testThatGeofenceAnalyticsPosts {
  id mockedApi = OCMPartialMock([[XMMEnduserApi alloc] init]);
  
  NSDictionary *checkDict = @{@"requested_language":@"de",
                              @"delivered_language":@"de",
                              @"system_id":@"1",
                              @"system_name":@"2",
                              @"content_id":@"3",
                              @"content_name":@"4",
                              @"spot_id":@"5",
                              @"spot_name":@"6",
                              };
  
  [mockedApi geofenceAnalyticsMessageWithRequestedLanguage:@"de"
                                     withDeliveredLanguage:@"de"
                                              withSystemId:@"1"
                                            withSystemName:@"2"
                                             withContentId:@"3"
                                           withContentName:@"4"
                                                withSpotId:@"5"
                                              withSpotName:@"6"];
  
  OCMVerify([[mockedApi objectManager] postObject:[OCMArg any]
                                             path:[OCMArg any]
                                       parameters:[OCMArg isEqual:checkDict]
                                          success:[OCMArg any]
                                          failure:[OCMArg any]]);
}

#pragma mark - QRCodeReaderViewController

- (void)testThatStartQRCodeReaderFromViewControllerOpensView {
  UIViewController *mockedViewController = OCMPartialMock([[UIViewController alloc] init]);

  [[XMMEnduserApi sharedInstance] startQRCodeReaderFromViewController:mockedViewController
                                                               didLoad:nil];
  
  OCMVerify([mockedViewController presentViewController:[OCMArg any] animated:YES completion:NULL]);
}

- (void)testThatStartQRCodeReaderFromViewControllerReturnsValues {
  id mockedApi = OCMPartialMock([[XMMEnduserApi alloc] init]);
  UIViewController *mockedViewController = OCMPartialMock([[UIViewController alloc] init]);

  [[[mockedApi stub] andDo:^(NSInvocation *invocation) {
    void (^stubResponse)(NSString *locationIdentifier, NSString *url);
    [invocation getArgument:&stubResponse atIndex:3];
    stubResponse(@"1", @"2");
  }] startQRCodeReaderFromViewController:[OCMArg any] didLoad:[OCMArg any]];

  [mockedApi startQRCodeReaderFromViewController:mockedViewController didLoad:^(NSString *locationIdentifier, NSString *url) {
    XCTAssertTrue([locationIdentifier isEqualToString:@"1"]);
    XCTAssertTrue([url isEqualToString:@"2"]);
  }];
}

- (void)testThatCheckUrlPrefixDoesNotTouchRightHttpUrl {
  NSString *startingUrl = @"http://xm.gl";
  
  NSString *resultUrl = [[XMMEnduserApi sharedInstance] checkUrlPrefix:startingUrl];
  
  XCTAssertEqual(startingUrl, resultUrl);
}

- (void)testThatCheckUrlPrefixDoesNotTouchRightHttpsUrl {
  NSString *startingUrl = @"https://xm.gl";
  
  NSString *resultUrl = [[XMMEnduserApi sharedInstance] checkUrlPrefix:startingUrl];
  
  XCTAssertEqual(startingUrl, resultUrl);
}

- (void)testThatCheckUrlPrefixDoesAddHttpToFalseUrl {
  NSString *startingUrl = @"xm.gl";
  NSString *expectedUrl = @"http://xm.gl";
  
  NSString *resultUrl = [[XMMEnduserApi sharedInstance] checkUrlPrefix:startingUrl];
  
  XCTAssertTrue([resultUrl isEqualToString:expectedUrl]);
}

- (void)testThatLocationIdentifierFromURLReturnsLocationIdentifier {
  NSString *url = @"http://xm.gl/0ana0";
  NSString *expectedLocationIdentifier = @"0ana0";
  
  NSString *resultLocationIdentifier = [[XMMEnduserApi sharedInstance] locationIdentifierFromURL:url];
  
  XCTAssertTrue([resultLocationIdentifier isEqualToString:expectedLocationIdentifier]);
}

@end
