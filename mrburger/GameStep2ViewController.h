//
//  GameStep2ViewController.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameStepViewController.h"

#import "GameViewController.h"

#import "TitledTable.h"
#import "TitledTableAlternate.h"

#import "SessionManager.h"

#import "GameStep2MainView.h"
#import "GameStep2InfoView.h"
#import "GameStep2InviteView.h"
#import "GameStep2ConnectingView.h"
#import "GameStep2ConnectedView.h"

#import "ParticipantsTableViewController.h"
#import "NearbyTableViewController.h"

@interface GameStep2ViewController : GameStepViewController <SessionManagerDelegate>

@property (strong, nonatomic) ParticipantsTableViewController *participantsTVC;
@property (strong, nonatomic) NearbyTableViewController *nearbyTVC;
@property int connected;

@property (strong, nonatomic) NSString *currentPeerID;
@property BOOL isConnected;

@property (strong, nonatomic) TitledTable *participantsView;
@property (strong, nonatomic) TitledTableAlternate *nearbyView;
@property (strong, nonatomic) UIButton *btnSave;
@property (strong, nonatomic) UILabel *participantsCTA;
@property (strong, nonatomic) NSTimer *statusTimer;

@property (strong, nonatomic) SessionManager *sessionManager;

- (id)initWithSessionManager:(SessionManager *)sessionManager;

- (void) peerListDidChange:(SessionManager *)session;
- (void) didReceiveInvitation:(SessionManager *)session fromPeer:(NSString *)peer;
- (void) invitationDidFail:(SessionManager *)session fromPeer:(NSString *)peer;

- (void) acceptInvitation:(id)sender;

@end
