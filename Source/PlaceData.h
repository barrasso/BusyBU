//
//  PlaceData.h
//  WhatsBusy
//
//  Created by Mark on 9/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PLACE_NAME @"Place Name"
#define PLACE_STATUS @"Place Status"
#define PLACE_LOCATION @"Place Location"

@interface PlaceData : NSObject

// Returns array of all places
+ (NSArray *)allPlaces;

@end
