//
//  GameStepHeaderView.m
//  mrburger
//
//  Created by Pieter Beulque on 8/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameStepHeaderView.h"


@implementation GameStepHeaderView

@synthesize lblTitle = _lblTitle;
@synthesize btnClose = _btnClose;
@synthesize btnInfo = _btnInfo;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CAShapeLayer * maskLayer = [CAShapeLayer layer];
        maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii: (CGSize){13.0, 13.}].CGPath;
        
        self.layer.mask = maskLayer;
        
        
        self.btnInfo = [[InfoButton alloc] initWithX:10 andY:10];
        [self addSubview:self.btnInfo];
        
        self.btnClose = [[CloseButton alloc] initWithX:280 andY:10];
        [self addSubview:self.btnClose];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title
{
    self = [self initWithFrame:CGRectMake(0, 0, 320, 48)];
    
    if (self) {
        self.lblTitle = [[UILabel alloc] initAWithFontAlternateAndFrame:CGRectMake(40, 5, 240, 38) andSize:FontAlternateSizeMedium andColor:[UIColor beige]];
        self.lblTitle.text = title;
        [self addSubview:self.lblTitle];
        
        self.backgroundColor = [UIColor blue];
    }
    
    return self;
}

@end
