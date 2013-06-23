//
//  Burger.m
//  mrburger
//
//  Created by Thomas Degry on 17/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "Burger.h"

@implementation Burger

@synthesize id = _id;
@synthesize ingredients = _ingredients;
@synthesize users = _users;

- (id)init
{
    self = [super init];
    if (self) {
        self.ingredients = [NSMutableArray array];
        self.users = [NSMutableArray array];
    }
    return self;
}

- (void)addIngredient:(NSString *)ingredientID
{
    [self.ingredients addObject:ingredientID];
}

- (void)addUser:(NSString *)userID
{
    [self.users addObject:userID];
}

- (NSData *)burgerToNSData
{
    NSMutableDictionary *dictBurger = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.id, @"id", self.ingredients, @"ingredients", self.users, @"users", nil];
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dictBurger forKey:@"burger"];
    [archiver finishEncoding];
        
    return [NSData dataWithData:data];
}

+ (Burger *)burgerFromNSData:(NSData *)data
{
    NSLog(@"burger init");
    Burger *burger = [[Burger alloc] init];
    
    NSLog(@"burger archive");

    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    NSLog(@"burger decode");
    
    NSDictionary *dictBurger = [unarchiver decodeObjectForKey:@"burger"];
    [unarchiver finishDecoding];
    
    NSLog(@"burger set properties");

    burger.id = [dictBurger objectForKey:@"id"];
    
//    NSMutableArray *ingredients = [NSMutableArray array];
    
//    for (NSString *ingredientID in [dictBurger objectForKey:@"ingredients"]) {
//        Ingredient *ingredient = [[Ingredient alloc] init];
//        ingredient.id = ingredientID;
//        [ingredients addObject:ingredient];
//    }
    
    burger.ingredients = [dictBurger objectForKey:@"ingredients"];
    
//    NSMutableArray *users = [NSMutableArray array];
//    
//    for (NSString *userID in [dictBurger objectForKey:@"users"]) {
//        User *user = [[User alloc] init];
//        user.id = userID;
//        [users addObject:userID];
//    }
    
    burger.users = [dictBurger objectForKey:@"users"];
    
    return burger;
}

@end
