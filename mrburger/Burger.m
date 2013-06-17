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

- (void)addIngredient:(Ingredient *)ingredient
{
    [self.ingredients addObject:ingredient];
}

- (void)addUser:(NSString *)userID
{
    [self.users addObject:userID];
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.id forKey:@"id"];
    
    NSMutableArray *encodedIngredients = [NSMutableArray array];
    
    for (Ingredient *ingredient in self.ingredients) {
        [encodedIngredients addObject:[NSKeyedArchiver archivedDataWithRootObject:ingredient]];
    }
    
    [encoder encodeObject:encodedIngredients forKey:@"ingredients"];

    NSMutableArray *encodedUsers = [NSMutableArray array];
    
    for (User *user in self.users) {
        [encodedIngredients addObject:[NSKeyedArchiver archivedDataWithRootObject:user]];
    }
    
    [encoder encodeObject:encodedUsers forKey:@"users"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        self.id = [decoder decodeObjectForKey:@"id"];
        NSMutableArray *encodedIngredients = [decoder decodeObjectForKey:@"ingredients"];
        self.ingredients = encodedIngredients;
    }
    return self;
}

- (NSData *)burgerToNSData
{
    NSMutableArray *ingredientsIDs = [[NSMutableArray alloc] init];
    for (Ingredient *ingredient in self.ingredients) {
        [ingredientsIDs addObject:ingredient.id];
    }
    NSMutableDictionary *dictBurger = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.id, @"id", ingredientsIDs, @"ingredients", self.users, @"users", nil];
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:dictBurger forKey:@"burger"];
    [archiver finishEncoding];
    
    return [NSData dataWithData:data];
}

+ (Burger *)burgerFromNSData:(NSData *)data
{
    Burger *burger = [[Burger alloc] init];
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSDictionary *dictBurger = [unarchiver decodeObjectForKey:@"burger"];
    [unarchiver finishDecoding];
    
    burger.id = [dictBurger objectForKey:@"id"];
    
    NSMutableArray *ingredients = [NSMutableArray array];
    
    for (NSString *ingredientID in [dictBurger objectForKey:@"ingredients"]) {
        Ingredient *ingredient = [[Ingredient alloc] init];
        ingredient.id = ingredientID;
        [ingredients addObject:ingredient];
    }
    
    burger.ingredients = ingredients;
    
    NSMutableArray *users = [NSMutableArray array];
    
    for (NSString *userID in [dictBurger objectForKey:@"users"]) {
        User *user = [[User alloc] init];
        user.id = userID;
        [users addObject:userID];
    }
    
    burger.users = users;
    
    return burger;
}

@end
