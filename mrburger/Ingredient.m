//
//  Ingredient.m
//  mrburger
//
//  Created by Thomas Degry on 09/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "Ingredient.h"

@implementation Ingredient

@synthesize id = _id;
@synthesize name = _name;
@synthesize type = _type;
@synthesize image = _image;

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.id = [dict objectForKey:@"id"];
        self.name = [dict objectForKey:@"name"];
        self.type = [dict objectForKey:@"type"];
        self.image = [dict objectForKey:@"image"];
    }
    return self;
}

@end
