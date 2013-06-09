//
//  GameStep2ViewController.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameStep2ViewController.h"

@implementation GameStep2ViewController

@synthesize sessionManager = _sessionManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.mainView = [[GameStep2MainView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.modal = [[GameStep2InfoView alloc] initModal];
        self.modal.delegate = self;
        
        self.presentingView = [[GameStep2View alloc] initWithMain:self.mainView andModal:self.modal];
    }
    return self;
}

- (id)initWithSessionManager:(SessionManager *)sessionManager
{
    self = [super init];
    if (self) {
        self.sessionManager = sessionManager;
        self.sessionManager.tableViewControllerDelegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	    
    if (self.participantsTVC == nil) {
		self.participantsTVC = [[ParticipantsTableViewController alloc] initWithSessionManager:self.sessionManager];
	}
	
    if (self.nearbyTVC == nil) {
		self.nearbyTVC = [[NearbyTableViewController alloc] initWithSessionManager:self.sessionManager];
	}
    
    self.participantsView = [[TitledTable alloc] initWithFrame:CGRectMake(15, 60, 290, 160) andTitle:@"Your burger"];
    [self.mainView addSubview:self.participantsView];
    [self.participantsView.tableView setDataSource:self.participantsTVC];
    [self.participantsView.tableView setDelegate:self.participantsTVC];
    
    self.nearbyView = [[TitledTable alloc] initWithFrame:CGRectMake(15, 280, 290, 160) andTitle:@"Find ingredients"];
	[self.mainView addSubview:self.nearbyView];
    [self.nearbyView.tableView setDataSource:self.nearbyTVC];
    [self.nearbyView.tableView setDelegate:self.nearbyTVC];
    
    [self peerListDidChange:nil];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)peerListDidChange:(SessionManager *)session
{
	self.participantsTVC.participants = [self.sessionManager.connectedPeers copy];
    self.nearbyTVC.nearby = [self.sessionManager.availablePeers copy];

	[self.participantsView.tableView reloadData];
    [self.nearbyView.tableView reloadData];
}

- (void) didReceiveInvitation:(SessionManager *)session fromPeer:(NSString *)participantID;
{
    NSLog(@" --- DID RECEIVE INVITATION --- ");
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIDeviceProximityStateDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
        if ([UIDevice currentDevice].proximityState) {
            [self acceptInvitation:nil];
        }
    }];
    
    self.modal = [[GameStep2InviteView alloc] initModal];
    [self showModal:nil];
}

- (void) invitationDidFail:(SessionManager *)session fromPeer:(NSString *)participantID
{
    NSLog(@"Invitation FAIL");
}

- (void) acceptInvitation:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
//        [self.navigationController pushViewController:[[ParticipantViewController alloc] initWithNibName:nil bundle:nil] animated:YES];
    }];
    [self.sessionManager didAcceptInvitation];
    [self peerListDidChange:self.sessionManager];
}

@end
