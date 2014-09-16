//
//  PlaceObject.h
//  WhatsBusy
//
//  Created by Mark on 9/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaceObject : NSObject

// Place Name
@property (nonatomic, strong) NSString *name;

// Place Status
@property (nonatomic, strong) NSString *status;

// Init with place data
- (id)initWithData:(NSDictionary *)data;

@end
