//
//  ContactPopup.m
//  WhatsBusy
//
//  Created by Mark on 9/29/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ContactPopup.h"

@implementation ContactPopup

#pragma mark - Life Cycle

- (void)onEnter
{
    [super onEnter];
    
    // Enables touches
    self.userInteractionEnabled = YES;
}

- (void)onExit
{
    // Deallocate
    [super onExit];
}

#pragma mark - Selectors

- (void)close
{
    // Remove current contact popup
    [self removeFromParent];
}

@end
