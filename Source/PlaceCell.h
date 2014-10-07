//
//  PlaceCell.h
//  WhatsBusy
//
//  Created by Mark on 8/31/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface PlaceCell : CCNode

// Place Label
@property (strong) CCLabelTTF *placeLabel;

// Status Label
@property (strong) CCLabelTTF *statusLabel;

// Updated At Label
@property (strong) CCLabelTTF *updatedAtLabel;

// Place Color
@property (strong) CCNodeColor *placeColor;

@end
