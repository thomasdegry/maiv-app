//
//  InfoStep3View.m
//  mrburger
//
//  Created by tatsBookPro on 12/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "InfoStep3View.h"

@implementation InfoStep3View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor orange];
        
        self.title.text = @"GET OUT THERE AND FIND PEOPLE WITH MATCHING INGREDIENTS";
        [self.title makeParagraph];
        self.title.textColor = [UIColor blue];
        self.title.frame = CGRectMake(30,20, 260, 100);
        self.title.textAlignment = NSTextAlignmentRight;
        
        self.description = [[UILabel alloc] initParagraphWithFontTravelerAndFrame:CGRectMake(320, 90, 180, 200) andSize:FontTravelerSizeMedium andColor:[UIColor blue] andText:@"Go look for other ingrediënts nearby our truck. Connect with them and create a hamburger together."];
        [self.description makeParagraph];
        [self addSubview:self.description];
        self.description.textAlignment = NSTextAlignmentRight;
        self.description.textColor = [UIColor beige];
        
        self.icon = [UIImage imageNamed:@"start_step3"];
        self.iconView = [[UIImageView alloc] initWithImage:self.icon];
        self.iconView.frame = CGRectMake(-320, 120, 140, 150);
        [self addSubview: self.iconView];
    }
    return self;
}

- (void)animateIn
{
    [UIView animateWithDuration:.5 animations:^{
        self.backgroundColor = [UIColor orange];
    }];

    [UIView animateWithDuration:.6 delay:.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.iconView.frame = CGRectMake(-20, 120, 140, 150);
        self.description.frame = CGRectMake(110, 90, 180, 200);
    } completion:nil];
}

-(void)animateOut {
    [UIView animateWithDuration:.5 delay:.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundColor = [UIColor beige];
    } completion:nil];
    
    [UIView animateWithDuration:.6 delay:.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.iconView.frame = CGRectMake(-320, 120, 140, 150);
        self.description.frame = CGRectMake(320, 90, 180, 200);
    } completion:nil];
}

@end
