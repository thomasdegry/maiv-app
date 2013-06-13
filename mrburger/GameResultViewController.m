//
//  GameResultViewController.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameResultViewController.h"

@interface GameResultViewController ()

@end

@implementation GameResultViewController

@synthesize users = _users;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"GameresultVC init");
        self.users = [[NSMutableArray alloc] init];
        for (NSString *peerID in self.sessionManager.connectedPeers) {
            NSLog(@"GameresultVC in for");
            User *user = [self.sessionManager userForPeerID:peerID];
            [self.users addObject:user];
        }
    }
    return self;
}

- (id)initWithSessionManager:(SessionManager *)sessionManager andSharedCode:(NSString *)sharedCode
{
    self = [self initWithNibName:nil bundle:nil];
    
    if (self) {
        self.sessionManager = sessionManager;
        self.sharedCode = sharedCode;
    }
    
    return self;
}

- (void)loadView
{
    NSLog(@"GameresultVC loadView");
    CGRect frame = [[UIScreen mainScreen] bounds];
    GameResultView *view = [[GameResultView alloc] initWithFrame:frame sharedCode:self.sharedCode andUsers:self.users];
    [self setView:view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)createQRCodeFromID:(NSString *)identifier
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
