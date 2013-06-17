//
//  Burger.h
//  mrburger
//
//  Created by Thomas Degry on 17/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ingredient.h"

@interface Burger : NSObject <NSCoding>

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSMutableArray *ingredients;
- (void)addIngredient:(Ingredient *)ingredient;

@end
