//
//  MenuView.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "MenuView.h"

@implementation MenuView

@synthesize burger = _burger;
@synthesize labels = _labels;
@synthesize price = _price;

- (id)initWithFrame:(CGRect)frame andBurger:(Menu*)burger
{
    self = [super initWithFrame:frame];
    if (self) {
        self.burger = burger;
        self.labels = [[NSMutableArray alloc] initWithCapacity:9];
        [self showBurger];
    }
    return self;
}

- (void)showBurger
{
    // Show icon
    UIImage *icon = [UIImage imageNamed:self.burger.image];
    UIImageView *iconView = [[UIImageView alloc] initWithImage:icon];
    iconView.frame = CGRectMake((self.frame.size.width * .5) - (icon.size.width * .5) + 12, 0, icon.size.width, icon.size.height);

    [self addSubview:iconView];
    
    // Show menu title
    UILabel *title = [[UILabel alloc] initAWithFontAlternateAndFrame:CGRectMake(0, 40, 100, 50) andSize:FontAlternateSizeMedium andColor:[UIColor blueDarkened]];
    title.text = [self.burger.name uppercaseString];
    [self addSubview:title];
    
    // Show all ingredients
    // Starting vertical position is 90
    int yPos = 90;
    
    for (NSString *ingredient in self.burger.ingredients) {
        UILabel *ingredientName = [[UILabel alloc] initAWithFontAlternateAndFrame:CGRectMake(0, yPos, 100, 17) andSize:FontAlternateSizeTiny andColor:[UIColor brown]];
        ingredientName.text = [ingredient uppercaseString];
        
        [self.labels addObject:ingredientName];
        [self addSubview: ingredientName];
    
        yPos += 17;
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            yPos += 3;
        }
    }
   
    self.price = [[UILabel alloc] initAWithFontAlternateAndFrame:CGRectMake(0, yPos + 15 , 100, 17) andSize:FontAlternateSizeMedium andColor:[UIColor orange]];
    self.price.text = [NSString stringWithFormat:@"$%@", [self.burger.price uppercaseString]];
    [self addSubview:self.price];
    
    [self animate];
}

- (void)animate
{
    float delay = 0;

    // Hide price
    self.price.alpha = 0;

    for (UILabel *label in self.labels) {
        label.alpha = 0;
        
        if ([self.burger.name isEqualToString:@"Mr Burger"]){
            label.frame = CGRectMake(label.frame.origin.x - 20, label.frame.origin.y + 20 , 100, 17);
        } else if ([self.burger.name isEqualToString:@"Mr Meat"]){
            label.frame = CGRectMake(0, label.frame.origin.y + 20 , 100, 17);
        } else if ([self.burger.name isEqualToString:@"Mr Veg"]){
            label.frame = CGRectMake(label.frame.origin.x + 20, label.frame.origin.y + 20 , 100, 17);
        }
        
        [UIView animateWithDuration:.3 delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
            label.alpha = 1;
            
            if ([self.burger.name isEqualToString:@"Mr Burger"]){
                label.frame = CGRectMake(label.frame.origin.x + 20, label.frame.origin.y - 20 , 100, 17);
            } else if ([self.burger.name isEqualToString:@"Mr Meat"]){
                label.frame = CGRectMake(0, label.frame.origin.y - 20 , 100, 17);
            } else if ([self.burger.name isEqualToString:@"Mr Veg"]){
                label.frame = CGRectMake(label.frame.origin.x - 20, label.frame.origin.y - 20 , 100, 17);
            }
                       
        } completion:nil];
        
        delay += .1;
    }
    
    delay += .1;
    
    [UIView animateWithDuration:.3 delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.price.alpha = 1;
    } completion:nil];
}

@end
