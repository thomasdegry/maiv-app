//
//  SessionManager.m
//  GKSessionP2P
//
//  Created by Pieter Beulque on 16/06/13.
//
//

#import "SessionManager.h"

@implementation SessionManager

@synthesize session = _session;
@synthesize delegate = _delegate;
@synthesize availablePeers = _availablePeers;
@synthesize connectedPeers = _connectedPeers;

// Non-global constants
static NSTimeInterval const kConnectionTimeout = 3600.0;
static NSTimeInterval const kDisconnectTimeout = 3600.0;

#pragma mark - GKSession setup and teardown

- (id)init
{
    self = [super init];
    
    if (self) {        
        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
        
        // Register for notifications when the application leaves the background state
        // on its way to becoming the active application.
        [defaultCenter addObserver:self
                          selector:@selector(setupSession)
                              name:UIApplicationWillEnterForegroundNotification
                            object:nil];
        
        // Register for notifications when when the application enters the background.
        [defaultCenter addObserver:self
                          selector:@selector(teardownSession)
                              name:UIApplicationDidEnterBackgroundNotification
                            object:nil];
    }
    
    return self;
}

- (id)initWithUser:(User *)user
{
    self = [self init];
    if (self) {
        self.user = user;
        [self setupSession];
    }
    return self;
}

- (void)setupSession
{
    NSLog(@"Set up session");
    NSString *displayName = [NSString stringWithFormat:@"%@£%@£%@£%@£%@", self.user.id, self.user.name, self.user.gender, self.user.ingredient.id, self.user.ingredient.name];
        
    self.session = [[GKSession alloc] initWithSessionID:nil displayName:displayName sessionMode:GKSessionModePeer];
    self.session.delegate = self;
    self.session.disconnectTimeout = kDisconnectTimeout;
    self.session.available = YES;
    [self.session setDataReceiveHandler:self withContext:nil];
    
    self.availablePeers = [NSMutableArray array];
    self.connectedPeers = [NSMutableArray arrayWithObject:self.session.peerID];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(refreshConnection) userInfo:nil repeats:YES];
    [self.timer fire];
    
}

- (void)refreshConnection
{
    NSLog(@"refreshing connection");
    (void)[self listAllPeers];
}

- (void)teardownSession
{
    NSLog(@"Tear down session");
    [self.session disconnectFromAllPeers];
    self.session.available = NO;
    self.session.delegate = nil;
    [self.timer invalidate];
    self.timer = nil;
    [self.availablePeers removeAllObjects];
    [self.connectedPeers removeAllObjects];
}

#pragma mark - Memory management

- (void)dealloc
{
    // Unregister for notifications on deallocation.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - GKSessionDelegate protocol conformance

- (void)listAllPeers
{
    for (NSString *peer in [self.session peersWithConnectionState:GKPeerStateAvailable]) {
        if (![self.availablePeers containsObject:peer]) {
            [self.availablePeers addObject:peer];
        }
    }
    
//    self.availablePeers = [NSMutableArray arrayWithArray:[self.session peersWithConnectionState:GKPeerStateAvailable]];
    
    NSMutableArray *tempConnected = [NSMutableArray arrayWithArray:[self.session peersWithConnectionState:GKPeerStateConnected]];
    [tempConnected addObject:self.session.peerID];
    self.connectedPeers = [NSMutableArray arrayWithArray:tempConnected];
    
    NSLog(@"Available peers count: %i", [self.availablePeers count]);
    
    NSLog(@">>> GKPeerStateAvailable count: %i", [[self.session peersWithConnectionState:GKPeerStateAvailable] count]);
    NSLog(@">>> GKPeerStateUnavailable count: %i", [[self.session peersWithConnectionState:GKPeerStateUnavailable] count]);
    NSLog(@">>> GKPeerStateConnected count: %i", [[self.session peersWithConnectionState:GKPeerStateConnected] count]);
    NSLog(@">>> GKPeerStateConnecting count: %i", [[self.session peersWithConnectionState:GKPeerStateConnecting] count]);
    NSLog(@">>> GKPeerStateDisconnected count: %i", [[self.session peersWithConnectionState:GKPeerStateDisconnected] count]);
    
    [self.delegate peerListDidChange:self];
}

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state
{
    switch (state) {
		case GKPeerStateAvailable:
            // A peer became available by starting app, exiting settings, or ending a call.
            NSLog(@"Available");
			if (![self.availablePeers containsObject:peerID]) {
				[self.availablePeers addObject:peerID];
			}
// 			[self.delegate peerListDidChange:self];
			break;
		case GKPeerStateUnavailable:
            NSLog(@"Unavailable");

            // Peer unavailable due to joining a call, leaving app, or entering settings.
            [self.availablePeers removeObject:peerID];
//            [self.delegate peerListDidChange:self];
			break;
		case GKPeerStateConnected:
            NSLog(@"Connected");
            // Connection was accepted, set up the voice chat.
//            self.session.available = NO;
            if (self.connectedPeers) {
                [self.connectedPeers addObject:peerID];
            }
            
            if (self.availablePeers) {
                [self.availablePeers removeObject:peerID];
            }

//            [self.delegate peerListDidChange:self];
			break;
		case GKPeerStateDisconnected:
            NSLog(@"Disconnected");

            // The call ended either manually or due to failure somewhere.
            [self.availablePeers removeObject:peerID];
//            [self.delegate peerListDidChange:self];
			break;
        case GKPeerStateConnecting:
            NSLog(@"Connecting");

            // Peer is attempting to connect to the session.
            break;
		default:
			break;
	}
    
    [self listAllPeers];
}

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID
{
	NSLog(@"didReceiveConnectionRequestFromPeer: %@", [session displayNameForPeer:peerID]);
            	
    [self.delegate didReceiveInvitation:self fromPeer:peerID];
    [self listAllPeers];
}

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error
{
	NSLog(@"connectionWithPeerFailed: peer: %@, error: %@", [session displayNameForPeer:peerID], error);
	    
    [self.delegate invitationDidFail:self fromPeer:peerID];
    self.session.available = YES;
    [self listAllPeers];
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error
{
	NSLog(@"didFailWithError: error: %@", error);
	
//	[session disconnectFromAllPeers];
//	
//    [self.delegate invitationDidFail:self fromPeer:nil];
//    [self.delegate peerListDidChange:self];
}

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void *)context
{
    NSString *code = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"received - %@", code);
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:code, @"code", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RECEIVED_CODE" object:self userInfo:dict];
}


#pragma mark - Working with users

- (User *)userForPeer:(NSString *)peer
{
    return [[User alloc] initWithDisplayNameString:[self.session displayNameForPeer:peer]];
}

- (void)connect:(NSString *)peer
{
    [KGStatusBar showWithStatus:@"Sending an invitation"];
    [self.session connectToPeer:peer withTimeout:kConnectionTimeout];
}

- (void)acceptInvitationFrom:(NSString *)peer
{
    NSLog(@"!!! - Accepting connection from peer");
    self.session.available = NO;
    
    NSError *error = nil;
    if (![self.session acceptConnectionFromPeer:peer error:&error]) {
        NSLog(@"Error while accepting invitation: %@", [error localizedDescription]);
    }
}

- (void)declineInvitationFrom:(NSString *)peer
{
    NSLog(@"!!! - Declining invitation from %@", peer);
    [self.session denyConnectionFromPeer:peer];
}

@end
