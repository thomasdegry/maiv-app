//
//  InfoView.m
//  mrburger
//
//  Created by tatsBookPro on 9/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "InfoView.h"

@implementation InfoView

@synthesize headerImg = _headerImg;
@synthesize headerTypo = _headerTypo;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       
        
        self.headerImg = [UIImage imageNamed:@"homelogo2.png"];
        UIImageView* headerView = [[UIImageView alloc] initWithImage:self.headerImg];
        headerView.frame = CGRectMake(0, -300, 320, 498);
        [self addSubview: headerView];
        
        self.headerTypo = [UIImage imageNamed:@"hometypo"];
        UIImageView* headerTypoView = [[UIImageView alloc] initWithImage:self.headerTypo];
        headerTypoView.frame = CGRectMake(65, 220, 179, 129);
        [self addSubview: headerTypoView];
        
        UIImage *arrowDown = [UIImage imageNamed:@"arrow_down"];
        UIImageView* arrowView = [[UIImageView alloc] initWithImage:arrowDown];
        arrowView.frame = CGRectMake(155, 365, 7, 122);
        [self addSubview: arrowView];
        
        
        UIImage *scrollImage = [UIImage imageNamed:@"scrollview2"];
        UIImageView* scrollImageView = [[UIImageView alloc] initWithImage:scrollImage];
        scrollImageView.frame = CGRectMake(0, 510, 320, 1213);
        [self addSubview: scrollImageView];
        
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
