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
    }
    return self;
}

- (id)initWithSessionManager:(SessionManager *)sessionManager andSharedCode:(NSString *)sharedCode
{
    self = [self initWithNibName:nil bundle:nil];
    
    if (self) {
        self.sessionManager = sessionManager;
        self.sharedCode = sharedCode;
        
        self.users = [[NSMutableArray alloc] init];
        for (NSString *peerID in self.sessionManager.connectedPeers) {
            NSLog(@"GameresultVC in for");
            User *user = [self.sessionManager userForPeerID:peerID];
            [self.users addObject:user];
        }
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
    NSLog(@"ViewDidLoad");
    [super viewDidLoad];
    GameResultView *view = (GameResultView *)self.view;
    NSLog(@"Bestaat die knop wel ja - %@", view.saveForLater.label.text);
    [view.saveForLater addTarget:self action:@selector(storeBurger:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)storeBurger:(id)sender
{
    NSLog(@"Store burger");
    
    GameResultView *view = (GameResultView *)self.view;
    
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(view.qr) forKey:@"QRCode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
