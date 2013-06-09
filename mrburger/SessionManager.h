//
//  SessionManager.h
//  ProtoPeers
//
//  Created by Pieter Beulque on 5/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

typedef enum {
    ConnectionStateDisconnected,
    ConnectionStateConnecting,
    ConnectionStateConnected
} ConnectionState;

@interface SessionManager : NSObject <GKSessionDelegate>

@property (strong, nonatomic) NSString *sessionID;
@property (strong, nonatomic) GKSession *session;

@property (strong, nonatomic) NSString *currentConfPeerID;
@property (strong, nonatomic) NSMutableArray *connectedPeers;
@property (strong, nonatomic) NSMutableArray *availablePeers;
@property (assign, nonatomic) id tableViewControllerDelegate;

@property (assign, nonatomic) ConnectionState sessionState;

- (void) setupSession;
- (void) connect:(NSString *)peerID;
- (BOOL) didAcceptInvitation;
- (void) didDeclineInvitation;
//- (void) sendPacket:(NSData*)data ofType:(PacketType)type;
//- (void) disconnectCurrentCall;
- (NSString *) displayNameForPeer:(NSString *)peerID;

@end

// Class extension for private methods.
@interface SessionManager ()

- (BOOL) comparePeerID:(NSString*)peerID;
- (BOOL) isReadyToStart;
//- (void) voiceChatDidStart;
- (void) destroySession;
- (void) willTerminate:(NSNotification *)notification;
- (void) willResume:(NSNotification *)notification;

@end

@protocol SessionManagerLobbyDelegate

- (void) peerListDidChange:(SessionManager *)session;
- (void) didReceiveInvitation:(SessionManager *)session fromPeer:(NSString *)participantID;
- (void) invitationDidFail:(SessionManager *)session fromPeer:(NSString *)participantID;

@end

//@protocol SessionManagerGameDelegate
//
//- (void) voiceChatWillStart:(SessionManager *)session;
//- (void) session:(SessionManager *)session didConnectAsInitiator:(BOOL)shouldStart;
//- (void) willDisconnect:(SessionManager *)session;
//- (void) session:(SessionManager *)session didReceivePacket:(NSData*)data ofType:(PacketType)packetType;
//
//@end