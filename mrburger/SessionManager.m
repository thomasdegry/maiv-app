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
static NSTimeInterval const kSleepTimeout = 5.0;

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
    self.connectingPeers = [NSMutableArray array];
    
    // Set the timer on a random interval between 2 and 6
    // to decrease the chance of clashing connections
    self.timer = [NSTimer scheduledTimerWithTimeInterval:((arc4random() % 4) + 2) target:self selector:@selector(keepAlive) userInfo:nil repeats:YES];
    [self.timer fire];
    
}

- (void)teardownSession
{
    NSLog(@"Tear down session");
    [self.session disconnectFromAllPeers];
    self.session.available = NO;
    self.session.delegate = nil;
    [self stopSearching];
    [self.availablePeers removeAllObjects];
    [self.connectedPeers removeAllObjects];
}

- (void) keepAlive
{
    NSLog(@"sending keep alive");
    [self.session sendDataToAllPeers:nil withDataMode:GKSendDataUnreliable error:nil];
//    [self listAllPeers];
}

- (void)stopSearching
{
    [self.timer invalidate];
    self.timer = nil;
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
    // self.connectPeers !== connected devices!
    // It's a fake array with those that accepted 
    NSLog(@"Connected peers count: %i", [self.connectedPeers count]);
    
    // self.availablePeers == connected devices!
    NSLog(@"Available peers count: %i", [self.availablePeers count]);
//
//    NSLog(@">>> GKPeerStateAvailable count: %i", [[self.session peersWithConnectionState:GKPeerStateAvailable] count]);
//    NSLog(@">>> GKPeerStateUnavailable count: %i", [[self.session peersWithConnectionState:GKPeerStateUnavailable] count]);
//    NSLog(@">>> GKPeerStateConnected count: %i", [[self.session peersWithConnectionState:GKPeerStateConnected] count]);
//    NSLog(@">>> GKPeerStateConnecting count: %i", [[self.session peersWithConnectionState:GKPeerStateConnecting] count]);
//    NSLog(@">>> GKPeerStateDisconnected count: %i", [[self.session peersWithConnectionState:GKPeerStateDisconnected] count]);
    
    [self.delegate peerListDidChange:self];
}

- (void)session:(GKSession *)session peer:(NSString *)peer didChangeState:(GKPeerConnectionState)state
{
	switch (state)
	{
		case GKPeerStateAvailable:
        {
			NSLog(@"didChangeState: peer %@ available", [session displayNameForPeer:peer]);
            
            [NSThread sleepForTimeInterval:kSleepTimeout];
            [session connectToPeer:peer withTimeout:kConnectionTimeout];
			break;
        }
			
		case GKPeerStateUnavailable:
        {
			NSLog(@"didChangeState: peer %@ unavailable", [session displayNameForPeer:peer]);
			break;
        }
			
		case GKPeerStateConnected:
        {
			NSLog(@"didChangeState: peer %@ connected", [session displayNameForPeer:peer]);
            if ([self.session acceptConnectionFromPeer:peer error:nil]) {
                if (![self.availablePeers containsObject:peer]) {
                    [self.availablePeers addObject:peer];
                }
            }
			break;
        }
			
		case GKPeerStateDisconnected:
        {
			NSLog(@"didChangeState: peer %@ disconnected", [session displayNameForPeer:peer]);
			break;
        }
			
		case GKPeerStateConnecting:
        {
			NSLog(@"didChangeState: peer %@ connecting", [session displayNameForPeer:peer]);
			break;
        }
	}
    
    [self listAllPeers];
}

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peer
{
	NSLog(@"didReceiveConnectionRequestFromPeer: %@", [session displayNameForPeer:peer]);
    NSLog(@"Accepting connection request");
    
    if ([self.session acceptConnectionFromPeer:peer error:nil]) {
        if (![self.availablePeers containsObject:peer]) {
            [self.availablePeers addObject:peer];
        }
    }
    
    [self listAllPeers];
}

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peer withError:(NSError *)error
{
//	NSLog(@"connectionWithPeerFailed: peer: %@, error: %@", [session displayNameForPeer:peer], error co);
    
    if ([error code] != 30501 && ![self.connectedPeers containsObject:peer]) {
        [session connectToPeer:peer withTimeout:kConnectionTimeout];
    }

//    [self.delegate invitationDidFail:self fromPeer:peerID];
//    self.session.available = YES;
//    [self listAllPeers];
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
    PacketType header;
    uint32_t swappedHeader;
    if ([data length] >= sizeof(uint32_t)) {
        [data getBytes:&swappedHeader length:sizeof(uint32_t)];
        header = (PacketType)CFSwapInt32BigToHost(swappedHeader);
        NSRange payloadRange = {sizeof(uint32_t), [data length]-sizeof(uint32_t)};
        NSData* payload = [data subdataWithRange:payloadRange];
        
        // Check the header to see if this is a voice or a game packet
        switch (header) {
            case PacketTypeInvite:
            {
                NSLog(@"received invite");
                [self.connectingPeers addObject:peer];
                [self.delegate didReceiveInvitation:self fromPeer:peer];
            }
            break;
                
            case PacketTypeAccept:
            {
                NSLog(@"accept invite");
                [self.availablePeers removeObject:peer];
                [self.connectingPeers removeObject:peer];
                [self.connectedPeers addObject:peer];
                [self.delegate peer:peer didAcceptInvitation:self];
                [self listAllPeers];
            }
            break;
            
            case PacketTypeDecline:
                NSLog(@"decline invite");
            break;
            
            case PacketTypeJoining:
            {
                NSLog(@"joining other");
//                if (![self.connectingPeers containsObject:peer]) {
//                    NSLog(@"joining & not in connecting - removing from available!!!");
//                    [self.availablePeers removeObject:peer];
//                    [self listAllPeers];
//                }
                
                NSLog(@"Available");
                
                [self.availablePeers removeObject:peer];
                
                NSString *server = [[NSString alloc] initWithData:payload encoding:NSUTF8StringEncoding];
                
                NSLog(@"Server peer id: %@", server);
                if ([self.connectedPeers containsObject:server] && ![self.connectedPeers containsObject:peer]) {
                    [self.connectedPeers addObject:peer];
                }
                
            }
            break;
            
            case PacketTypeDisconnect:
            {
                NSLog(@"disconnect");
                break;
            }
            
            case PacketTypeBurger:
            {
                NSLog(@"burger! %@", [[NSString alloc] initWithData:payload encoding:NSUTF8StringEncoding]);
                NSString *code = [[NSString alloc] initWithData:payload encoding:NSUTF8StringEncoding];
                NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:code, @"code", nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RECEIVED_CODE" object:self userInfo:dict];
                break;
            }
                
            default:
                NSLog(@"Received keep-alive packet");
                break;
        }
    }
}


- (void)sendPacket:(NSData *)data ofType:(PacketType)type toPeers:(NSArray *)peers
{
    NSMutableData *newPacket = [NSMutableData dataWithCapacity:([data length]+sizeof(uint32_t))];
    // Both game and voice data is prefixed with the PacketType so the peer knows where to send it.
    uint32_t swappedType = CFSwapInt32HostToBig((uint32_t)type);
    [newPacket appendBytes:&swappedType length:sizeof(uint32_t)];
    [newPacket appendData:data];
    
    NSError *error;
    if (![self.session sendData:newPacket toPeers:peers withDataMode:GKSendDataReliable error:&error]) {
        NSLog(@"%@",[error localizedDescription]);
    }
}

- (void)invitePeer:(NSString *)peer
{
    NSLog(@"sending fake invite to peer %@", peer);
    [KGStatusBar showWithStatus:@"Sending an invitation"];

    [self.connectingPeers addObject:peer];
    
    [self sendPacket:[self.session.peerID dataUsingEncoding:NSUTF8StringEncoding] ofType:PacketTypeInvite toPeers:[NSArray arrayWithObject:peer]];
}

#pragma mark - Working with users

- (User *)userForPeer:(NSString *)peer
{
    return [[User alloc] initWithDisplayNameString:[self.session displayNameForPeer:peer]];
}

- (void)acceptInvitationFrom:(NSString *)peer
{
    NSLog(@"!!! - Accepting connection from peer");
    self.session.available = NO;
    
    [self.connectedPeers addObject:peer];
    [self.connectingPeers removeObject:peer];
    
    // Send accept to the parrent ID
    [self sendPacket:[self.session.peerID dataUsingEncoding:NSUTF8StringEncoding] ofType:PacketTypeAccept toPeers:[NSArray arrayWithObject:peer]];
    
    // Send JOINING to all other peers
    // This way we can add them to CONNECTED if the inviting peer ID is in their connected
    // and remove them from the AVAILABLE
    [self sendPacket:[peer dataUsingEncoding:NSUTF8StringEncoding] ofType:PacketTypeJoining toPeers:self.availablePeers];
        
//    NSError *error = nil;
//    if (![self.session acceptConnectionFromPeer:peer error:&error]) {
//        NSLog(@"Error while accepting invitation: %@", [error localizedDescription]);
//    }
}

- (void)declineInvitationFrom:(NSString *)peer
{
    NSLog(@"!!! - Declining invitation from %@", peer);
    
    // @todo Send a packet with a decline-message
}

- (void)sendBurger:(NSString *)burger
{
    NSLog(@"Sending burger");
    [self sendPacket:[burger dataUsingEncoding:NSUTF8StringEncoding] ofType:PacketTypeBurger toPeers:self.connectedPeers];
}

@end
