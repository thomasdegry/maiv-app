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

- (id)init
{
    self = [super init];
    if (self) {
        self.ingredients = [NSMutableArray array];
    }
    return self;
}

- (void)addIngredient:(Ingredient *)ingredient
{
    [self.ingredients addObject:ingredient];
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.id forKey:@"id"];
    
    NSMutableArray *encodedIngredients = [NSMutableArray array];
    
    for (Ingredient *ingredient in self.ingredients) {
        [encodedIngredients addObject:[NSKeyedArchiver archivedDataWithRootObject:ingredient]];
    }
    
    [encoder encodeObject:encodedIngredients forKey:@"ingredients"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        self.id = [decoder decodeObjectForKey:@"id"];
        NSMutableArray *encodedIngredients = [decoder decodeObjectForKey:@"ingredients"];
        self.ingredients = encodedIngredients;
    }
    return self;
}

@end
