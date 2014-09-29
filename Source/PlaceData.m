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
    NSDictionary *fitrecInfo = @{PLACE_NAME : @"FITREC", OBJ_ID : @"U835guaY4k"};
    [placeInfo addObject:fitrecInfo];
    
    // GSU
    NSDictionary *gsuInfo = @{PLACE_NAME : @"GSU", OBJ_ID : @"lMCMbQZXuF"};
    [placeInfo addObject:gsuInfo];
    
    /* Study Places */
    
    // Ingalls
    NSDictionary *ingallsInfo = @{PLACE_NAME : @"INGALLS", OBJ_ID : @"duQYkFbgqR"};
    [placeInfo addObject:ingallsInfo];
    
    // Mugar Library
    NSDictionary *mugarInfo = @{PLACE_NAME : @"MUGAR", OBJ_ID : @"hJjLOuPs3d"};
    [placeInfo addObject:mugarInfo];
    
    // Photonics
    NSDictionary *photonicsInfo = @{PLACE_NAME : @"PHOTONICS", OBJ_ID : @"wGK6akcNh9"};
    [placeInfo addObject:photonicsInfo];
    
    // Photonics Lab 305/307
    NSDictionary *lab305Info = @{PLACE_NAME : @"PHO 305/307", OBJ_ID : @"YU2njb4jjU"};
    [placeInfo addObject:lab305Info];
    
    // Photonics Lab 115
    NSDictionary *pho115Info = @{PLACE_NAME : @"PHO 115", OBJ_ID : @"0x77bPxb3V"};
    [placeInfo addObject:pho115Info];
    
    /* Social */
    
    // BU Pub
    NSDictionary *buPubInfo = @{PLACE_NAME : @"BU PUB", OBJ_ID : @"UkMbFaZpuH"};
    [placeInfo addObject:buPubInfo];
    
    // T's Pub
    NSDictionary *tPubInfo = @{PLACE_NAME : @"T'S PUB", OBJ_ID : @"aULkZ3oA7k"};
    [placeInfo addObject:tPubInfo];
    
    // T.I.T.S.
    NSDictionary *titsInfo = @{PLACE_NAME : @"T.I.T.S.", OBJ_ID : @"EGrFgA5vuC"};
    [placeInfo addObject:titsInfo];
    
    // Return copy of array
    return [placeInfo copy];
}

@end
