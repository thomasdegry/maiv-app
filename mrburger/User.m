//
//  User.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize id = _id;
@synthesize name = _name;
@synthesize gender = _gender;
@synthesize profilePicture = _profilePicture;
@synthesize deviceToken = _deviceToken;
@synthesize ingredient = _ingredient;

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.id = [dict objectForKey:@"id"];
        self.name = [dict objectForKey:@"name"];
        self.gender = [dict objectForKey:@"gender"];
        self.ingredient = [[Ingredient alloc] init];
    }
    return self;
}

- (id)initWithDisplayNameString:(NSString *)displayName
{
    self = [super init];
    if (self) {
        NSArray *userInfo = [displayName componentsSeparatedByString:@"£"];
        self.id = [userInfo objectAtIndex:0];
        self.name = [userInfo objectAtIndex:1];
        self.gender = [userInfo objectAtIndex:2];
        
        NSDictionary *ingredientDict = [[NSDictionary alloc] initWithObjectsAndKeys:[userInfo objectAtIndex:3], @"id", [userInfo objectAtIndex:4], @"name", nil];
                
        self.ingredient = [[Ingredient alloc] initWithDict:ingredientDict];
        
    }
    return self;
}

@end
