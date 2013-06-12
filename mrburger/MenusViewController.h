//
//  MenusViewController.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenusView.h"

@interface MenusViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *burgers;
@property (strong, nonatomic) MenusView *view;

@end
