//
//  MainViewController.h
//  mrburger
//
//  Created by Thomas Degry on 07/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppViewController.h"
#import "TabBar.h"

#import "GameViewController.h"

@interface MainViewController : UIViewController

@property (strong, nonatomic) AppViewController *app;
@property (strong, nonatomic) TabBar *tabBar;

@property (strong, nonatomic) GameViewController *gameVC;

@end
