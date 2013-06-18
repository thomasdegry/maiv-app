//
//  EnjoyViewController.h
//  mrburger
//
//  Created by Thomas Degry on 14/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "EnjoyView.h"
#import "User.h"
#import "KGStatusBar.h"
#import "AFNetworking.h"
#import "Burger.h"

@interface EnjoyViewController : UIViewController

@property (strong, nonatomic) Burger *burger;
@property (strong, nonatomic) NSArray *ingredients;
@property (strong, nonatomic) NSString *burgerID;
@property (strong, nonatomic) NSString *userID;

- (id)initWithBurger:(Burger *)burger;

@end
