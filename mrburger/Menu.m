//
//  Menu.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "Menu.h"

@implementation Menu
@synthesize name = _name;
@synthesize price = _price;
@synthesize image = _image;
@synthesize ingredients = _ingredients;

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.name = [dict objectForKey:@"name"];
        self.image = [dict objectForKey:@"image"];
        self.price = [dict objectForKey:@"price"];
        self.ingredients =  [dict objectForKey:@"ingredients"];
        
    }
    return self;
}


@end
