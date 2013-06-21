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
#import "Burger.h"

typedef enum {
    PacketTypeInvite = 0,
    PacketTypeAccept = 1,
    PacketTypeDecline = 2,
    PacketTypeJoining = 3,
    PacketTypeDisconnect = 4,
    PacketTypeBurger = 5,
    PacketTypeKeepAlive = 6
} PacketType;

@class SessionManager;

@protocol SessionManagerDelegate <NSObject>

- (void)peerListDidChange:(SessionManager *)sessionManager;

- (void)didReceiveInvitation:(SessionManager *)sessionManager fromPeer:(NSString *)peerID;
- (void)peer:(NSString *)peer didAcceptInvitation:(SessionManager *)sessionManager;
- (void)peer:(NSString *)peer didDeclineInvitation:(SessionManager *)sessionManager;
- (void)invitationDidFail:(SessionManager *)sessionManager fromPeer:(NSString *)peerID;

@end

@interface SessionManager : NSObject <GKSessionDelegate>

@property (strong, nonatomic) GKSession *session;

@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) User *user;

@property (strong, nonatomic) NSMutableArray *availablePeers;
@property (strong, nonatomic) NSMutableArray *connectedPeers;
@property (strong, nonatomic) NSMutableArray *connectingPeers;

//@property (strong, nonatomic) NSString *currentConfPeerID;

@property (assign) BOOL allowsInvitation;

@property (strong, nonatomic) id delegate;

- (id)initWithUser:(User *)user;

- (void)setupSession;
- (void)teardownSession;
- (void)stopSearching;

- (void)sendPacket:(NSData *)data ofType:(PacketType)type toPeers:(NSArray *)peers;

- (void)invitePeer:(NSString *)peer;
- (void)acceptInvitationFrom:(NSString *)peer;
- (void)declineInvitationFrom:(NSString *)peer;
- (void)leavePeer:(NSString *)peer;

- (void)sendBurger:(NSString *)burger;

- (User *)userForPeer:(NSString *)peer;

@end