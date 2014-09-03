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
    
    // Add all place data to allCells array
    for (NSMutableDictionary *placeData in [PlaceData allPlaces])
    {
        PlaceObject *place = [[PlaceObject alloc] initWithData:placeData];
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
    
    // Set the cell's color
    // BUSY = Red Color
    // MILD = Yellow Color
    // OPEN = Green Color
    if ([place.status isEqualToString:@"BUSY"])
        cellContent.placeColor.color = [CCColor redColor];
    else if ([place.status isEqualToString:@"MILD"])
        cellContent.placeColor.color = [CCColor yellowColor];
    else
        cellContent.placeColor.color = [CCColor greenColor];
    
    // Add cellContent to cell
    [cell addChild:cellContent];
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
    // Returns total amount of places
	return [_allCells count];
}

@end
