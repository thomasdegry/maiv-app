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
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
//    GameStep1ViewController *loginVC = [[GameStep1ViewController alloc] initWithNibName:nil bundle:nil];
    self = [self initWithRootViewController:loginVC];
    
    if (self) {
        self.currentScreen = GameScreenStep1;
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
            [self.sessionManager setupSession];
            nextScreen = [[GameStep2ViewController alloc] initWithSessionManager:self.sessionManager];
            
            self.currentScreen = GameScreenStep2;
            break;
            
        case GameScreenStep2:
            nextScreen = [[GameStep3ViewController alloc] initWithNibName:nil bundle:nil];
            self.currentScreen = GameScreenStep3;
            break;
            
        default:
            break;
    }
    
    if (nextScreen) {
        [self pushViewController:nextScreen animated:YES];
    }
    
}

@end
