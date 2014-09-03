//
//  MainScene.m
//  WHATS BUSY
//
//  Created by Mrk on 09/01/14.
//  Copyright (c) 2014 Mark Barrasso. All rights reserved.
//

#import "MainScene.h"
#import "PlaceCell.h"
#import "PlaceData.h"
#import "PlaceObject.h"

@implementation MainScene
{
    // Table View
    CCTableView *_tableView;
    CCNode *_tableViewNode;
    
    // All Places
    NSMutableArray *_allCells;
}

#pragma mark - Lifecycle

- (void)didLoadFromCCB
{
    // Enable touches
    self.userInteractionEnabled = YES;
    
    // Init array to hold all cells
    _allCells = [[NSMutableArray alloc] init];
    
    // Create place objects and add them to allCells array
    for (NSMutableDictionary *placeData in [PlaceData allPlaces])
    {
        // Init place object with place data
        PlaceObject *place = [[PlaceObject alloc] initWithData:placeData];
        
        // Find people at location per place here
        
        // Add to allCells array
        [_allCells addObject:place];
    }
    
    // Sets up the main table view
    [self setupTableView];
    
    [CCEffectBlur effectWithBlurRadius:100];
}

- (void)dealloc
{
    // Remove table view delegate when this class is deallocated
    [_tableView setTarget:nil selector:nil];
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
        
    // Determine the place's status
    if (place.peopleAtLocation >= 10)
        place.status = @"BUSY";
    else if (place.peopleAtLocation >= 5)
        place.status = @"MILD";
    else
        place.status = @"OPEN";
    
    // Set the cell's color
    // BUSY = Red
    // MILD = Blue
    // OPEN = Green
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
    cell.contentSize = CGSizeMake(1.f, 50.f);
	
    // Returns the cell
	return cell;
}

// This method is called automatically by the CCTableView to create cells
- (float) tableView:(CCTableView*)tableView heightForRowAtIndex:(NSUInteger) index
{
	return 50;
}

// This method is called automatically by the CCTableView to create cells
- (NSUInteger) tableViewNumberOfRows:(CCTableView*) tableView
{
    // Returns total amount of places in allCells array
	return [_allCells count];
}

@end
