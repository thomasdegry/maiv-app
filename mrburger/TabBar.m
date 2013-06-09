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
        UIImage *bg = [UIImage imageNamed:@"bg.png"];
        UIImageView *bgIV = [[UIImageView alloc] initWithImage:bg];
        [self addSubview:bgIV];
        
        self.btnInfo = [[TabBarButton alloc] initWithIconName:@"tabbar_truck" frame:CGRectMake(0, 0, 100, 80) andLabel:@"info"];
        [self addSubview:self.btnInfo];
        
        self.btnGame = [[GameButton alloc] initWithFrame:CGRectMake(104, -20, 112, 99)];
        [self addSubview:self.btnGame];
        
        self.btnMenus = [[TabBarButton alloc] initWithIconName:@"tabbar_menu" frame:CGRectMake(220, 0, 100, 80) andLabel:@"menu"];
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
