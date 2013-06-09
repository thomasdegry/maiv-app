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

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.id = [dict objectForKey:@"id"];
        self.name = [dict objectForKey:@"name"];
        self.gender = [dict objectForKey:@"gender"];
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
    }
    return self;
}

@end
