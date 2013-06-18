//
//  GameResultViewController.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GameResultView.h"
#import "Burger.h"
#import "SessionManager.h"

@interface GameResultViewController : UIViewController

@property (strong, nonatomic) SessionManager *sessionManager;
@property (strong, nonatomic) NSString *sharedCode;

@property (strong, nonatomic) Burger *burger;

@property (strong, nonatomic) NSMutableArray *users;
@property (strong, nonatomic) NSMutableArray *ingredients;
@property (strong, nonatomic) NSData *burgerData;

- (id)initWithBurger:(Burger * )burger andSharedCode:(NSString *)sharedCode;

- (id)initWithIngredients:(NSMutableArray *)ingredients users:(NSMutableArray *)users andSharedCode:(NSString *)sharedCode;

@end
