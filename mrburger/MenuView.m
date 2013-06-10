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
@synthesize icon = _icon;
@synthesize labels = _labels;
@synthesize price = _price;

- (id)initWithFrame:(CGRect)frame andBurger:(Menu*)burger
{
    self = [super initWithFrame:frame];
    if(self){
        self.burger = burger;
        [self createBurger];
        
    }
    return self;
    
}

- (void)createBurger
{
    
    self.icon = [UIImage imageNamed:self.burger.image];
    UIImageView* iconView = [[UIImageView alloc] initWithImage:self.icon];
    iconView.frame = CGRectMake((self.frame.size.width/2) - (self.icon.size.width/2) +12, 0,   self.icon.size.width,   self.icon.size.height);

    [self addSubview: iconView];
    
    UILabel *title = [[UILabel alloc] initAWithFontAlternateAndFrame:CGRectMake(0, 40, 100, 50) andSize:(FontAlternateSizeMedium) andColor:[UIColor blueDarkened]];
    title.text = [self.burger.name uppercaseString];
    title.textAlignment  = NSTextAlignmentCenter;
    [self addSubview: title];
    
    int yPos = 90;
    
    self.labels = [[NSMutableArray alloc] init];
    for (NSString *ingredient in self.burger.ingredients) {
        UILabel *ingredientName = [[UILabel alloc] initAWithFontAlternateAndFrame:CGRectMake(0, yPos, 100, 17) andSize:(FontAlternateSizeTiny) andColor:[UIColor brown]];
        ingredientName.text = [ingredient uppercaseString];
        ingredientName.textAlignment  = NSTextAlignmentCenter;
        [self.labels addObject:ingredientName];
            
        [self addSubview: ingredientName];
    
        yPos += 17;
        if([[UIScreen mainScreen] bounds].size.height == 568){
               yPos += 3;
        }
    
    }
   
    
    self.price = [[UILabel alloc] initAWithFontAlternateAndFrame:CGRectMake(0, yPos + 15 , 100, 17) andSize:(FontAlternateSizeMedium) andColor:[UIColor orange]];
    self.price.text = [NSString stringWithFormat:@"$%@", [self.burger.price uppercaseString]];
    self.price.textAlignment  = NSTextAlignmentCenter;
    [self addSubview: self.price];
    self.price.alpha = 0;
    
     [self animate];

}

- (void)animate
{
    NSLog(@"Burger, %@", self.burger.name);
    float delay = 0;
    for (UILabel *label in self.labels) {
        label.alpha = 0;
        
        if([self.burger.name isEqualToString:@"Mr Burger"]){
            label.frame = CGRectMake(label.frame.origin.x - 20, label.frame.origin.y + 20 , 100, 17);
        } else if ([self.burger.name isEqualToString:@"Mr Meat"]){
            label.frame = CGRectMake(0, label.frame.origin.y + 20 , 100, 17);
        } else if ([self.burger.name isEqualToString:@"Mr Veg"]){
              label.frame = CGRectMake(label.frame.origin.x + 20, label.frame.origin.y + 20 , 100, 17);
        }
        
        [UIView animateWithDuration:.3 delay:delay options:(UIViewAnimationOptionCurveEaseOut) animations:^{
            label.alpha = 1;
            
            if([self.burger.name isEqualToString:@"Mr Burger"]){
                label.frame = CGRectMake(label.frame.origin.x + 20, label.frame.origin.y - 20 , 100, 17);
            } else if ([self.burger.name isEqualToString:@"Mr Meat"]){
                label.frame = CGRectMake(0, label.frame.origin.y - 20 , 100, 17);
            } else if ([self.burger.name isEqualToString:@"Mr Veg"]){
                label.frame = CGRectMake(label.frame.origin.x - 20, label.frame.origin.y - 20 , 100, 17);
            }
                       
        }completion:nil];
        delay += .1;
    }
    
    
    delay += .1;
    [UIView animateWithDuration:.3 delay:delay options:(UIViewAnimationOptionCurveEaseOut) animations:^{
        self.price.alpha = 1;
            }completion:nil];
 


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
