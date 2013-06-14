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
        self.mainView = [[GameStep2MainView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.modal = [[GameStep2InfoView alloc] initModal];
        self.modal.delegate = self;
        
        self.connected = 1; // Self makes it 1
        
        self.presentingView = [[ModalPresentingView alloc] initWithMain:self.mainView andModal:self.modal];
        [self showModal:nil];
    }
    return self;
}

- (id)initWithSessionManager:(SessionManager *)sessionManager
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.sessionManager = sessionManager;
        [self.sessionManager setupSession];
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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showConnecting:) name:@"SENT_INVITE" object:self.nearbyTVC];
	}
    
    self.btnSave = [[RoundedButtonAlternate alloc] initWithText:@"Save my burger" andX:15 andY:235];
    self.btnSave.titleLabel.font  = [UIFont fontWithName:@"Mission-Script" size:FontMissionSizeTiny];
    [self.btnSave setTitle:@"Save my burger" forState:UIControlStateNormal];
    self.btnSave.hidden = YES;
    CGRect btnSaveFrame = self.btnSave.frame;
    btnSaveFrame.size.width = 290;
    self.btnSave.frame = btnSaveFrame;
    //[self.mainView addSubview:self.btnSave];
    [self.mainView insertSubview:self.btnSave atIndex:0];
    [self.btnSave addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    
    self.participantsView = [[TitledTable alloc] initWithFrame:CGRectMake(15, 60, 290, 162) andTitle:@"Your burger"];
    [self.mainView addSubview:self.participantsView];
    [self.participantsView.tableView setDataSource:self.participantsTVC];
    [self.participantsView.tableView setDelegate:self.participantsTVC];
    self.participantsView.tableView.hidden = NO;
    self.participantsView.unavailable.hidden = YES;
    
    self.participantsCTA = [[UILabel alloc] initWithFontTravelerAndFrame:CGRectMake(15, 182, 290, 44) andSize:FontTravelerSizeSmall andColor:[UIColor colorWithRed:0.678 green:0.675 blue:0.624 alpha:1.000]];
    self.participantsCTA.text = @"Find one to four other ingredients";
    self.participantsCTA.hidden = NO;
    [self.presentingView.mainView addSubview:self.participantsCTA];
    
    self.nearbyView = [[TitledTableAlternate alloc] initWithFrame:CGRectMake(15, 260, 290, 230) andTitle:@"Find ingredients"];
	[self.mainView addSubview:self.nearbyView];
    [self.nearbyView.tableView setDataSource:self.nearbyTVC];
    [self.nearbyView.tableView setDelegate:self.nearbyTVC];
    self.nearbyView.tableView.hidden = YES;
    self.nearbyView.unavailable.hidden = NO;

    [self peerListDidChange:nil];
}

- (void)save:(id)sender
{
    NSLog(@"saving");
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
	self.participantsTVC.participants = [self.sessionManager.connectedPeers copy];
    self.nearbyTVC.nearby = [self.sessionManager.availablePeers copy];

    if ([self.sessionManager.availablePeers count] == 0) {
        self.nearbyView.tableView.hidden = YES;
        self.nearbyView.unavailable.hidden = NO;
       
    } else {
        self.nearbyView.tableView.hidden = NO;
        self.nearbyView.unavailable.hidden = YES;
    }
  
   
    
    if (self.connected < [self.sessionManager.connectedPeers count]) {
        [self hideModal:nil];
    }
    
    
    self.connected = [self.sessionManager.connectedPeers count];
    
    if (self.connected > 1) {
        NSLog(@"participants %i", self.connected);
        self.btnSave.hidden = NO;
        self.nearbyView.title.text = @"ADD MORE INGREDIENTS";
        self.nearbyView.frame = CGRectMake(15, 290, 290, 130);
         self.participantsCTA.hidden = YES;
    }else {
        self.btnSave.hidden = YES;
         self.nearbyView.frame = CGRectMake(15, 260, 290, 130);
        self.nearbyView.title.text = @"FIND INGREDIENTS";
         self.participantsCTA.hidden = NO;
    }
    
	[self.participantsView.tableView reloadData];
    [self.nearbyView.tableView reloadData];
}

- (void) didReceiveInvitation:(SessionManager *)session fromPeer:(NSString *)participantID;
{
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIDeviceProximityStateDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
        if ([UIDevice currentDevice].proximityState) {
            [self acceptInvitation:nil];
        }
    }];
    
    GameStep2InviteView *inviteView = [[GameStep2InviteView alloc] initModal];
    [inviteView.declineBtn addTarget:self action:@selector(declineInvitation:) forControlEvents:UIControlEventTouchUpInside];
    self.modal = inviteView;
    [self showModal:nil];
}

- (void)declineInvitation:(id)sender
{
    [self.sessionManager didDeclineInvitation];
    [self hideModal:nil];
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
}

- (void) invitationDidFail:(SessionManager *)session fromPeer:(NSString *)participantID
{
    [self.sessionManager didDeclineInvitation];
    [self hideModal:nil];
}

- (void) acceptInvitation:(id)sender
{
    [self hideModal:nil];
    
    self.modal = [[GameStep2ConnectedView alloc] initModal];
    [self showModal:nil];
    
    [self.sessionManager didAcceptInvitation];
    [self peerListDidChange:self.sessionManager];
}



@end
