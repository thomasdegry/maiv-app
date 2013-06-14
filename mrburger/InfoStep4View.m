//
//  InfoStep4View.m
//  mrburger
//
//  Created by tatsBookPro on 12/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "InfoStep4View.h"

@implementation InfoStep4View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.title.text = @"GET YOUR FREE BURGER";
        self.title.textColor = [UIColor blue];
        self.title.frame = CGRectMake(0, 20, 320, 50);
        
        self.icon = [UIImage imageNamed:@"qr"];
        self.iconView = [[UIImageView alloc] initWithImage:self.icon];
        self.iconView.frame = CGRectMake(51, 80, 218, 235);
        [self addSubview: self.iconView];
    }
    return self;
}

@end
