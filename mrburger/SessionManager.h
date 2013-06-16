//
//  SessionManager.h
//  ProtoPeers
//
//  Created by Pieter Beulque on 5/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "KGStatusBar.h"

#import "Ingredient.h"
#import "User.h"

@class SessionManager;

@protocol SessionManagerDelegate <NSObject>

- (void)peerListDidChange:(SessionManager *)sessionManager;
- (void)didReceiveInvitation:(SessionManager *)sessionManager fromPeer:(NSString *)peerID;
- (void)invitationDidFail:(SessionManager *)sessionManager fromPeer:(NSString *)peerID;

@end

@interface SessionManager : NSObject <GKSessionDelegate>

@property (strong, nonatomic) GKSession *session;

@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) User *user;

@property (strong, nonatomic) NSMutableArray *availablePeers;
@property (strong, nonatomic) NSMutableArray *connectedPeers;

@property (strong, nonatomic) NSString *currentConfPeerID;

@property (strong, nonatomic) id delegate;

- (id)initWithUser:(User *)user;

- (void)setupSession;
- (void)teardownSession;

- (void)acceptInvitationFrom:(NSString *)peer;
- (void)declineInvitationFrom:(NSString *)peer;
- (void)connect:(NSString *)peer;
- (User *)userForPeer:(NSString *)peer;

@end