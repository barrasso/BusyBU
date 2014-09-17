//
//  InfoPopup.h
//  WhatsBusy
//
//  Created by Mark on 9/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface InfoPopup : CCNode

// Displays the place's name
@property (strong) CCLabelTTF *placeNameLabel;

// User's rating cooldown
@property (nonatomic, assign) BOOL isOnCooldown;

// Cooldown timer
@property (nonatomic, assign) float cooldownTimer;

@end
