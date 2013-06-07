//
//  InfoViewController.h
//  mrburger
//
//  Created by Thomas Degry on 07/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RoundedButton.h"
#import "RoundedButtonAlternate.h"
#import "CircularButton.h"
#import "CloseButton.h"
#import "InfoButton.h"
#import "FacebookButton.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface InfoViewController : UIViewController

@property (strong, nonatomic) ACAccountStore *accountStore;
@property (strong, nonatomic) ACAccount *facebookAccount;

@end
