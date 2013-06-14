//
//  EnjoyView.h
//  mrburger
//
//  Created by Thomas Degry on 14/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "RoundedView.h"
#import "Ingredient.h"

@interface EnjoyView : RoundedView

@property (strong, nonatomic) NSArray *ingredients;
@property (strong, nonatomic) UIView *burger;
@property (strong, nonatomic) NSMutableArray *burgerIngredients;

- (id)initWithFrame:(CGRect)frame andIngredients:(NSArray *)ingredients;

@end
