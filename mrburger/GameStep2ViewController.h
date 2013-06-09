//
//  GameStep2ViewController.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameStepViewController.h"

#import "TitledTable.h"

#import "SessionManager.h"

#import "GameStep2View.h"
#import "GameStep2MainView.h"
#import "GameStep2InfoView.h"
#import "GameStep2InviteView.h"

#import "ParticipantsTableViewController.h"
#import "NearbyTableViewController.h"

@interface GameStep2ViewController : GameStepViewController

@property (strong, nonatomic) ParticipantsTableViewController *participantsTVC;
@property (strong, nonatomic) NearbyTableViewController *nearbyTVC;

@property (strong, nonatomic) TitledTable *participantsView;
@property (strong, nonatomic) TitledTable *nearbyView;

@property (strong, nonatomic) SessionManager *sessionManager;

- (id)initWithSessionManager:(SessionManager *)sessionManager;

- (void) peerListDidChange:(SessionManager *)session;
- (void) didReceiveInvitation:(SessionManager *)session fromPeer:(NSString *)participantID;
- (void) invitationDidFail:(SessionManager *)session fromPeer:(NSString *)participantID;

- (void) acceptInvitation:(id)sender;

@end
