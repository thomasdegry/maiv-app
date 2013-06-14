//
//  AlternateTitledTable.m
//  mrburger
//
//  Created by Pieter Beulque on 9/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "TitledTableAlternate.h"

@implementation TitledTableAlternate

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)title
{
    self = [super initWithFrame:frame andTitle:title];
    
    if (self) {
        self.titleBackground.backgroundColor = [UIColor blueDarkened];
        self.unavailable.backgroundColor = [UIColor blue];
        
        self.tableView.backgroundColor = [UIColor colorWithRed:0.843 green:0.843 blue:0.843 alpha:0.500];
        self.tableView.separatorColor = [UIColor clearColor];
    }
    
    return self;
}

@end
