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
@synthesize activeMarker = _driehoek;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *bg = [UIImage imageNamed:@"bg.png"];
        UIImageView *bgIV = [[UIImageView alloc] initWithImage:bg];
        [self addSubview:bgIV];
        
        UIImage *markerImage = [UIImage imageNamed:@"tabbar_arrow.png"];
        self.activeMarker = [[UIImageView alloc] initWithImage:markerImage];
        self.activeMarker.frame = CGRectMake(42, -8, markerImage.size.width, markerImage.size.height);
        [self addSubview:self.activeMarker];
        
        self.btnInfo = [[TabBarButton alloc] initWithIconName:@"tabbar_truck" frame:CGRectMake(0, 0, 100, 80) andLabel:@"info"];
        [self addSubview:self.btnInfo];
        
        self.btnGame = [[GameButton alloc] initWithFrame:CGRectMake(104, -20, 112, 99)];
        [self addSubview:self.btnGame];
        
        self.btnMenus = [[TabBarButton alloc] initWithIconName:@"tabbar_menu" frame:CGRectMake(220, 0, 100, 80) andLabel:@"menu"];
        [self addSubview:self.btnMenus];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeActiveState:) name:@"SELECTED_INDEX_CHANGE" object:nil];
    }
    return self;
}

- (void)changeActiveState:(NSNotification *)sender {
    NSString *selectedIndex = [[sender userInfo] objectForKey:@"selectedIndex"];
    if([selectedIndex isEqualToString:@"0"]) {
        [UIView animateWithDuration:.3 animations:^{
            self.activeMarker.frame = CGRectMake(42, -8, self.activeMarker.frame.size.width, self.activeMarker.frame.size.height);
            self.btnInfo.tabbarLabel.textColor = [UIColor orange];
            self.btnMenus.tabbarLabel.textColor = [UIColor beige];
        }];
    } else {
        [UIView animateWithDuration:.3 animations:^{
            self.activeMarker.frame = CGRectMake(260, -8, self.activeMarker.frame.size.width, self.activeMarker.frame.size.height);
                self.btnInfo.tabbarLabel.textColor = [UIColor beige];
            self.btnMenus.tabbarLabel.textColor = [UIColor orange];
        }];
    }
}

@end
