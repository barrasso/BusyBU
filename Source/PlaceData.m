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
    // Create a mutable copy
    NSMutableArray *placeInfo = [@[] mutableCopy];
    
    // FitRec
    NSDictionary *fitrecInfo = @{PLACE_NAME : @"FITREC"};
    [placeInfo addObject:fitrecInfo];
    
    // GSU
    NSDictionary *gsuInfo = @{PLACE_NAME : @"GSU"};
    [placeInfo addObject:gsuInfo];
    
    // Photonics
    NSDictionary *photonicsInfo = @{PLACE_NAME : @"PHOTONICS"};
    [placeInfo addObject:photonicsInfo];
    
    return [placeInfo copy];
}

@end
