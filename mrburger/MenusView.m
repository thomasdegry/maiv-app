//
//  MenusView.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "MenusView.h"
#import "Menu.h"
#import "MenuView.h"

@implementation MenusView

@synthesize burgers = _burgers;

-(id)initWithFrame:(CGRect)frame andBurgers:(NSMutableArray*)burgers
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView* headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu"]];
        
        if ([[UIScreen mainScreen] bounds].size.height < 568){
             headerView.frame = CGRectMake(120, 10, 79, 57);
        } else {
             headerView.frame = CGRectMake(120, 40, 79, 57);
        }
       
        [self addSubview:headerView];
      
        self.burgers = [NSArray arrayWithArray:burgers];
        [self showMenus];
    }
    return self;
}

-(void)showMenus
{
    int xPos = 10;
    
    for (Menu *menu in self.burgers) {
        if ([[UIScreen mainScreen] bounds].size.height < 568) {
            CGRect frame = CGRectMake(xPos, (([[UIScreen mainScreen] bounds].size.height)/100)*15, 70, 600);
            MenuView *menuView = [[MenuView alloc] initWithFrame:frame andBurger:menu];
            [self addSubview:menuView];
        } else {
            CGRect frame = CGRectMake(xPos, 130, 70, 600);
            MenuView *menuView = [[MenuView alloc] initWithFrame:frame andBurger:menu];
            [self addSubview:menuView];
        }
        
        xPos += 100;
    }
}

@end