//
//  LoginViewController.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <CloseButtonDelegate>

@property (strong, nonatomic) CloseButton *btnClose;
@property (strong, nonatomic) RoundedButtonAlternate *btnLogin;

@end
