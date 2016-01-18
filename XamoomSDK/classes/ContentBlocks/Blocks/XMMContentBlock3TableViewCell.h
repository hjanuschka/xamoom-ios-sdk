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

#import <UIKit/UIKit.h>

/**
 * XMMContentBlock0TableViewCell is used to display image contentBlocks from the xamoom cloud.
 */
@interface XMMContentBlock3TableViewCell : UITableViewCell <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* imageHeightConstraint;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *imageLoadingIndicator;

@property (unsafe_unretained, nonatomic) IBOutlet NSLayoutConstraint *imageLeftHorizontalSpaceConstraint;
@property (unsafe_unretained, nonatomic) IBOutlet NSLayoutConstraint *imageRightHorizontalSpaceConstraint;
@property (nonatomic) NSLayoutConstraint *imageRatioConstraint;

@property (strong, nonatomic) NSString *linkUrl;

@end