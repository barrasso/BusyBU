//
//  PlaceData.m
//  WhatsBusy
//
//  Created by Mark on 9/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "PlaceData.h"

@implementation PlaceData

+ (NSArray *)allPlaces
{
    // Create mutable copy
    NSMutableArray *placeInfo = [@[] mutableCopy];

    /* Student Utilities */
    
    // FitRec
    NSDictionary *fitrecInfo = @{PLACE_NAME : @"FITREC", PLACE_STATUS : @"BUSY"};
    [placeInfo addObject:fitrecInfo];
    
    // GSU
    NSDictionary *gsuInfo = @{PLACE_NAME : @"GSU", PLACE_STATUS : @"BUSY"};
    [placeInfo addObject:gsuInfo];
    
    /* Study Places */
    
    // Mugar Library
    NSDictionary *mugarInfo = @{PLACE_NAME : @"MUGAR", PLACE_STATUS : @"MILD"};
    [placeInfo addObject:mugarInfo];
    
    // Photonics
    NSDictionary *photonicsInfo = @{PLACE_NAME : @"PHOTONICS", PLACE_STATUS : @"MILD"};
    [placeInfo addObject:photonicsInfo];
    
    /* Dining Halls */
    
    // Warren
    NSDictionary *warrenDhInfo = @{PLACE_NAME : @"WARREN DINING HALL", PLACE_STATUS : @"OPEN"};
    [placeInfo addObject:warrenDhInfo];
    
    // West
    NSDictionary *westDhInfo = @{PLACE_NAME : @"WEST DINING HALL", PLACE_STATUS : @"OPEN"};
    [placeInfo addObject:westDhInfo];
    
    // Return copy of array
    return [placeInfo copy];
}

@end
