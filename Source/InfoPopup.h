//
//  InfoPopup.h
//  WhatsBusy
//
//  Created by Mark on 9/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
@class MainScene;

@interface InfoPopup : CCNode

// Main Scene
@property (nonatomic, weak) MainScene *mainScene;

// Displays the place's name
@property (strong) CCLabelTTF *placeNameLabel;

// Contains the place's object id
@property (strong) CCLabelTTF *objectIDLabel;

// User's rating cooldown
@property (nonatomic, assign) BOOL isOnCooldown;

// Cooldown timer
@property (nonatomic, assign) float cooldownTimer;

@end
