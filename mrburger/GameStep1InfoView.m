//
//  GameStep1InfoView.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameStep1InfoView.h"

@implementation GameStep1InfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.title.text = @"Choose an ingredient!" ;
        self.title.font = [UIFont fontWithName:@"Mission-Script" size:FontMissionSizeSmall];
        self.message.text = [@"within your category" uppercaseString];
        self.message.frame = CGRectMake(60, 63, 200, 30);
        
        RotatePhone *rotatePhoneAnimation = [[RotatePhone alloc] initWithFrame:CGRectMake(75, 75, 160, 201)];
        [self addSubview:rotatePhoneAnimation];
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
