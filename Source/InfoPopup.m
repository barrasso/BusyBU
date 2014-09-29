//
//  InfoPopup.m
//  WhatsBusy
//
//  Created by Mark on 9/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "InfoPopup.h"
#import <Parse/Parse.h>

@implementation InfoPopup
{
    // Check if self is open
    BOOL isPopupOpen;
    
    // Parse object retrieval
    PFQuery *query;
}

#pragma mark - Lifecycle

- (void)onEnter
{
    [super onEnter];
    
    // Set user interaction enabled
    self.userInteractionEnabled = YES;
    
    // Load NSUser isPopupOpen
    isPopupOpen = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isPopupOpen"] boolValue];
    
    // Load NSUserDefaults boolean
    self.isOnCooldown = [[[NSUserDefaults standardUserDefaults] objectForKey:@"CooldownFlag"] boolValue];
    
    // Load NSUserDefaults timer
    self.cooldownTimer = [[[NSUserDefaults standardUserDefaults] objectForKey:@"CooldownTimer"] floatValue];
    
    // Sync NSUserDefaults
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Parse query to get places
    query = [PFQuery queryWithClassName:@"Places"];
}

- (void)onExit
{
    // Deallocate
    [super onExit];
}

#pragma mark - Selectors

/* RATE LOCATION NOT BUSY */
- (void)notBusy
{
    // Load NSUserDefaults boolean
    self.isOnCooldown = [[[NSUserDefaults standardUserDefaults] objectForKey:@"CooldownFlag"] boolValue];
    
    // If the user is not on cooldown
    if (!self.isOnCooldown)
    {
        // Get place by parse object ID
        [query getObjectInBackgroundWithId:self.objectIDLabel.string block:^(PFObject *placeObj, NSError *error)
         {
             // Update status to rate not busy
             [placeObj incrementKey:@"NBR"];
             
             // Save status rating
             [placeObj saveInBackground];
         }];
        
        // Display success message
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thanks!" message:@"Your feedback has been recorded." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        // Init rate cooldown
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"CooldownFlag"];
        
        // Toggle mainscene popup boolean
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isPopupOpen"];
        
        // Close popup after rating
        [self removeFromParent];
    }
    // Else, display the cooldown message
    else if (self.isOnCooldown)
    {
        // Display cooldown message
        UIAlertView *alertNo = [[UIAlertView alloc] initWithTitle:@"Uh Oh!" message:@"You've just rated a place, try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertNo show];
        
        // Toggle mainscene popup boolean
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isPopupOpen"];
        
        // Close popup after rating
        [self removeFromParent];
    }
}

/* RATE LOCATION MILDLY BUSY */
- (void)kindaBusy
{
    // Load NSUserDefaults boolean
    self.isOnCooldown = [[[NSUserDefaults standardUserDefaults] objectForKey:@"CooldownFlag"] boolValue];
    
    // If the user is not on cooldown
    if (!self.isOnCooldown)
    {
        // Get place by parse object ID
        [query getObjectInBackgroundWithId:self.objectIDLabel.string block:^(PFObject *placeObj, NSError *error)
         {
             // Update status to rate kinda busy
             [placeObj incrementKey:@"MR"];
             
             // Save status rating
             [placeObj saveInBackground];
         }];
    
        // Display success message
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thanks!" message:@"Your feedback has been recorded." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        // Init rate cooldown
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"CooldownFlag"];
        
        // Toggle mainscene popup boolean
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isPopupOpen"];
        
        // Close popup after rating
        [self removeFromParent];
    }
    // Else, display the cooldown message
    else if (self.isOnCooldown)
    {
        // Display cooldown message
        UIAlertView *alertNo = [[UIAlertView alloc] initWithTitle:@"Uh Oh!" message:@"You've just rated a place, try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertNo show];
        
        // Toggle mainscene popup boolean
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isPopupOpen"];
        
        // Close popup after rating
        [self removeFromParent];
    }
}

/* RATE LOCATION BUSY */
- (void)itsBusy
{
    // Load NSUserDefaults boolean
    self.isOnCooldown = [[[NSUserDefaults standardUserDefaults] objectForKey:@"CooldownFlag"] boolValue];
    
    // If the user is not on cooldown
    if (!self.isOnCooldown)
    {
        // Get place by parse object ID
        [query getObjectInBackgroundWithId:self.objectIDLabel.string block:^(PFObject *placeObj, NSError *error)
         {
             // Update status to rate it is busy
             [placeObj incrementKey:@"BR"];
             
             // Save status rating
             [placeObj saveInBackground];
         }];
        
        // Display success message
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thanks!" message:@"Your feedback has been recorded." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        // Init rate cooldown
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"CooldownFlag"];
        
        // Toggle mainscene popup boolean
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isPopupOpen"];
        
        // Close popup after rating
        [self removeFromParent];
    }
    // Else, display the cooldown message
    else if (self.isOnCooldown)
    {
        // Display cooldown message
        UIAlertView *alertNo = [[UIAlertView alloc] initWithTitle:@"Uh Oh!" message:@"You've just rated a place, try again later." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertNo show];
        
        // Toggle mainscene popup boolean
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isPopupOpen"];
        
        // Close popup after rating
        [self removeFromParent];
    }
}

@end
