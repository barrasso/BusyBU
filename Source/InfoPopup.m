//
//  InfoPopup.m
//  WhatsBusy
//
//  Created by Mark on 9/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "InfoPopup.h"

@implementation InfoPopup

#pragma mark - Lifecycle

- (void)onEnter
{
    [super onEnter];
    
    // Set user interaction enabled
    self.userInteractionEnabled = YES;
    
    // Load NSUserDefaults boolean
    self.isOnCooldown = [[[NSUserDefaults standardUserDefaults] objectForKey:@"CooldownFlag"] boolValue];
    
    // Load NSUserDefaults timer
    self.cooldownTimer = [[[NSUserDefaults standardUserDefaults] objectForKey:@"CooldownTimer"] floatValue];
    
    // Sync NSUserDefaults
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)onExit
{
    // Deallocate
    [super onExit];
}

- (void)update:(CCTime)delta
{
    // Check if user has rating cooldown
    if (self.isOnCooldown)
    {
        // If the user is on cooldown, start the cooldown timer
        [[NSUserDefaults standardUserDefaults] setFloat:(self.cooldownTimer+1) forKey:@"CooldownTimer"];
        
        // Sync NSUserDefaults
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    // If the cooldown timer reaches 1000.f
    if (self.cooldownTimer >= 1000.f)
    {
        // Turn the cooldown off
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"CooldownFlag"];
        
        // Reset cooldown timer to 0
        [[NSUserDefaults standardUserDefaults] setFloat:0.0f forKey:@"CooldownTimer"];
        
        // Sync NSUserDefaults
        [[NSUserDefaults standardUserDefaults] synchronize];
    }    
}

#pragma mark - Selectors

- (void)notBusy
{
    // If the user is not on cooldown
    if (!self.isOnCooldown)
    {
        // Rate NOT busy
        
        // Init rate cooldown
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"CooldownFlag"];
    }
    // Else, display the cooldown message
    else
    {
        // Display cooldown message
        CCLOG(@"You've just rated a place. Try again in a minute.");
    }
}

- (void)kindaBusy
{
    // If the user is not on cooldown
    if (!self.isOnCooldown)
    {
        // Rate KINDA busy
    
        // Init rate cooldown
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"CooldownFlag"];
    }
    // Else, display the cooldown message
    {
        // Display cooldown message
        CCLOG(@"You've just rated a place. Try again in a minute.");
    }
}

- (void)itsBusy
{
    // If the user is not on cooldown
    if (!self.isOnCooldown)
    {
        // Rate IT IS busy
        
        // Init rate cooldown
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"CooldownFlag"];
    }
    // Else, display the cooldown message
    else
    {
        // Display cooldown message
        CCLOG(@"You've just rated a place. Try again in a minute.");
    }
}

@end
