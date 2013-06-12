//
//  InfoStep1View.m
//  mrburger
//
//  Created by tatsBookPro on 12/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "InfoStep1View.h"

@implementation InfoStep1View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor beige];
        
        self.title.text = @"START THE BURGERQUEST";
        self.title.textColor = [UIColor blue];
        self.title.frame = CGRectMake(40,20, 250, 50);
        
        
        self.description = [[UILabel alloc] initAParagraphWithFontTravelerAndFrame:CGRectMake(320, 60, 150, 200) andSize:FontTravelerSizeMedium andColor:[UIColor blue] andText:@"Start the burger quest by clicking on the ‘create’ button. Now you will be able to login with your Facebook account"];
        [self.description makeParagraph];
        [self addSubview:self.description];
        self.description.textAlignment = NSTextAlignmentRight;
        self.description.textColor = [UIColor beige];
        
        self.icon = [UIImage imageNamed:@"start_step1"];
        self.iconView = [[UIImageView alloc] initWithImage:self.icon];
        self.iconView.frame = CGRectMake(-120, 80, 140, 150);
        [self addSubview: self.iconView];
    }
    return self;
}
- (void)animateIn
{
    NSLog(@"We animeren in");
    [UIView animateWithDuration:.5 animations:^{
         self.backgroundColor = [UIColor orange];
          
    }];
    [UIView animateWithDuration:.6 delay:.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.iconView.frame = CGRectMake(-20, 80, 140, 150);
        self.description.frame = CGRectMake(130, 60, 150, 200);
    } completion:nil];
}

-(void)animateOut {
    NSLog(@"We animeren out");
    [UIView animateWithDuration:.5 delay:.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
             self.backgroundColor = [UIColor beige];
    } completion:nil];
    [UIView animateWithDuration:.6 delay:.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.iconView.frame = CGRectMake(-120, 80, 140, 150);
        self.description.frame = CGRectMake(320, 60, 150, 200);
    } completion:nil];

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
