//
// Copyright 2016 by xamoom GmbH <apps@xamoom.com>
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

#import "XMMContentBlock3TableViewCell.h"

@interface XMMContentBlock3TableViewCell()

@end

@implementation XMMContentBlock3TableViewCell

- (void)awakeFromNib {
  [self setupGestureRecognizers];
  [self.blockImageView setIsAccessibilityElement:YES];
  
  self.titleLabel.text = nil;
}

- (void)setupGestureRecognizers {
  UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(saveImageToPhotoLibary:)];
  longPressGestureRecognizer.delegate = self;
  [self addGestureRecognizer:longPressGestureRecognizer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

- (void)prepareForReuse {
  [self.blockImageView removeConstraint:self.imageRatioConstraint];
  self.horizontalSpacingImageTitleConstraint.constant = 8;
  self.imageLeftHorizontalSpaceConstraint.constant = 0;
  self.imageRightHorizontalSpaceConstraint.constant = 0;
  self.imageRatioConstraint = nil;
  
  self.titleLabel.text = nil;

  [self setNeedsUpdateConstraints];
}

- (void)configureForCell:(XMMContentBlock *)block tableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath style:(XMMStyle *)style {
  self.titleLabel.textColor = [UIColor colorWithHexString:style.foregroundFontColor];
  
  if (![block.linkUrl isEqualToString:@""]) {
    self.linkUrl = block.linkUrl;
  }
  
  if (block.title != nil && ![block.title isEqualToString:@""]) {
    self.titleLabel.text = block.title;
    self.horizontalSpacingImageTitleConstraint.constant = 8;
  } else {
    self.horizontalSpacingImageTitleConstraint.constant = 0;
  }
  
  if (block.altText != nil && ![block.title isEqualToString:@""]){
    self.blockImageView.accessibilityHint = block.altText;
  } else {
    self.blockImageView.accessibilityHint = block.title;
  }
  
  if (block.scaleX > 0) {
    [self calculateImageScaling:block.scaleX];
  }
  
  if (block.fileID != nil && ![block.fileID isEqualToString:@""]) {
    [self displayImageFromURL:[NSURL URLWithString:block.fileID] tableView:tableView indexPath:indexPath];
  }
}

- (void)calculateImageScaling:(double)scaleX {
  double scalingFactor = scaleX / 100;
  double newImageWidth = self.bounds.size.width * scalingFactor;
  double sizeDiff = self.bounds.size.width - newImageWidth;
  
  self.imageLeftHorizontalSpaceConstraint.constant = sizeDiff/2;
  self.imageRightHorizontalSpaceConstraint.constant = (sizeDiff/2)*(-1);
}

- (void)displayImageFromURL:(NSURL *)fileURL tableView:(UITableView *)tableView indexPath:(NSIndexPath *) indexPath {
  if ([fileURL.absoluteString containsString:@".svg"]) {
    [self displaySVGFromURL:fileURL tableView:tableView indexPath:indexPath];
  } else {
    [self.imageLoadingIndicator startAnimating];
    [self.blockImageView sd_setImageWithURL:fileURL
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                    [self.imageLoadingIndicator stopAnimating];
                                    [self createAspectConstraintFromImage:image.size];
                                    [self setNeedsUpdateConstraints];
                                    
                                    if ([tableView.visibleCells containsObject:self]) {
                                      [tableView reloadData];
                                    }
                                  }];
  }
}

- (void)displaySVGFromURL:(NSURL *)fileURL tableView:(UITableView *)tableView indexPath:(NSIndexPath *) indexPath {
  self.blockImageView.image = nil;
  [self.imageLoadingIndicator startAnimating];
  
  [[[NSURLSession sharedSession] dataTaskWithURL:fileURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    JAMSVGImage *svgImage = [JAMSVGImage imageWithSVGData:data];
    
    float ratio = svgImage.size.width/svgImage.size.height;
    UIImage *image = [svgImage imageAtSize:CGSizeMake(self.bounds.size.width, self.bounds.size.width*ratio)];

    dispatch_async(dispatch_get_main_queue(), ^{
      XMMContentBlock3TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
      cell.blockImageView.image = image;
      
      [self.imageLoadingIndicator stopAnimating];
      [self createAspectConstraintFromImage:image.size];
      [self setNeedsUpdateConstraints];
    });
    
  }] resume];
  
}

- (void)createAspectConstraintFromImage:(CGSize)size {
  if (size.height <= 0 || size.width <= 0) {
    return;
  }
  
  self.imageRatioConstraint =[NSLayoutConstraint
                              constraintWithItem:self.blockImageView
                              attribute:NSLayoutAttributeHeight
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.blockImageView
                              attribute:NSLayoutAttributeWidth
                              multiplier:1/(size.width/size.height)
                              constant:0.0f];
  self.imageRatioConstraint.priority = UILayoutPriorityRequired;
}

- (void)updateConstraints {
  if (self.imageRatioConstraint) {
    [self addImageRatioConstraint];
  }
  
  [super updateConstraints];
}

- (void)addImageRatioConstraint {
  [self.blockImageView addConstraint:self.imageRatioConstraint];
}

- (void)saveImageToPhotoLibary:(UILongPressGestureRecognizer*)sender {
  if (sender.state == UIGestureRecognizerStateBegan) {
    [self showAlertController];
  }
}

- (void)showAlertController {
  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  NSURL *url = [bundle URLForResource:@"XamoomSDK" withExtension:@"bundle"];
  NSBundle *libBundle;
  if (url != nil) {
    libBundle = [NSBundle bundleWithURL:url];
  } else {
    libBundle = bundle;
  }

  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                           message:NSLocalizedStringFromTableInBundle(@"SaveImage", @"Localizable", libBundle, nil)
                                                                    preferredStyle:UIAlertControllerStyleAlert];
  
  [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedStringFromTableInBundle(@"OK", @"Localizable", libBundle, nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    [self saveImageToPhotos];
  }]];
  
  [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedStringFromTableInBundle(@"Cancel", @"Localizable", libBundle, nil) style:UIAlertActionStyleCancel handler:nil]];
  
  UIViewController* activeVC = [UIApplication sharedApplication].keyWindow.rootViewController;
  [activeVC presentViewController:alertController animated:YES completion:nil];
}

- (void)saveImageToPhotos {
  UIImageWriteToSavedPhotosAlbum(self.blockImageView.image, nil, nil, nil);
}

- (void)openLink {
  if (self.linkUrl != nil) {
    NSURL *url = [NSURL URLWithString:self.linkUrl];
    [[UIApplication sharedApplication] openURL:url];
  }
}

@end
