//
//  InfoPopup.m
//  WhatsBusy
//
//  Created by Mark on 9/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "InfoPopup.h"

@implementation InfoPopup

#pragma mark - Selectors

- (void)notBusy
{
    if (self.isOnCooldown) {
        
        // Rate NOT busy
        
        // Init rate cooldown
        self.isOnCooldown = YES;
    }
    
    // Close after rating
    [self closePopup];
}

- (void)kindaBusy
{
    if (self.isOnCooldown) {
    
        // Rate KINDA busy
    
        // Init rate cooldown
        self.isOnCooldown = YES;
    }
    
    // Close after rating
    [self closePopup];
}

- (void)itsBusy
{
    if (self.isOnCooldown) {
        
        // Rate IT IS busy
        
        // Init rate cooldown
        self.isOnCooldown = YES;
    }
    
    // Close after rating
    [self closePopup];
}

- (void)closePopup
{
    // Closes the popup and removes from main scene
    [self removeFromParent];
}

@end
