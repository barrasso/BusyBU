//
//  PlaceObject.m
//  WhatsBusy
//
//  Created by Mark on 9/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "PlaceObject.h"
#import "PlaceData.h"

@implementation PlaceObject

#pragma mark - Initialization

- (id)init
{
    self = [self initWithData:nil];
    return self;
}

- (id)initWithData:(NSDictionary *)data
{
    // Initialize Place Objects
    self = [super init];
    
    // Set place object's data
    self.name = data[PLACE_NAME];
    self.status = data[PLACE_STATUS];
    self.location = data[PLACE_LOCATION];
    
    return self;
}

@end
