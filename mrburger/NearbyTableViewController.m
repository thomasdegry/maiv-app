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
@synthesize unavailable = _unavailable;

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
    self.unavailable = [[UnavailableCell alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 70)];
    [self.view addSubview:self.unavailable];
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
    
    NSString *prefix;
    
    if ([user.gender isEqualToString:@"m"]) {
        prefix = @"Mr";
    } else {
        prefix = @"Ms";
    }
    
    cell.textLabel.text = [[NSString stringWithFormat:@"%@. %@", prefix, user.ingredient.name] uppercaseString];
    cell.detailTextLabel.text = user.name;
    cell.picturePath = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?width=104&height=104", user.id];
    cell.imageView.image = [UIImage imageNamed:@"happy_face"];
    
	return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SENT_INVITE" object:self];
    [self.sessionManager connect:[self.nearby objectAtIndex:[indexPath row]]];
}

@end