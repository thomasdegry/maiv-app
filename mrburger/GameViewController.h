//
//  GameViewController.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

#import "User.h"
#import "SessionManager.h"

#import "LoginViewController.h"
#import "GameStep1ViewController.h"
#import "GameStep2ViewController.h"
#import "GameResultViewController.h"
#import "EnjoyViewController.h"
#import "AFHTTPClient.h"
#import "Burger.h"

typedef enum {
    GameScreenLogin = 0,
    GameScreenStep1 = 1,
    GameScreenStep2 = 2,
    GameScreenResult = 3,
    GameScreenEnjoy = 4
} GameScreen;

@interface GameViewController : UINavigationController <CloseButtonDelegate, CBPeripheralDelegate, CBCentralManagerDelegate>

@property (strong, nonatomic) User *user;
@property GameScreen currentScreen;
@property (strong, nonatomic) SessionManager *sessionManager;
@property (strong, nonatomic) NSString *sharedCode;
@property (strong, nonatomic) NSMutableArray *ingredients;
@property (strong, nonatomic) NSMutableArray *users;
@property (strong, nonatomic) CBCentralManager *manager;


- (id)initGame;

- (void)calculateCode;
- (void)postBurgerToServer;

- (void)showNextScreen;
- (void)showResult;

@end
