//
//  ParticipantsTableViewController.m
//  ProtoPeers
//
//  Created by Pieter Beulque on 5/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "ParticipantsTableViewController.h"

@interface ParticipantsTableViewController ()

@end

@implementation ParticipantsTableViewController

@synthesize sessionManager = _sessionManager;
@synthesize participants = _participants;

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
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ParticipantsCellIdentifier"];
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
    if (self.participants) {
        return [self.participants count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *ParticipantsCellIdentifier = @"ParticipantsCellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ParticipantsCellIdentifier];
	
    if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ParticipantsCellIdentifier];
	}
    
	NSUInteger row = [indexPath row];
	
    User *user = [self.sessionManager userForPeerID:[self.participants objectAtIndex:row]];
    
    cell.textLabel.text = user.name;
    
	return cell;
}

#pragma mark - Table view delegate
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self.sessionManager connect:[self.participants objectAtIndex:[indexPath row]]];
//}

@end
