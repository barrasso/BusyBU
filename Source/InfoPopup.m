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
    // Rate not busy
}

- (void)kindaBusy
{
    // Rate kinda busy
}

- (void)itsBusy
{
    // Rate it's busy
}

- (void)shareStatus
{
    // Share locations's status to friends
}

- (void)closePopup
{
    // Closes the popup and removes from main scene
    [self removeFromParent];
}

@end
