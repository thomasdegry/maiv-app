//
//  TitledTableView.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UnavailableCell.h"


@interface TitledTable : UIView

@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UIView *titleBackground;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *unavailable;

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)title;
- (void)showUnavailable;

@end
