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
@synthesize order = _order;

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

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.id forKey:@"id"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.type forKey:@"type"];
    [encoder encodeObject:self.image forKey:@"image"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        self.id = [decoder decodeObjectForKey:@"id"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.type = [decoder decodeObjectForKey:@"type"];
        self.image = [decoder decodeObjectForKey:@"image"];
    }
    return self;
}

@end
