//
//  TabBar.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "TabBar.h"

@implementation TabBar

@synthesize btnInfo = _btnInfo;
@synthesize btnGame = _btnGame;
@synthesize btnMenus = _btnMenus;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.btnInfo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.btnInfo.frame = CGRectMake(0, 0, 100, 80);
        [self addSubview:self.btnInfo];
        
        self.btnGame = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.btnGame.frame = CGRectMake(110, 0, 100, 80);
        [self addSubview:self.btnGame];
        
        self.btnMenus = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.btnMenus.frame = CGRectMake(220, 0, 100, 80);
        [self addSubview:self.btnMenus];
    }
    return self;
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
