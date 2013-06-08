//
//  LoginViewController.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

#import "GameViewController.h"

#import "FacebookButton.h"
#import "KGStatusBar.h"

@interface LoginViewController : UIViewController <CloseButtonDelegate>

@property (strong, nonatomic) CloseButton *btnClose;
@property (strong, nonatomic) FacebookButton *btnLogin;

@property (strong, nonatomic) ACAccountStore *accountStore;
@property (strong, nonatomic) ACAccount *facebookAccount;

@end
