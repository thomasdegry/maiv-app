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
    [self.tableView registerClass:[NearbyCell class] forCellReuseIdentifier:@"NearbyCellIdentifier"];
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
	
	NearbyCell *cell = [tableView dequeueReusableCellWithIdentifier:NearbyCellIdentifier];
	
    if (!cell) {
		cell = [[NearbyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NearbyCellIdentifier];
	}
    
	NSUInteger row = [indexPath row];
	
    User *user = [self.sessionManager userForPeerID:[self.nearby objectAtIndex:row]];
    NSData *userImageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?width=104&height=104", user.id]]];
    UIImage *userImage = [UIImage imageWithData:userImageData scale:0.5f];
    
    cell.textLabel.text = [user.name uppercaseString];
    cell.detailTextLabel.text = user.gender;
    cell.imageView.image = userImage;
    
	return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.sessionManager connect:[self.nearby objectAtIndex:[indexPath row]]];
}

@end