//
//  MenuView.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Menu.h"

@interface MenuView : UIView

@property (strong, nonatomic) Menu *burger;
@property (strong, nonatomic) NSMutableArray *labels;
@property (strong, nonatomic) UILabel *price;

- (id)initWithFrame:(CGRect)frame andBurger:(Menu*)burger;
- (void)animate;

@end
