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
    
        UIView *unavailableMask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 11)];
        unavailableMask.backgroundColor = [UIColor blue];
        [self.unavailable addSubview:unavailableMask];
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
