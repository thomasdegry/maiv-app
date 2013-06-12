//
//  TabBarButton.m
//  mrburger
//
//  Created by Thomas Degry on 09/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "TabBarButton.h"

@implementation TabBarButton

@synthesize label = _label;
@synthesize iconName = _iconName;
@synthesize tabbarLabel = _tabbarLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", self.iconName]];
        UIImageView *imageIV = [[UIImageView alloc] initWithImage:image];
        imageIV.frame = CGRectMake(((frame.size.width - image.size.width) / 2), 12, image.size.width, image.size.height);
        [self addSubview:imageIV];
        
        self.tabbarLabel = [[UILabel alloc] initAWithFontAlternateAndFrame:CGRectMake(0, 14, frame.size.width, frame.size.height) andSize:FontAlternateSizeTiny andColor:[UIColor beige]];
        self.tabbarLabel.textColor = [UIColor beige];
        self.tabbarLabel.text = [self.label uppercaseString];
        [self addSubview:self.tabbarLabel];
    }
    return self;
}

- (id)initWithIconName:(NSString *)iconName frame:(CGRect)frame andLabel:(NSString *)label {
    self = [self initWithFrame:frame];
    if (self) {
        self.label = label;
        self.iconName = iconName;
    }
    return self;
}

@end
