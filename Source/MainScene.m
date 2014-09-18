//
//  MainScene.m
//  WHATS BUSY
//
//  Created by Mark on 09/01/14.
//  Copyright (c) 2014 Mark Barrasso. All rights reserved.
//

#import "MainScene.h"
#import "InfoPopup.h"
#import "PlaceCell.h"
#import "PlaceData.h"
#import "PlaceObject.h"
#import <Parse/Parse.h>

@implementation MainScene
{    
    // Table View
    CCTableView *_tableView;
    CCNode *_tableViewNode;
    
    // Popup
    CCNode *currentPopup;
    
    // All Places
    NSMutableArray *_allCells;
    
    // Parse Object
    PFObject *parsePlaceObject;
    
    // Place counter
    int placeCounter;
}

#pragma mark - Lifecycle

- (void)didLoadFromCCB
{
    // Enable touches
    self.userInteractionEnabled = YES;

    // Init array to hold all cells
    _allCells = [[NSMutableArray alloc] init];
    
    // Place counter
    placeCounter = 0;
    
    // Create place objects and add them to allCells array
    for (NSMutableDictionary *placeData in [PlaceData allPlaces])
    {
        // Init place object with place data
        PlaceObject *place = [[PlaceObject alloc] initWithData:placeData];
        
        // Add to allCells array
        [_allCells addObject:place];
        
        // Create place number string for parse object class
        NSString *placeCounterString = [NSString stringWithFormat:@"Place%i",placeCounter];
        
        // Parse Object Init
        parsePlaceObject = [PFObject objectWithClassName:placeCounterString];
        
        // Increment place counter
        placeCounter++;
        
        // Add Names to Parse object
        [parsePlaceObject addObject:place.name forKey:@"Name"];
        
        // Add Statuses to Parse object
        [parsePlaceObject addObject:place.status forKey:@"Status"];
        
        // Save parse object in background with block
        [parsePlaceObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            // If the parse object was saved, then display created ID
            if (succeeded)
                CCLOG(@"Place Created with ID: %@",parsePlaceObject.objectId);
            // Else, display the error
            else
                CCLOG(@"%@",error);
        }];
    }
    
    // Sets up the main table view
    [self setupTableView];
}

- (void)dealloc
{
    // Remove table view delegate when this class is deallocated
    [_tableView setTarget:nil selector:nil];
}

- (void)update:(CCTime)delta
{
    // Load NSUserDefaults boolean
    self.isOnCooldown = [[[NSUserDefaults standardUserDefaults] objectForKey:@"CooldownFlag"] boolValue];
    
    // Load NSUserDefaults timer
    self.cooldownTimer = [[[NSUserDefaults standardUserDefaults] objectForKey:@"CooldownTimer"] floatValue];

    // Sync NSUserDefaults
    [[NSUserDefaults standardUserDefaults] synchronize];
    
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

#pragma mark - CCTableViewDataSource Protocol

- (void)setupTableView
{
    // Init table view
    _tableView = [[CCTableView alloc] init];
    
    // Add tableview to table view content node
	[_tableViewNode addChild:_tableView];
    
    // Set Content Size and type
	_tableView.contentSizeType = CCSizeTypeNormalized;
	_tableView.contentSize = CGSizeMake(1.f, 1.f);
    
    // Call table view cell selected
	[_tableView setTarget:self selector:@selector(tableViewCellSelected:)];
    
    // Set table view as the data source
    _tableView.dataSource = self;
}

// This method is called automatically by the CCTableView to create cells
- (CCTableViewCell*)tableView:(CCTableView*)tableView nodeForRowAtIndex:(NSUInteger)index
{    
    // Initialize TableViewCell
    CCTableViewCell *cell = [[CCTableViewCell alloc] init];
	   
    // Current cell represents a place
    PlaceObject *place = [_allCells objectAtIndex:index];
    
    // Load a PlaceCell
    PlaceCell *cellContent = (PlaceCell *)[CCBReader load:@"PlaceCell"];
    
    // Set the cell's label
    cellContent.placeLabel.string = place.name;
    
    /* 
     Set the cell's color
     * BUSY = Red
     * MILD = Blue
     * OPEN = Green
     */
    if ([place.status isEqualToString:@"BUSY"])
        cellContent.placeColor.color = [CCColor colorWithRed:0.5f green:0.f blue:0.f];
    else if ([place.status isEqualToString:@"MILD"])
        cellContent.placeColor.color = [CCColor colorWithRed:0.f green:0.f blue:0.5f];
    else
        cellContent.placeColor.color = [CCColor colorWithRed:0.f green:0.5f blue:0.f];
    
    // Add cellContent to cell
    [cell addChild:cellContent];
    
    // Set the cell's content size and type
    cell.contentSizeType = CCSizeTypeMake(CCSizeUnitNormalized, CCSizeUnitPoints);
    cell.contentSize = CGSizeMake(1.f, 100.f);
	
    // Returns the cell
	return cell;
}

// This method is called automatically by the CCTableView to create cells
- (float) tableView:(CCTableView*)tableView heightForRowAtIndex:(NSUInteger) index
{
    // Return row height of 100
	return 100;
}

// This method is called automatically by the CCTableView to create cells
- (NSUInteger) tableViewNumberOfRows:(CCTableView*) tableView
{
    // Returns total amount of places in allCells array
	return [_allCells count];
}

// This method is called automatically by the CCTableView when cells are tapped
- (void)tableViewCellSelected:(CCTableViewCell*)sender
{
    // Get the index
	NSInteger index = _tableView.selectedRow;
    
    // Current cell represents a place
    PlaceObject *place = [_allCells objectAtIndex:index];
    
    // Check if a popup is already open
    if (self.isPopupOpen)
    {
        // If it is, close it
        [self removeChild:currentPopup];
        
        // Toggle isPopupOpen state
        [self togglePopupBool];
    }
    
    // If a popup is not already open
    else
    {    // Load the place's popup
        InfoPopup *infoPopup = (InfoPopup *)[CCBReader load:@"InfoPopup"];
        
        // Then position and initalize the popup
        infoPopup.positionType = CCPositionTypeNormalized;
        infoPopup.position = ccp(0.5,0.5);
        infoPopup.placeNameLabel.string = place.name;
        
        // Then set boolean flag to true
        [self togglePopupBool];
        
        // Then add popup as child to main scene
        [self addChild:infoPopup];
        
        // Add as current popup
        currentPopup = infoPopup;
    }
}

#pragma mark - Helper Methods

// Check if pop up display is open
- (void)togglePopupBool
{
    // Toggle open or closed
    if (self.isPopupOpen)
        self.isPopupOpen = NO;
    else
        self.isPopupOpen = YES;
}

#pragma mark - Selectors

- (void)refresh
{
    // Refresh list when clicked
    [_tableView reloadData];
}

@end
