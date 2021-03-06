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

#import "XMMAnnotation.h"
#import <MapKit/MapKit.h>

@implementation XMMAnnotation

@synthesize coordinate;
@synthesize title;

- (instancetype)init {
  self = [self initWithLocation:CLLocationCoordinate2DMake(0, 0)];
  return self;
}

- (id)initWithLocation:(CLLocationCoordinate2D)coord {
  self = [super init];
  if (self) {
    coordinate = coord;
  }
  
  return self;
}

- (id)initWithName:(NSString*)name withLocation:(CLLocationCoordinate2D)coord {
  self = [super init];
  if (self) {
    coordinate = coord;
    title = name;
  }
  
  return self;
}

- (MKMapItem*)mapItem {
  MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
  
  MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
  mapItem.name = self.title;
  
  return mapItem;
}

@end