//
//  TitledTableView.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "TitledTable.h"

@implementation TitledTable

@synthesize title = _title;
@synthesize tableView = _tableView;

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
    self = [self initWithFrame:frame];
    if (self) {
        // Initialization code
        self.title = [[UILabel alloc] initAWithFontAlternateAndFrame:CGRectMake(0, 0, frame.size.width, 30) andSize:FontAlternateSizeMedium andColor:[UIColor blue]];
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, frame.size.width, frame.size.height - 30) style:UITableViewStylePlain];
        [self addSubview:self.title];
        [self addSubview:self.tableView];
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
