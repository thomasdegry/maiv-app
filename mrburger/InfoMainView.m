//
//  InfoMainView.m
//  mrburger
//
//  Created by tatsBookPro on 10/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "InfoMainView.h"

@implementation InfoMainView

@synthesize infoView = _infoView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect frame = [[UIScreen mainScreen] bounds];
        self.infoView = [[InfoView alloc] initWithFrame:frame];
        self.infoView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.infoView];
        
        float sizeOfContent = 0;
        int i;
        for (i = 0; i < [self.infoView.subviews count]; i++) {
            UIView *subview =[self.infoView.subviews objectAtIndex:i];
            sizeOfContent += subview.frame.size.height;
        }
        
        self.infoView.contentSize = CGSizeMake(320, sizeOfContent - 160);

        
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
