//
//  GameViewController.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "User.h"
#import "LoginViewController.h"

@interface GameViewController : UINavigationController

@property (strong, nonatomic) User *user;

- (id)initGame;

@end
