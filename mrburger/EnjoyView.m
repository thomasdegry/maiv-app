//
//  EnjoyView.m
//  mrburger
//
//  Created by Thomas Degry on 14/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "EnjoyView.h"

@implementation EnjoyView

@synthesize ingredients = _ingredients;
@synthesize burger = _burger;
@synthesize burgerIngredients = _burgerIngredients;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andIngredients:(NSArray *)ingredients
{
    self = [self initWithFrame:frame];
    if (self) {
        self.ingredients = ingredients;
        [self buildBurger];
    }
    
    return self;
}

- (void)buildBurger
{
    NSLog(@"build burger");
    self.burger = [[UIView alloc] initWithFrame:CGRectMake(0, 160, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 160)];
    [self addSubview:self.burger];
        
    self.burgerIngredients = [[NSMutableArray alloc] initWithCapacity:[self.ingredients count]];
    
    int yPos = 0;
    
    UIImage *top = [UIImage imageNamed:@"bread_top.png"];
    UIImageView *topIV = [[UIImageView alloc] initWithImage:top];
    float xPos = (([[UIScreen mainScreen] bounds].size.width - top.size.width) / 2);
    topIV.frame = CGRectMake(xPos, yPos, top.size.width, top.size.height);
    [self.burger addSubview:topIV];
    
    yPos += top.size.height + 10;
    
    for (Ingredient *ingredient in self.ingredients) {        
        if([ingredient.type isEqualToString:@"sauce"]) {
            [self.burgerIngredients insertObject:ingredient atIndex:0];
        } else {
            [self.burgerIngredients addObject:ingredient];
        }
    }
    
    for(Ingredient *ingredient in self.burgerIngredients) {
        NSLog(@"In for");
        UIImage *burgerObject = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%@", ingredient.image, @"cropped"]];
        UIImageView *burgerObjectIV = [[UIImageView alloc] initWithImage:burgerObject];
        float xPos = (([[UIScreen mainScreen] bounds].size.width - burgerObject.size.width) / 2);
        burgerObjectIV.frame = CGRectMake(xPos, yPos, burgerObject.size.width, burgerObject.size.height);
        [self.burger addSubview:burgerObjectIV];
        
        yPos += burgerObject.size.height + 10;
    }
    
    [topIV bringSubviewToFront:topIV];
    
    UIImage *bottom = [UIImage imageNamed:@"bread_bottom.png"];
    UIImageView *bottomIV = [[UIImageView alloc] initWithImage:bottom];
    xPos = (([[UIScreen mainScreen] bounds].size.width - bottom.size.width) / 2);
    bottomIV.frame = CGRectMake(xPos, yPos, bottom.size.width, bottom.size.height);
    [self.burger addSubview:bottomIV];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
