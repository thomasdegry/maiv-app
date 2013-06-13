//
//  GameViewController.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "User.h"
#import "SessionManager.h"

#import "LoginViewController.h"
#import "GameStep1ViewController.h"
#import "GameStep2ViewController.h"
#import "GameStep3ViewController.h"
#import "GameResultViewController.h"
#import "AFHTTPClient.h"

typedef enum {
    GameScreenLogin = 0,
    GameScreenStep1 = 1,
    GameScreenStep2 = 2,
    GameScreenStep3 = 3,
    GameScreenResult = 4
} GameScreen;

@interface GameViewController : UINavigationController <CloseButtonDelegate>

@property (strong, nonatomic) User *user;
@property GameScreen currentScreen;
@property (strong, nonatomic) SessionManager *sessionManager;
@property (strong, nonatomic) NSString *sharedCode;

- (id)initGame;

- (void)calculateCode;
- (void)postBurgerToServer;

- (void)showNextScreen;
- (void)showResult;

@end
