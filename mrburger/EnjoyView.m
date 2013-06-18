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
@synthesize burgerView = _burgerView;
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
        
        self.closeButton = [[CloseButton alloc] initWithX:280 andY:10];
        [self addSubview:self.closeButton];
        
        UILabel *lblEnjoy = [[UILabel alloc] initWithFontMissionAndFrame:CGRectMake(35, 45, 80, 40) andSize:FontMissionSizeMedium andColor:[UIColor orange]];
        lblEnjoy.text = @"Enjoy";
        [self addSubview:lblEnjoy];
        
        UILabel *lblRest = [[UILabel alloc] initWithFontAlternateAndFrame:CGRectMake(90, 45, 220, 40) andSize:FontAlternateSizeBig andColor:[UIColor blue]];
        lblRest.text = [@"your free burger" uppercaseString];
        [self addSubview:lblRest];
        
        [self buildBurger];
        
        self.shareButton = [[FacebookButton alloc] initWithText:@"Share this experience" andX:((frame.size.width - 274) / 2) andY:(frame.size.height - 100)];
        [self addSubview:self.shareButton];
    }
    
    return self;
}

- (void)buildBurger
{
    NSLog(@"build burger");
    self.burgerView = [[UIView alloc] initWithFrame:CGRectMake(0, 140, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 160)];
    [self addSubview:self.burgerView];

    NSMutableArray *ingredients = [[NSMutableArray alloc] initWithCapacity:[self.ingredients count]];
    
    for (NSString *ingredientID in self.ingredients) {
        Ingredient *ingredient = [Ingredient ingredientWithID:ingredientID];
        [ingredients addObject:ingredient];
    }
    
    int yPos = 0;
    
    UIImage *top = [UIImage imageNamed:@"bread_top.png"];
    UIImageView *topIV = [[UIImageView alloc] initWithImage:top];
    float xPos = (([[UIScreen mainScreen] bounds].size.width - top.size.width) / 2);
    topIV.frame = CGRectMake(xPos, yPos, top.size.width, top.size.height);
    [self.burgerView addSubview:topIV];
    
    yPos += top.size.height + 10;
    
//    for (Ingredient *ingredient in ingredients) {
//        if([ingredient.type isEqualToString:@"sauce"]) {
//            [self.burgerIngredients insertObject:ingredient atIndex:0];
//        } else {
//            [self.burgerIngredients addObject:ingredient];
//        }
//    }
    
    for(Ingredient *ingredient in ingredients) {
        UIImage *burgerObject = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%@", ingredient.id, @"cropped"]];
        UIImageView *burgerObjectIV = [[UIImageView alloc] initWithImage:burgerObject];
        float xPos = (([[UIScreen mainScreen] bounds].size.width - burgerObject.size.width) / 2);
        burgerObjectIV.frame = CGRectMake(xPos, yPos, burgerObject.size.width, burgerObject.size.height);
        [self.burgerView addSubview:burgerObjectIV];
        
        yPos += burgerObject.size.height + 10;
    }
    
    [topIV bringSubviewToFront:topIV];
    
    UIImage *bottom = [UIImage imageNamed:@"bread_bottom.png"];
    UIImageView *bottomIV = [[UIImageView alloc] initWithImage:bottom];
    xPos = (([[UIScreen mainScreen] bounds].size.width - bottom.size.width) / 2);
    bottomIV.frame = CGRectMake(xPos, yPos, bottom.size.width, bottom.size.height);
    [self.burgerView addSubview:bottomIV];
    
    self.burgerView.frame = CGRectMake(self.burgerView.frame.origin.x, self.burgerView.frame.origin.y, self.burgerView.frame.size.width, yPos + bottom.size.height);
    self.burgerView.frame = CGRectMake(self.burgerView.frame.origin.x, (([[UIScreen mainScreen] bounds].size.height - self.burgerView.frame.size.height) / 2), self.burgerView.frame.size.width, yPos + bottom.size.height);
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
