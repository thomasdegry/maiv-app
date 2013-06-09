//
//  TabBar.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameButton.h"
#import "TabBarButton.h"

@interface TabBar : UIView

@property (strong, nonatomic) TabBarButton *btnInfo;
@property (strong, nonatomic) GameButton *btnGame;
@property (strong, nonatomic) TabBarButton *btnMenus;

@end
