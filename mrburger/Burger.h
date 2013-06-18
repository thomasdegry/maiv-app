//
//  Burger.h
//  mrburger
//
//  Created by Thomas Degry on 17/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ingredient.h"
#import "User.h"

@interface Burger : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSMutableArray *ingredients;
@property (strong ,nonatomic) NSMutableArray *users;
- (void)addIngredient:(NSString *)ingredientID;
- (void)addUser:(NSString *)userID;

- (NSData *)burgerToNSData;
+ (Burger *)burgerFromNSData:(NSData *)data;

@end
