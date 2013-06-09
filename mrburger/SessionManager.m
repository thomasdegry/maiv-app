//
//  SessionManager.m
//  ProtoPeers
//
//  Created by Pieter Beulque on 5/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "SessionManager.h"

@implementation SessionManager

@synthesize sessionID = _sessionID;
@synthesize session = _session;
@synthesize currentConfPeerID = _currentConfPeerID;
@synthesize connectedPeers = _connectedPeers;
@synthesize availablePeers = _availablePeers;
@synthesize tableViewControllerDelegate = _tableViewControllerDelegate;
@synthesize sessionState = _sessionState;

- (id)init
{
	if (self = [super init]) {
        // Peers need to have the same sessionID set on their GKSession to see each other.
		self.sessionID = @"TestingPeers";
		self.availablePeers = [[NSMutableArray alloc] init];
        self.connectedPeers = [[NSMutableArray alloc] init];
        
        // Set up starting/stopping session on application hiding/terminating
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willTerminate:) name:UIApplicationWillTerminateNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willTerminate:) name:UIApplicationWillResignActiveNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willResume:) name:UIApplicationDidBecomeActiveNotification object:nil];
	}
	return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.session) {
        [self destroySession];
    }
	self.session = nil;
	self.sessionID = nil;
}

// Creates a GKSession and advertises availability to Peers
- (void) setupSession
{
	// GKSession will default to using the device name as the display name
	self.session = [[GKSession alloc] initWithSessionID:self.sessionID displayName:@"Pieter£Test" sessionMode:GKSessionModePeer];
    self.session.delegate = self;
	[self.session setDataReceiveHandler:self withContext:nil];
    self.session.disconnectTimeout = 3600.0;
	self.session.available = YES;
    self.sessionState = ConnectionStateDisconnected;
    [self.availablePeers setArray:[self.session peersWithConnectionState:GKPeerStateConnected]];
    [self.connectedPeers setArray:[[NSArray alloc] initWithObjects:self.session.peerID, nil]];
    [self.tableViewControllerDelegate peerListDidChange:self];
}

// Initiates a GKSession connection to a selected peer.
-(void) connect:(NSString *) peerID
{
	[self.session connectToPeer:peerID withTimeout:30.0];
    self.currentConfPeerID = peerID;
    self.sessionState = ConnectionStateConnecting;
}

// Called from GameLobbyController if the user accepts the invitation alertView
-(BOOL) didAcceptInvitation
{
    NSError *error = nil;
    if (![self.session acceptConnectionFromPeer:self.currentConfPeerID error:&error]) {
        NSLog(@"%@",[error localizedDescription]);
    }
    
    self.session.available = NO;
    [self.tableViewControllerDelegate peerListDidChange:self];
    
    //    return (gameDelegate == nil);
    return true;
}

// Called from GameLobbyController if the user declines the invitation alertView
-(void) didDeclineInvitation
{
    // Deny the peer.
    if (self.sessionState != ConnectionStateDisconnected) {
        [self.session denyConnectionFromPeer:self.currentConfPeerID];
        self.currentConfPeerID = nil;
        self.sessionState = ConnectionStateDisconnected;
    }
    
    //    // Go back to the lobby if the game screen is open.
    //    [gameDelegate willDisconnect:self];
}

-(BOOL) comparePeerID:(NSString*)peerID
{
    return [peerID compare:self.session.peerID] == NSOrderedAscending;
}

// Called to check if the session is ready to start a voice chat.
-(BOOL) isReadyToStart
{
    return self.sessionState == ConnectionStateConnected;
}

//// When the voice chat starts, tell the game it can begin.
//-(void) voiceChatDidStart
//{
//    [gameDelegate session:self didConnectAsInitiator:![self comparePeerID:currentConfPeerID]];
//}

// Called by RocketController and VoiceManager to send data to the peer
//-(void) sendPacket:(NSData*)data ofType:(PacketType)type
//{
//    NSMutableData * newPacket = [NSMutableData dataWithCapacity:([data length]+sizeof(uint32_t))];
//    // Both game and voice data is prefixed with the PacketType so the peer knows where to send it.
//    uint32_t swappedType = CFSwapInt32HostToBig((uint32_t)type);
//    [newPacket appendBytes:&swappedType length:sizeof(uint32_t)];
//    [newPacket appendData:data];
//    NSError *error;
//    if (currentConfPeerID) {
//        if (![myGKSession sendData:newPacket toPeers:[NSArray arrayWithObject:currentConfPeerID] withDataMode:GKSendDataReliable error:&error]) {
//            NSLog(@"%@",[error localizedDescription]);
//        }
//    }
//}

// Clear the connection states in the event of leaving a call or error.
-(void) disconnectCurrentCall
{
    //    [gameDelegate willDisconnect:self];
    if (self.sessionState != ConnectionStateDisconnected) {
        // Don't leave a peer hangin'
        if (self.sessionState == ConnectionStateConnecting) {
            [self.session cancelConnectToPeer:self.currentConfPeerID];
        }
        [self.session disconnectFromAllPeers];
        self.session.available = YES;
        self.sessionState = ConnectionStateDisconnected;
        self.currentConfPeerID = nil;
    }
}

// Application is exiting or becoming inactive, end the session.
- (void)destroySession
{
	self.session.delegate = nil;
	[self.session setDataReceiveHandler:nil withContext:nil];
    [self.connectedPeers removeAllObjects];
    [self.availablePeers removeAllObjects];
}

// Called when notified the application is exiting or becoming inactive.
- (void)willTerminate:(NSNotification *)notification
{
    [self destroySession];
}

// Called after the app comes back from being hidden by something like a phone call.
- (void)willResume:(NSNotification *)notification
{
    [self setupSession];
}

#pragma mark -
#pragma mark GKSessionDelegate Methods and Helpers

// Received an invitation.  If we aren't already connected to someone, open the invitation dialog.
- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID
{
    if (self.sessionState == ConnectionStateDisconnected) {
        self.currentConfPeerID = peerID;
        self.sessionState = ConnectionStateConnecting;
        [self.tableViewControllerDelegate didReceiveInvitation:self fromPeer:[self.session displayNameForPeer:peerID]];
    } else {
        [self.session denyConnectionFromPeer:peerID];
    }
}

// Unable to connect to a session with the peer, due to rejection or exiting the app
- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
    if (self.sessionState != ConnectionStateDisconnected) {
        [self.tableViewControllerDelegate invitationDidFail:self fromPeer:[self.session displayNameForPeer:peerID]];
        // Make self available for a new connection.
        self.currentConfPeerID = nil;
        self.session.available = YES;
        self.sessionState = ConnectionStateDisconnected;
    }
}

// The running session ended, potentially due to network failure.
- (void)session:(GKSession *)session didFailWithError:(NSError*)error
{
    NSLog(@"%@",[error localizedDescription]);
}

// React to some activity from other peers on the network.
- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state
{
    NSLog(@"SWITCHING TO STATE: %u", state);
    
	switch (state) {
		case GKPeerStateAvailable:
            // A peer became available by starting app, exiting settings, or ending a call.
			if (![self.availablePeers containsObject:peerID]) {
				[self.availablePeers addObject:peerID];
			}
 			[self.tableViewControllerDelegate peerListDidChange:self];
			break;
		case GKPeerStateUnavailable:
            // Peer unavailable due to joining a call, leaving app, or entering settings.
            [self.availablePeers removeObject:peerID];
            [self.tableViewControllerDelegate peerListDidChange:self];
			break;
		case GKPeerStateConnected:
            NSLog(@"SWITCHING TO STATE: connected");
            // Connection was accepted, set up the voice chat.
            self.currentConfPeerID = peerID;
            self.session.available = NO;
            [self.connectedPeers addObject:peerID];
            [self.availablePeers removeObject:peerID];
            self.sessionState = ConnectionStateConnected;
            [self.tableViewControllerDelegate peerListDidChange:self];
			break;
		case GKPeerStateDisconnected:
            // The call ended either manually or due to failure somewhere.
            [self.availablePeers removeObject:peerID];
            [self.tableViewControllerDelegate peerListDidChange:self];
			break;
        case GKPeerStateConnecting:
            // Peer is attempting to connect to the session.
            break;
		default:
			break;
	}
}

//// Called when voice or game data is received over the network from the peer
//- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void *)context
//{
//    PacketType header;
//    uint32_t swappedHeader;
//    if ([data length] >= sizeof(uint32_t)) {
//        [data getBytes:&swappedHeader length:sizeof(uint32_t)];
//        header = (PacketType)CFSwapInt32BigToHost(swappedHeader);
//        NSRange payloadRange = {sizeof(uint32_t), [data length]-sizeof(uint32_t)};
//        NSData* payload = [data subdataWithRange:payloadRange];
//
//        // Check the header to see if this is a voice or a game packet
//        if (header == PacketTypeVoice) {
//            [[GKVoiceChatService defaultVoiceChatService] receivedData:payload fromParticipantID:peer];
//        } else {
//            [gameDelegate session:self didReceivePacket:payload ofType:header];
//        }
//    }
//}

- (NSString *) displayNameForPeer:(NSString *)peerID
{
    NSLog(@"PEER ID -- %@", peerID);
	return [[[self.session displayNameForPeer:peerID] componentsSeparatedByString:@"£"] objectAtIndex:0];
}

@end