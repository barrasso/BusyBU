//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "PlaceCell.h"

@implementation MainScene
{
    // Table View
    CCTableView *_tableView;
    CCNode *_tableViewNode;
}

#pragma mark - Lifecycle

- (void)dealloc
{
    // Remove table view delegate when this class is deallocated
    [_tableView setTarget:nil selector:nil];
}

- (void)didLoadFromCCB
{
    // Enable touches
    self.userInteractionEnabled = YES;
    
    // Sets up the main table view
    [self setupTableView];
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
//	[_tableView setTarget:self selector:@selector(tableViewCellSelected:)];
    
    // Set table view as the data source
    _tableView.dataSource = self;
}

// This method is called automatically by the CCTableView to create cells
- (CCTableViewCell*)tableView:(CCTableView*)tableView nodeForRowAtIndex:(NSUInteger)index
{
    CCTableViewCell *cell = [[CCTableViewCell alloc] init];
	   
    // Load a PlaceCell content
    PlaceCell *cellContent = (PlaceCell *)[CCBReader load:@"PlaceCell"];
    
    // Add cellContent to cell
    [cell addChild:cellContent];
    cell.contentSizeType = CCSizeTypeMake(CCSizeUnitNormalized, CCSizeUnitPoints);
    cell.contentSize = CGSizeMake(1.f, 50.f);
	
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
	return 5;
}

@end
