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
#import <JSONAPI/JSONAPIResourceBase.h>
#import <JSONAPI/JSONAPIResourceDescriptor.h>
#import <JSONAPI/JSONAPIPropertyDescriptor.h>
#import "XMMRestResource.h"
#import "XMMContent.h"
#import "XMMSystem.h"
#import "XMMMarker.h"

@class XMMContent;

/**
 * `XMMSpot` is used for mapping the JSON sended by the api.
 */
@interface XMMSpot : JSONAPIResourceBase  <XMMRestResource>

/**
 * The displayName of the spot.
 */
@property (nonatomic, copy) NSString *name;
/**
 * The description of the spot. (E.g. "on the front door of the xamoom office")
 */
@property (nonatomic, copy) NSString *spotDescription;
/**
 * The latitude of the spot.
 */
@property (nonatomic) double lat;
/**
 * The longitude of the spot.
 */
@property (nonatomic) double lon;
/**
 * Public url pointing to an image on our system.
 */
@property (nonatomic, copy) NSString *image;
/**
 *  Category as an number to specify an icon.
 */
@property (nonatomic) int category;

@property (nonatomic) NSArray *tags;

@property (nonatomic) XMMContent *content;

@property (nonatomic) NSArray *markers;

@property (nonatomic) XMMSystem *system;

@end