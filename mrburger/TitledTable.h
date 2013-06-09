//
//  TitledTableView.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitledTable : UIView

@property (strong, nonatomic) UIView *title;
@property (strong, nonatomic) UITableView *tableView;

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)title;

@end
