//
//  GameViewController.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

@synthesize user = _user;
@synthesize currentScreen = _currentScreen;
@synthesize sharedCode = _sharedCode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationBarHidden = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initGame
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"facebook_id"] == nil) {
        //User is not logged in with facebook yet
        LoginViewController *startVC = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
        self = [self initWithRootViewController:startVC];
        if (self) {
            self.currentScreen = GameScreenLogin;
        }
    } else {
        //User is logged in with facebook
        self.user = [[User alloc] init];
        self.user.id = [[NSUserDefaults standardUserDefaults] objectForKey:@"facebook_id"];
        self.user.name = [[NSUserDefaults standardUserDefaults] objectForKey:@"facebook_name"];
        self.user.gender = [[NSUserDefaults standardUserDefaults] objectForKey:@"facebook_gender"];
        self.user.deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
        self.user.ingredient = [[Ingredient alloc] init];
        
        GameStep1ViewController *startVC = [[GameStep1ViewController alloc] initWithNibName:nil bundle:nil];
        self = [self initWithRootViewController:startVC];
        if (self) {
            self.currentScreen = GameScreenStep1;
        }
    }
    
    return self;
}

- (void)closeButtonClicked:(CloseButton *)closeButton
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
}

- (void)showNextScreen
{    
    GameStepViewController *nextScreen = nil;
    
    switch (self.currentScreen) {
        case GameScreenLogin:
            nextScreen = [[GameStep1ViewController alloc] initWithNibName:nil bundle:nil];
            self.currentScreen = GameScreenStep1;
            break;
        
        case GameScreenStep1:
            self.sessionManager = [[SessionManager alloc] initWithUser:self.user];
            nextScreen = [[GameStep2ViewController alloc] initWithSessionManager:self.sessionManager];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedCode:) name:@"RECEIVED_CODE" object:nil];

            self.currentScreen = GameScreenStep2;
            break;
            
        case GameScreenStep2:
            nextScreen = [[GameStep3ViewController alloc] initWithSessionManager:self.sessionManager];
            self.currentScreen = GameScreenStep3;
            break;
            
        default:
            break;
    }
    
    if (nextScreen) {
        [KGStatusBar dismiss];
        [self pushViewController:nextScreen animated:YES];
    }
    
}

- (void)receivedCode:(NSNotification *)notification
{
    NSLog(@"received");
    if (!self.sharedCode) {
        NSLog(@"received in if");
        self.sharedCode = [notification.userInfo objectForKey:@"code"];
        [self showResult];
    }
}

- (void)calculateCode
{
    self.sharedCode = @"9d41f1xye";
}

- (void)postBurgerToServer
{
    for (NSString *peerID in self.sessionManager.connectedPeers) {
        User *user = [self.sessionManager userForPeerID:peerID];
    }
}

- (void)showResult
{
    self.currentScreen = GameScreenResult;
    [self pushViewController:[[GameResultViewController alloc] initWithSessionManager:self.sessionManager andSharedCode:self.sharedCode] animated:YES];
}

@end
