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
@synthesize connected = _connected;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSLog(@"showing main view");
        self.mainView = [[GameStep2MainView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
        NSLog(@"showing modal");
        self.modal = [[GameStep2InfoView alloc] initModal];
        self.modal.delegate = self;
        
        NSLog(@"setting connected info");
        self.isConnected = false;
        self.connected = 1; // Self makes it 1
        
        NSLog(@"initing view");
        self.presentingView = [[ModalPresentingView alloc] initWithMain:self.mainView andModal:self.modal];
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"hasfree"] isEqualToString:@"true"]) {
            [self showModal:nil];
        }
        
        NSLog(@"starting status bar updates");
        [self startStatusBarUpdates];
        
        NSLog(@"setting a timer");
        self.statusTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(startStatusBarUpdates) userInfo:nil repeats:YES];
    }
    return self;
}

- (id)initWithSessionManager:(SessionManager *)sessionManager
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.sessionManager = sessionManager;
        self.sessionManager.delegate = self;
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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showConnecting:) name:@"SENT_INVITE" object:self.nearbyTVC];
	}
    
    self.btnSave = [[RoundedButtonAlternate alloc] initWithText:@"Save my burger" andX:15 andY:235];
    self.btnSave.titleLabel.font  = [UIFont fontWithName:@"Mission-Script" size:FontMissionSizeTiny];
    [self.btnSave setTitle:@"Save my burger" forState:UIControlStateNormal];
    self.btnSave.hidden = YES;
    CGRect btnSaveFrame = self.btnSave.frame;
    btnSaveFrame.size.width = 290;
    self.btnSave.frame = btnSaveFrame;

    [self.mainView insertSubview:self.btnSave atIndex:0];
    [self.btnSave addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    
    self.participantsView = [[TitledTable alloc] initWithFrame:CGRectMake(15, 60, 290, 162) andTitle:@"Your burger"];
    [self.mainView addSubview:self.participantsView];
    [self.participantsView.tableView setDataSource:self.participantsTVC];
    [self.participantsView.tableView setDelegate:self.participantsTVC];
    self.participantsView.tableView.hidden = NO;
    self.participantsView.unavailable.hidden = YES;
    self.participantsView.userInteractionEnabled = NO;
    
    self.participantsCTA = [[UILabel alloc] initWithFontTravelerAndFrame:CGRectMake(15, 172, 290, 22) andSize:FontTravelerSizeSmall andColor:[UIColor colorWithRed:0.678 green:0.675 blue:0.624 alpha:1.000]];
    self.participantsCTA.backgroundColor = [UIColor clearColor];
    self.participantsCTA.text = @"Find one to four other ingredients";
    self.participantsCTA.hidden = NO;
    [self.presentingView.mainView addSubview:self.participantsCTA];
    
    self.nearbyView = [[TitledTableAlternate alloc] initWithFrame:CGRectMake(15, 200, 290, 230) andTitle:@"Find ingredients"];
	[self.mainView addSubview:self.nearbyView];
    [self.nearbyView.tableView setDataSource:self.nearbyTVC];
    [self.nearbyView.tableView setDelegate:self.nearbyTVC];
    self.nearbyView.tableView.hidden = YES;
    self.nearbyView.unavailable.hidden = NO;
    self.nearbyView.tableView.scrollEnabled = NO;
    
    [self peerListDidChange:nil];
}

- (void)save:(id)sender
{
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    [self.btnSave removeTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];

    [self stopStatusBarUpdates];
    GameViewController *gameVC = (GameViewController *)self.navigationController;
    [gameVC postBurgerToServer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showConnecting:(id)sender
{
    self.modal = [[GameStep2ConnectingView alloc] initModal];
    
    [self showModal:nil];
}

- (void)peerListDidChange:(SessionManager *)session
{
	self.participantsTVC.participants = [self.sessionManager.connectedPeers mutableCopy];
    self.nearbyTVC.nearby = [self.sessionManager.availablePeers mutableCopy];

    if ([self.sessionManager.availablePeers count] == 0) {
        self.nearbyView.tableView.hidden = YES;
        self.nearbyView.unavailable.hidden = NO;
    } else {
        self.nearbyView.tableView.hidden = NO;
        self.nearbyView.unavailable.hidden = YES;
        [self stopStatusBarUpdates];
    }

    self.connected = [self.sessionManager.connectedPeers count];

    if (self.connected > 1) {
        self.btnSave.hidden = NO;
        CGRect btnSaveFrame = self.btnSave.frame;
        self.btnSave.frame = CGRectMake(btnSaveFrame.origin.x, 110 + self.connected * 64, btnSaveFrame.size.width, btnSaveFrame.size.height);
        
        self.nearbyView.title.text = @"ADD MORE INGREDIENTS";
        
        uint height = 130;
        
        if ([self.sessionManager.availablePeers count] > 1) {
            height = 66 + [self.sessionManager.availablePeers count] * 64;
        }
        
        self.nearbyView.frame = CGRectMake(15, 170 + self.connected * 64, 290, height);
        
        self.participantsCTA.hidden = YES;
    } else {
        self.btnSave.hidden = YES;
        
        uint height = 130;
        
        if ([self.sessionManager.availablePeers count] > 1) {
            height = 66 + [self.sessionManager.availablePeers count] * 64;
        }

        self.nearbyView.frame = CGRectMake(15, 200, 290, height);
        self.nearbyView.title.text = @"FIND INGREDIENTS";
        self.participantsCTA.hidden = NO;
    }
    
    self.participantsView.tableView.frame = CGRectMake(0, 40, self.participantsView.tableView.frame.size.width, self.connected * 64);
        
	[self.participantsView.tableView reloadData];
    [self.nearbyView.tableView reloadData];    
}

- (void) didReceiveInvitation:(SessionManager *)session fromPeer:(NSString *)peer;
{
    NSLog(@"This device did receive an invitation from %@", peer);
    
    [KGStatusBar showWithStatus:@"You received an invitation!"];
    
    self.currentPeerID = peer;
    
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIDeviceProximityStateDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
        UIDevice *currentDevice = [UIDevice currentDevice];
        if (currentDevice.proximityState && currentDevice.proximityMonitoringEnabled) {
            [self acceptInvitation:nil];
        }
    }];
    
    User *tmpuser =  [self.sessionManager userForPeer:self.currentPeerID];
    GameStep2InviteView *inviteView = [[GameStep2InviteView alloc] initModalWithUser:tmpuser];
    [inviteView.declineBtn addTarget:self action:@selector(declineInvitation:) forControlEvents:UIControlEventTouchUpInside];
    self.modal = inviteView;
    [self showModal:nil];
}

- (void)showInvitationWithPeer:(NSString *)peer
{
    [KGStatusBar showWithStatus:@"You received an invitation!"];
    
    self.currentPeerID = peer;
    
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectProximity:) name:UIDeviceProximityStateDidChangeNotification object:nil];
        
    GameStep2InviteView *inviteView = [[GameStep2InviteView alloc] initModal];
    [inviteView.declineBtn addTarget:self action:@selector(declineInvitation:) forControlEvents:UIControlEventTouchUpInside];
    self.modal = inviteView;
    [self showModal:nil];
}

- (void)detectProximity:(id)notification
{
    UIDevice *currentDevice = [UIDevice currentDevice];
    if (currentDevice.proximityState && currentDevice.proximityMonitoringEnabled) {
        [self acceptInvitation:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceProximityStateDidChangeNotification object:nil];
    }

}

- (void)declineInvitation:(id)sender
{
    if (self.currentPeerID) {
        [self.sessionManager declineInvitationFrom:self.currentPeerID];
        [self hideModal:nil];
        self.currentPeerID = nil;
    }
}

- (void) invitationDidFail:(SessionManager *)session fromPeer:(NSString *)peer
{
    [KGStatusBar showWithStatus:@"Connection failed"];
    [self hideModal:nil];
//    [self.sessionManager declineInvitationFrom:peer];
}

- (void) acceptInvitation:(id)sender
{
    [self stopStatusBarUpdates];
    
    NSLog(@"accepting");
//    [self hideModal:nil];
    
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceProximityStateDidChangeNotification object:nil];
    
    self.isConnected = true;
    
    [self.sessionManager acceptInvitationFrom:self.currentPeerID];
        
    [self hideModal:nil];
    
    [self performSelector:@selector(showConnected) withObject:nil afterDelay:1];
}

- (void)showConnected
{
    GameStep2ConnectedView *modal = [[GameStep2ConnectedView alloc] initModal];
    [modal.btnDisconnect addTarget:self action:@selector(leaveBurger:) forControlEvents:UIControlEventTouchUpInside];
    
    self.modal = modal;
    [self showModal:nil];
}

- (void)leaveBurger:(id)sender
{
    [self.sessionManager leavePeer:self.currentPeerID];
    [self hideModal:nil];
}

- (void)peer:(NSString *)peer didAcceptInvitation:(SessionManager *)sessionManager
{
    [self stopStatusBarUpdates];
    [self hideModal:nil];    
}

- (void)peer:(NSString *)peer didDeclineInvitation:(SessionManager *)sessionManager
{
    [self stopStatusBarUpdates];
    [self hideModal:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self stopStatusBarUpdates];
}

- (void)startStatusBarUpdates
{
    NSArray *statuses = [NSArray arrayWithObjects:@"Looking for others..", @"Searching for ingredients..", @"Still looking..", @"Anyone around?", @"Hello? Anyone?", nil];
    [KGStatusBar showStatusAndDismiss:[statuses objectAtIndex:(arc4random() % [statuses count])]];
}

- (void)stopStatusBarUpdates
{
    [KGStatusBar dismiss];
    [self.statusTimer invalidate];
    self.statusTimer = nil;
}


@end
