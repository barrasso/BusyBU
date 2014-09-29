//
//  ContactPopup.m
//  WhatsBusy
//
//  Created by Mark on 9/29/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ContactPopup.h"

@implementation ContactPopup
{
    // Popup open flag
    BOOL isContactOpen;
}

#pragma mark - Life Cycle

- (void)onEnter
{
    [super onEnter];
    
    // Enables touches
    self.userInteractionEnabled = YES;
    
    // Init bool value
    isContactOpen = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isContactOpen"] boolValue];
        
    // Sync NSUserDefaults
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)onExit
{
    // Deallocate
    [super onExit];
}

#pragma mark - Selectors

- (void)close
{
    // Init bool value
    isContactOpen = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isContactOpen"] boolValue];
    
    // If contact popup is open, close it
    if (isContactOpen)
    {
        // Set contact popup flag to false
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isContactOpen"];
        
        // Remove current contact popup
        [self removeFromParent];
    }
}

@end
