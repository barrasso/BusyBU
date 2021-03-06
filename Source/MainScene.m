//
//  MainScene.m
//  WHATS BUSY
//
//  Created by Mark on 09/01/14.
//  Copyright (c) 2014 Mark Barrasso. All rights reserved.
//

#import "MainScene.h"
#import "InfoPopup.h"
#import "ContactPopup.h"
#import "PlaceCell.h"
#import "PlaceData.h"
#import "PlaceObject.h"
#import <Parse/Parse.h>

// Default timeToUpdate a location (hours)
const static int timeToUpdate = 1;

@implementation MainScene
{
    // Curent Time
    int currentTime;
    
    // Table View
    CCTableView *_tableView;
    CCNode *_tableViewNode;
    
    // Info Popup flag
    BOOL isPopupOpen;
    
    // All Places
    NSMutableArray *_allCells;
    
    // Parse object retrieval
    PFQuery *query;
}

#pragma mark - Lifecycle

- (void)didLoadFromCCB
{
    // Enable touches
    self.userInteractionEnabled = YES;
    
    // Init array to hold all cells
    _allCells = [[NSMutableArray alloc] init];
    
    // Get current time
    currentTime = [self getHourFromCurrentTime];
    
    // Load NSUser isPopupOpen
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isPopupOpen"];
    isPopupOpen = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isPopupOpen"] boolValue];
    
    // Sync NSUserDefaults
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Listen for Swipes Down
    UISwipeGestureRecognizer *swipeDown= [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(refreshTable)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeDown];
    
    // Create place objects and add them to allCells array
    for (NSMutableDictionary *placeData in [PlaceData allPlaces])
    {
        // Init place object with place data
        PlaceObject *place = [[PlaceObject alloc] initWithData:placeData];
        
        // Add to allCells array
        [_allCells addObject:place];
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
    // Parse query to get places
    query = [PFQuery queryWithClassName:@"Places"];
    
    // Initialize TableViewCell
    CCTableViewCell *cell = [[CCTableViewCell alloc] init];
	   
    // Current cell represents a place
    PlaceObject *place = [_allCells objectAtIndex:index];
    
    // Load a PlaceCell
    PlaceCell *cellContent = (PlaceCell *)[CCBReader load:@"PlaceCell"];
    
    // Set the cell's label
    cellContent.placeLabel.string = place.name;
    
    // Get place by parse object ID
    [query getObjectInBackgroundWithId:place.objID block:^(PFObject *placeObj, NSError *error)
     {
         // Get the time the object was last updated at
         NSString *timeUpdatedAt = [placeObj objectForKey:@"timeUpdatedAt"];
         
         // Get value of last hour the object was updated at
         int hourLastUpdated = [[placeObj objectForKey:@"HourLastUpdated"] intValue];
         
         // Get values of object's NOT BUSY requests
         int notBusyRequests = [[placeObj objectForKey:@"NBR"] intValue];
         
         // Get values of object's MILD requests
         int mildRequests = [[placeObj objectForKey:@"MR"] intValue];

         // Get values of object's BUSY requests
         int busyRequests = [[placeObj objectForKey:@"BR"] intValue];
         
         // Figure out if the location has not been updated in a while
         int timeSinceLastUpdate = currentTime - hourLastUpdated;
         
         // If the place hasn't been updated in a while
         // Or timeSinceLastUpdate is negative
         if ((timeSinceLastUpdate > timeToUpdate) || (timeSinceLastUpdate < 0))
        {
            // Then reset the request values to zero
             busyRequests = 0;
             mildRequests = 0;
             notBusyRequests = 0;
         }
         
         // Set time updated at label
         cellContent.updatedAtLabel.string = [NSString stringWithFormat:@"Updated at:\n%@",timeUpdatedAt];
         
         /*  Main Cases */
         // Check if there are mostly not busy requests
         if ((notBusyRequests > mildRequests) && (notBusyRequests > busyRequests))
         {
             // Set the parse object status
             placeObj[@"Status"] = @"NOTBUSY";
             
             // Set the place object status
             place.status = @"NOTBUSY";
             
             // Save the parse object status
             [placeObj saveInBackground];
         }
         
         // Check if there are mostly mild requests
         if ((mildRequests > notBusyRequests) && (mildRequests > busyRequests))
         {
             // Set the parse object status
             placeObj[@"Status"] = @"MILD";
             
             // Set the place object status
             place.status = @"MILD";
             
             // Save the parse object's status
             [placeObj saveInBackground];
         }
         
         // Check if there are mostly busy requests
         if ((busyRequests > notBusyRequests) && (busyRequests > mildRequests))
         {
             // Set the parse object status
             placeObj[@"Status"] = @"BUSY";
             
             // Set the place object status
             place.status = @"BUSY";
             
             // Save the parse object's status
             [placeObj saveInBackground];
         }
         
         /* Intermediate Cases */
         // Check if there are equal level 1 requests
         if ((notBusyRequests == mildRequests) && (notBusyRequests > busyRequests) && (mildRequests > busyRequests))
         {
             // Set the parse object status
             placeObj[@"Status"] = @"MILD";
             
             // Set the place object status
             place.status = @"MILD";
             
             // Save the parse object's status
             [placeObj saveInBackground];
         }
         
         // Check if there are equal level 2 requests
         if ((busyRequests == mildRequests) && (busyRequests > notBusyRequests) && (mildRequests > notBusyRequests))
         {
             // Set the parse object status
             placeObj[@"Status"] = @"BUSY";
             
             // Set the place object status
             place.status = @"BUSY";
             
             // Save the parse object's status
             [placeObj saveInBackground];
         }
         
         /* Extraneous Cases */
         // Check if there are equal opposite requests
         if ((notBusyRequests == busyRequests) && (notBusyRequests == mildRequests) && (mildRequests == busyRequests))
         {
             // Set the parse object status
             placeObj[@"Status"] = @"NOTBUSY";
             
             // Set the place object status
             place.status = @"NOTBUSY";
         }
         
         // Set the cell's color
         if ([place.status isEqualToString:@"BUSY"]) {
             // Red Color
             cellContent.placeColor.color = [CCColor colorWithRed:0.5f green:0.f blue:0.f];
             
             // Set status label
             cellContent.statusLabel.string = @"is busy";
         }
         else if ([place.status isEqualToString:@"MILD"]) {
             // Blue Color
             cellContent.placeColor.color = [CCColor colorWithRed:0.f green:0.f blue:0.5f];
             
             // Set status label
             cellContent.statusLabel.string = @"is mildly busy";
         }
         else {
             // Green Color
             cellContent.placeColor.color = [CCColor colorWithRed:0.f green:0.5f blue:0.f];
             
             // Set status label
             cellContent.statusLabel.string = @"is not busy";
         }
     }];
    
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
    // Load NSUser isPopupOpen
    isPopupOpen = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isPopupOpen"] boolValue];
    
    // Get the index
	NSInteger index = _tableView.selectedRow;
    
    // Current cell represents a place
    PlaceObject *place = [_allCells objectAtIndex:index];
    
    // Check if a popup is already open
    if (isPopupOpen)
    {
        // If it is, close it
        [self removeChild:self.currentPopup];
        
        // Toggle isPopupOpen state
        [self togglePopupBool];
    }
    
    // Else, info popup is not already open
    else
    {
        // Load the place's popup
        InfoPopup *infoPopup = (InfoPopup *)[CCBReader load:@"InfoPopup"];
        
        // Then position and initalize the popup
        infoPopup.positionType = CCPositionTypeNormalized;
        infoPopup.position = ccp(0.5,0.5);
        infoPopup.placeNameLabel.string = place.name;
        infoPopup.objectIDLabel.string = place.objID;
        
        // Then set boolean flag to true
        [self togglePopupBool];
        
        // Then add popup as child to main scene
        [self addChild:infoPopup];
        
        // Add as current popup
        self.currentPopup = infoPopup;
    }
}

#pragma mark - Helper Methods

// Check if pop up display is open
- (void)togglePopupBool
{
    // Toggle open or closed
    if (isPopupOpen)
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isPopupOpen"];
    else
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isPopupOpen"];
}

// Get the current hour value (0-23)
- (int)getHourFromCurrentTime
{
    // Init hour variable
    int hour;
    
    // Init calendar variable
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    // Get current date
    NSDate *now = [NSDate date];
    
    // Set Timezone to Boston
    NSTimeZone *tz = [NSTimeZone timeZoneWithName:@"America/Boston"];
    [cal setTimeZone:tz];
    
    // Extract hour from date
    NSDateComponents *comp = [cal components:NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:now];
    hour = [comp hour];
    
    return hour;
}

#pragma mark - Selectors

- (void)refreshTable
{
    // Refresh list when clicked
    [_tableView reloadData];
}

- (void)contactButton
{
    // Loads contact popup
    ContactPopup *contactPopup = (ContactPopup *)[CCBReader load:@"ContactPopup"];
    
    // Position the popup
    contactPopup.positionType = CCPositionTypeNormalized;
    contactPopup.position = ccp(0.5,0.5);
    
    // Add child to main scene
    [self addChild:contactPopup];
}

@end
