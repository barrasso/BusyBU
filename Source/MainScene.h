//
//  MainScene.h
//  WHATS BUSY
//
//  Created by Mrk on 09/01/14.
//  Copyright (c) 2014 Mark Barrasso. All rights reserved.
//

#import "CCNode.h"

@interface MainScene : CCNode <CCTableViewDataSource>

// Ref to current popup
@property (nonatomic, strong) CCNode *currentPopup;

// Cooldown timer
@property (nonatomic, assign) float cooldownTimer;

// User's rating cooldown
@property (nonatomic, assign) BOOL isOnCooldown;

// Boolean flag to check if popup is open
//@property (nonatomic, assign) BOOL isPopupOpen;

// Toggle boolean flag
- (void)togglePopupBool;

// Refresh table data
- (void)refresh;

@end
