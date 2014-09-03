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
    NSDictionary *fitrecInfo = @{PLACE_NAME : @"FITREC", PLACE_STATUS : @"STATUS", PLACE_LOCATION : @"COORDS", PLACE_POPULATION : @"0"};
    [placeInfo addObject:fitrecInfo];
    
    // GSU
    NSDictionary *gsuInfo = @{PLACE_NAME : @"GSU", PLACE_STATUS : @"STATUS", PLACE_LOCATION : @"COORDS", PLACE_POPULATION : @"0"};
    [placeInfo addObject:gsuInfo];
    
    /* Study Places */
    
    // Ingalls
    NSDictionary *ingallsInfo = @{PLACE_NAME : @"INGALLS", PLACE_STATUS : @"STATUS", PLACE_LOCATION : @"COORDS", PLACE_POPULATION : @"0"};
    [placeInfo addObject:ingallsInfo];
    
    // Mugar Library
    NSDictionary *mugarInfo = @{PLACE_NAME : @"MUGAR", PLACE_STATUS : @"STATUS", PLACE_LOCATION : @"COORDS", PLACE_POPULATION : @"0"};
    [placeInfo addObject:mugarInfo];
    
    // Photonics
    NSDictionary *photonicsInfo = @{PLACE_NAME : @"PHOTONICS", PLACE_STATUS : @"STATUS", PLACE_LOCATION : @"COORDS", PLACE_POPULATION : @"0"};
    [placeInfo addObject:photonicsInfo];
    
    /* Dining Halls */
    
    // Warren
    NSDictionary *warrenDhInfo = @{PLACE_NAME : @"WARREN DINING HALL", PLACE_STATUS : @"STATUS", PLACE_LOCATION : @"COORDS", PLACE_POPULATION : @"0"};
    [placeInfo addObject:warrenDhInfo];
    
    // West
    NSDictionary *westDhInfo = @{PLACE_NAME : @"WEST DINING HALL", PLACE_STATUS : @"STATUS", PLACE_LOCATION : @"COORDS", PLACE_POPULATION : @"0"};
    [placeInfo addObject:westDhInfo];
    
    /* Social */
    
    // BU Pub
    NSDictionary *buPubInfo = @{PLACE_NAME : @"BU PUB", PLACE_STATUS : @"STATUS", PLACE_LOCATION : @"COORDS", PLACE_POPULATION : @"0"};
    [placeInfo addObject:buPubInfo];
    
    // T's Pub
    NSDictionary *tPubInfo = @{PLACE_NAME : @"T'S PUB", PLACE_STATUS : @"STATUS", PLACE_LOCATION : @"COORDS", PLACE_POPULATION : @"0"};
    [placeInfo addObject:tPubInfo];
    
    // T.I.T.S.
    NSDictionary *titsInfo = @{PLACE_NAME : @"T.I.T.S.", PLACE_STATUS : @"STATUS", PLACE_LOCATION : @"COORDS", PLACE_POPULATION : @"0"};
    [placeInfo addObject:titsInfo];
    
    // Return copy of array
    return [placeInfo copy];
}

@end
