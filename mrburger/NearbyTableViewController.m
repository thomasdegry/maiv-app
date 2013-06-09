//
//  NearbyTableViewController.m
//  ProtoPeers
//
//  Created by Pieter Beulque on 5/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "NearbyTableViewController.h"

@interface NearbyTableViewController ()

@end

@implementation NearbyTableViewController

@synthesize sessionManager = _sessionManager;
@synthesize nearby = _nearby;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithSessionManager:(SessionManager *)sessionManager
{
    self = [self initWithStyle:UITableViewStylePlain];
    
    if (self) {
        self.sessionManager = sessionManager;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NearbyCellIdentifier"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.nearby) {
        return [self.nearby count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *NearbyCellIdentifier = @"NearbyCellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NearbyCellIdentifier];
	
    if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NearbyCellIdentifier];
	}
    
	NSUInteger row = [indexPath row];
	
	cell.textLabel.text = [self.sessionManager displayNameForPeer:[self.nearby objectAtIndex:row]];
    
	return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.sessionManager connect:[self.nearby objectAtIndex:[indexPath row]]];
}

@end