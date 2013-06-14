//
//  GameResultView.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "User.h"

#import "ZXingObjC.h"

@interface GameResultView : RoundedView

@property (strong, nonatomic) UIView *participants;
@property (strong, nonatomic) NSArray *users;
@property (strong, nonatomic) NSString *sharedCode;
@property (strong, nonatomic) NSArray *ingredients;

@property (strong, nonatomic) UIView *burger;
@property (strong, nonatomic) UIImage *qr;
@property (strong, nonatomic) RoundedButton *saveForLater;

- (id)initWithFrame:(CGRect)frame sharedCode:(NSString *)code andUsers:(NSMutableArray *)users;
- (id)initWithFrame:(CGRect)frame sharedCode:(NSString *)code users:(NSMutableArray *)users andIngredients:(NSMutableArray *)ingredients;

@end
