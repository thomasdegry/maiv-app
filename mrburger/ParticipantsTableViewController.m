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
    [self.tableView registerClass:[ParticipantCell class] forCellReuseIdentifier:@"ParticipantsCellIdentifier"];
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
	
	ParticipantCell *cell = [tableView dequeueReusableCellWithIdentifier:ParticipantsCellIdentifier];
	
    if (!cell) {
		cell = [[ParticipantCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ParticipantsCellIdentifier];
	}
    
	NSUInteger row = [indexPath row];
	
    User *user = [self.sessionManager userForPeerID:[self.participants objectAtIndex:row]];
    NSData *userImageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture", user.id]]];
    UIImage *userImage = [UIImage imageWithData:userImageData];
    
    cell.textLabel.text = [user.name uppercaseString];
    cell.detailTextLabel.text = user.gender;
    cell.imageView.image = userImage;
    
	return cell;
}

#pragma mark - Table view delegate
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self.sessionManager connect:[self.participants objectAtIndex:[indexPath row]]];
//}

@end
