//
// Copyright 2015 by xamoom GmbH <apps@xamoom.com>
//
// This file is part of some open source application.
//
// Some open source application is free software: you can redistribute
// it and/or modify it under the terms of the GNU General Public
// License as published by the Free Software Foundation, either
// version 2 of the License, or (at your option) any later version.
//
// Some open source application is distributed in the hope that it will
// be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
// of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with xamoom-ios-sdk. If not, see <http://www.gnu.org/licenses/>.
//

#import "ViewController.h"
#import <RestKit/RestKit.h>
#import "XMMEnduserApi.h"

NSString * const kContentId = @"7cf2c58e6d374ce3888c32eb80be53b5";
NSString * const kLocationIdentifier = @"i4n7l";

@interface ViewController () <QRCodeReaderDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //get apikey from .plist
  NSString* path = [[NSBundle mainBundle] pathForResource:@"TestingIDs"
                                                   ofType:@"plist"];
  
  NSDictionary* testLogins = [NSDictionary dictionaryWithContentsOfFile:path];
  
  NSString *apikey = [testLogins valueForKey:@"apikey"];
  
  [[XMMEnduserApi sharedInstance] setApiKey:apikey];
  
  CLLocationManager *locationManager = [[CLLocationManager alloc] init];
  if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
    [locationManager requestWhenInUseAuthorization];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - QRCodeReader Delegate Methods

-(void)didScanQR:(NSString *)result {
  self.outputTextView.text = result;
}

#pragma mark - Actions

- (IBAction)scanAction:(id)sender {
  [[XMMEnduserApi sharedInstance] setQrCodeViewControllerCancelButtonTitle:@"Abbrechen"];
  [[XMMEnduserApi sharedInstance] startQRCodeReaderFromViewController:self didLoad:^(NSString *locationIdentifier, NSString *url) {
    NSLog(@"LocationIdentifier: %@ und url: %@", locationIdentifier, url);
    self.outputTextView.text = [NSString stringWithFormat:@"LocationIdentifier: %@ und url: %@", locationIdentifier, url];
  }];
}

- (IBAction)testContentBlocksAction:(id)sender {
  //[self performSegueWithIdentifier:@"contentBlocksSegue" sender:self];
}

- (IBAction)getContentByLocationIdentifierAction:(id)sender {
  [[XMMEnduserApi sharedInstance] contentWithLocationIdentifier:kLocationIdentifier majorId:nil includeStyle:YES includeMenu:YES withLanguage:[XMMEnduserApi sharedInstance].systemLanguage
                                                     completion:^(XMMContentByLocationIdentifier *result){
                                                       NSLog(@"finishedLoadDataByLocationIdentifier: %@", result.description);
                                                       self.outputTextView.text = result.description;
                                                     } error:^(XMMError *error) {
                                                       NSLog(@"LoadDataByLocationIdentifier Error: %@", error.message);
                                                     }];
}

- (IBAction)getContentByLocationIdentifierBeacon:(id)sender {
  [[XMMEnduserApi sharedInstance] contentWithLocationIdentifier:@"16984" majorId:@"52414" includeStyle:YES includeMenu:YES withLanguage:[XMMEnduserApi sharedInstance].systemLanguage
                                                     completion:^(XMMContentByLocationIdentifier *result){
                                                       NSLog(@"finishedLoadDataByLocationIdentifierBeacon: %@", result.description);
                                                       self.outputTextView.text = result.description;
                                                     } error:^(XMMError *error) {
                                                       NSLog(@"LoadDataByLocationIdentifier Error: %@", error.message);
                                                     }];
}

- (IBAction)getContentByLocationAction:(id)sender {
  [[XMMEnduserApi sharedInstance] contentWithLat:@"46.615" withLon:@"14.263" withLanguage:[XMMEnduserApi sharedInstance].systemLanguage
                                      completion:^(XMMContentByLocation *result){
                                        NSLog(@"finishedLoadDataByLocation: %@", result.description);
                                        self.outputTextView.text = result.description;
                                      } error:^(XMMError *error) {
                                        NSLog(@"LoadDataByLocation Error: %@", error.message);
                                      }
   ];
}

- (IBAction)getSpotMapAction:(id)sender {
  [[XMMEnduserApi sharedInstance] spotMapWithMapTags:@[@"stw",@"raphi"] withLanguage:[XMMEnduserApi sharedInstance].systemLanguage includeContent:NO
                                           completion:^(XMMSpotMap *result) {
                                             NSLog(@"finishedGetSpotMap: %@", result.description);
                                             self.outputTextView.text = result.description;
                                           } error:^(XMMError *error) {
                                             NSLog(@"GetSpotMap Error: %@", error.message);
                                           }
   ];
}

- (IBAction)getContentListAction:(id)sender {
  [[XMMEnduserApi sharedInstance] contentListWithPageSize:5 withLanguage:[XMMEnduserApi sharedInstance].systemLanguage withCursor:nil withTags:@[@"artists"]
                                               completion:^(XMMContentList *result){
                                                 NSLog(@"finishedGetContentList full: %@", result.description);
                                                 self.outputTextView.text = result.description;
                                               } error:^(XMMError *error) {
                                                 NSLog(@"GetContentList Error: %@", error.message);
                                               }
   ];
}

- (IBAction)getContentByIdFull:(id)sender {
  [[XMMEnduserApi sharedInstance] contentWithContentId:kContentId includeStyle:NO includeMenu:NO withLanguage:[XMMEnduserApi sharedInstance].systemLanguage full:YES preview:NO
                                            completion:^(XMMContentById *result){
                                              NSLog(@"finishedLoadDataById full: %@", result.description);
                                              self.outputTextView.text = result.description;
                                            } error:^(XMMError *error) {
                                              NSLog(@"LoadDataById full Error: %@", error.message);
                                            }
   ];
}

- (IBAction)closestSpots:(id)sender {
  [[XMMEnduserApi sharedInstance] closestSpotsWithLat:46.615 withLon:14.263 withRadius:1000 withLimit:100 withLanguage:[XMMEnduserApi sharedInstance].systemLanguage
                                           completion:^(XMMClosestSpot *result){
                                             NSLog(@"finishedLoadClosestSpots: %@", result.description);
                                             self.outputTextView.text = result.description;
                                           } error:^(XMMError *error) {
                                             NSLog(@"LoadClosestSpots Error: %@", error.message);
                                           }
   ];
}

@end