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

#import "XMMContentBlocks.h"
#import <SDWebImage/UIImageView+WebCache.h>

int const kHorizontalSpaceToSubview = 32;
NSString* const kContentBlock9MapContentLinkNotification = @"com.xamoom.kContentBlock9MapContentLinkNotification";

#pragma mark - XMMContentBlocks Interface

@interface XMMContentBlocks ()

@property (nonatomic) BOOL isContentHeaderAdded;

@end

#pragma mark - XMMContentBlocks Implementation

@implementation XMMContentBlocks

- (instancetype)initWithTableView:(UITableView *)tableView api:(XMMEnduserApi *)api {
  self = [super init];
  
  if (self) {
    self.api = api;
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setupTableView];
    
    [XMMContentBlock0TableViewCell setFontSize:NormalFontSize];
    [XMMContentBlock0TableViewCell setLinkColor:[UIColor blueColor]];
  }
  
  return self;
}

- (void)setupTableView {
  //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 50.0;
  
  [self registerNibs];
}

- (void)registerNibs {
  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  NSURL *url = [bundle URLForResource:@"XamoomSDKNibs" withExtension:@"bundle"];
  NSBundle *nibBundle = [NSBundle bundleWithURL:url];
  
  UINib *nib = [UINib nibWithNibName:@"XMMContentBlock0TableViewCell" bundle:nibBundle];
  [self.tableView registerNib:nib forCellReuseIdentifier:@"XMMContentBlock0TableViewCell"];
  
  nib = [UINib nibWithNibName:@"XMMContentBlock1TableViewCell" bundle:nibBundle];
  [self.tableView registerNib:nib forCellReuseIdentifier:@"XMMContentBlock1TableViewCell"];
  
  nib = [UINib nibWithNibName:@"XMMContentBlock2TableViewCell" bundle:nibBundle];
  [self.tableView registerNib:nib forCellReuseIdentifier:@"XMMContentBlock2TableViewCell"];
  
  nib = [UINib nibWithNibName:@"XMMContentBlock3TableViewCell" bundle:nibBundle];
  [self.tableView registerNib:nib forCellReuseIdentifier:@"XMMContentBlock3TableViewCell"];
  
  nib = [UINib nibWithNibName:@"XMMContentBlock4TableViewCell" bundle:nibBundle];
  [self.tableView registerNib:nib forCellReuseIdentifier:@"XMMContentBlock4TableViewCell"];
  
  nib = [UINib nibWithNibName:@"XMMContentBlock5TableViewCell" bundle:nibBundle];
  [self.tableView registerNib:nib forCellReuseIdentifier:@"XMMContentBlock5TableViewCell"];
  
  nib = [UINib nibWithNibName:@"XMMContentBlock6TableViewCell" bundle:nibBundle];
  [self.tableView registerNib:nib forCellReuseIdentifier:@"XMMContentBlock6TableViewCell"];
  
  nib = [UINib nibWithNibName:@"XMMContentBlock7TableViewCell" bundle:nibBundle];
  [self.tableView registerNib:nib forCellReuseIdentifier:@"XMMContentBlock7TableViewCell"];
  
  nib = [UINib nibWithNibName:@"XMMContentBlock8TableViewCell" bundle:nibBundle];
  [self.tableView registerNib:nib forCellReuseIdentifier:@"XMMContentBlock8TableViewCell"];
  
  nib = [UINib nibWithNibName:@"XMMContentBlock9TableViewCell" bundle:nibBundle];
  [self.tableView registerNib:nib forCellReuseIdentifier:@"XMMContentBlock9TableViewCell"];
}

- (void)displayContent:(XMMContent *)content {
  self.items = [content.contentBlocks mutableCopy];
  
  dispatch_async(dispatch_get_main_queue(), ^{
    [self.tableView reloadData];
  });
}

#pragma mark - Setters



#pragma mark - Getters

+ (NSString *)kContentBlock9MapContentLinkNotification {
  return kContentBlock9MapContentLinkNotification;
}

#pragma mark - Custom Methods

- (void)updateFontSizeTo:(TextFontSize)newFontSize {
  [XMMContentBlock0TableViewCell setFontSize:newFontSize];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  XMMContentBlock *block = [self.items objectAtIndex:indexPath.row];
  NSString *reuseIdentifier = [NSString stringWithFormat:@"XMMContentBlock%dTableViewCell", block.blockType];
  
  id cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
  if ([cell respondsToSelector:@selector(configureForCell:)]) {
    [cell configureForCell:block];
    return cell;
  }
  
  return [[UITableViewCell alloc] initWithFrame:CGRectZero];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
  if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[XMMContentBlock6TableViewCell class]]) {
    XMMContentBlock6TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  }
}


@end