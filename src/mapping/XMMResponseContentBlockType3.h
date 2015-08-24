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

#import <Foundation/Foundation.h>
#import "XMMResponseContentBlock.h"

/**
 `XMMResponseContentBlockType3` is used for mapping the JSON sended by the api.
 
 This class represents the contentBlockType 'IMAGE'.
 
 *Default behavior*
 
 1. Display title as bold.
 2. Display image scaled to device width.
 */
@interface XMMResponseContentBlockType3 : XMMResponseContentBlock

/**
 Url to a imageFile (jpg, png, webp, svg)
 */
@property (nonatomic, copy) NSString *fileId;

/**
 Value to determine a x-axis (width) scaling from 0 to 100 in percent.
 Is null when not set.
 */
@property (nonatomic, copy) NSDecimalNumber *scaleX;

/// @name Mapping

/**
 Returns a RKObjectMapping for `XMMResponseContentBlockType3` class.
 
 @return RKObjectMapping*
 */
+ (RKObjectMapping*)mapping;

/**
 Returns a RKObjectMappingMatcher for `XMMResponseContentBlockType3` class.
 
 @return RKObjectMappingMatcher*
 */
+ (RKObjectMappingMatcher*)dynamicMappingMatcher;

@end
