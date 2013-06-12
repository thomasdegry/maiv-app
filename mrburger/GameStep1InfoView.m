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
        self.title.text = @"Choose an ingredient!" ;
        self.title.font = [UIFont fontWithName:@"Mission-Script" size:FontMissionSizeSmall];
        self.message.text = [@"within your category" uppercaseString];
        self.message.frame = CGRectMake(60, 63, 200, 30);
        
        RotatePhone *rotatePhoneAnimation = [[RotatePhone alloc] initWithFrame:CGRectMake(90, 102, 133, 146)];
        [self addSubview:rotatePhoneAnimation];
    }
    return self;
}

@end
