//
//  GameViewController.m
//
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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissScreen:) name:@"DISMISS_ME" object:nil];
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

- (void)dismissScreen:(NSNotification *)sender
{
    NSLog(@"dismiss screen");
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
        self.sharedCode = [NSString stringWithFormat:@"%@-%@", [notification.userInfo objectForKey:@"code"], self.user.id];
        [self showResult];
    }
}

- (void)postBurgerToServer
{
    [KGStatusBar showWithStatus: @"Saving your burger"];
    NSMutableString *JSONObject = [[NSMutableString alloc] initWithString:@"{\"ingredients\":["];
    for (NSString *peerID in self.sessionManager.connectedPeers) {
        User *user = [self.sessionManager userForPeerID:peerID];
        NSString *object = [NSString stringWithFormat:@"{\"user_id\": \"%@\", \"ingredient_id\": \"%@\"}, ", user.id, user.ingredient.id];
        [JSONObject appendString:object];
    }
    [JSONObject deleteCharactersInRange:NSMakeRange([JSONObject length]-2, 2)];
    [JSONObject appendString:@"]}"];        
        
    NSURL *url = [NSURL URLWithString:@"http://student.howest.be/thomas.degry/20122013/MAIV/FOOD/api"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            JSONObject, @"ingredients",
                            nil];
    
    [httpClient postPath:@"burgers" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"Request Successful, response '%@'", responseStr);
        self.sharedCode = [NSString stringWithFormat:@"%@-%@", responseStr, self.user.id];
        
        NSData *packet = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        
        [self.sessionManager.session sendData:packet toPeers:self.sessionManager.connectedPeers withDataMode:GKSendDataReliable error:&error];
        
        [KGStatusBar dismiss];
        [self showResult];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
    }];
    
}

- (void)showResult
{
    self.currentScreen = GameScreenResult;
    [self pushViewController:[[GameResultViewController alloc] initWithSessionManager:self.sessionManager andSharedCode:self.sharedCode] animated:YES];
}

@end
