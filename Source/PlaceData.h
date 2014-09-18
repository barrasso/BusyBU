//
//  PlaceData.h
//  WhatsBusy
//
//  Created by Mark on 9/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

// Place Keys
#define PLACE_NAME @"Place Name"
#define OBJ_ID @"ObjectID"

@interface PlaceData : NSObject

// Returns array of all places
+ (NSArray *)allPlaces;

@end
