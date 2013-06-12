//
//  InfoStep2View.m
//  mrburger
//
//  Created by tatsBookPro on 12/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "InfoStep2View.h"

@implementation InfoStep2View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // Initialization code
        
        self.title.text = @"CHOOSE YOUR INGREDIENT";
        self.title.textColor = [UIColor blue];
        self.title.frame = CGRectMake(30, 20, 320, 50);
        self.title.textAlignment = NSTextAlignmentLeft;
        
        self.description = [[UILabel alloc] initParagraphWithFontTravelerAndFrame:CGRectMake(-230, 40, 170, 200) andSize:FontTravelerSizeMedium andColor:[UIColor blue] andText:@"Now you will be assigned an ingredient-type. So hello there Mr. or Ms. Topping!  Choose your favorite topping!"];
        [self.description makeParagraph];
        [self addSubview:self.description];
        self.description.textAlignment = NSTextAlignmentLeft;
        self.description.textColor = [UIColor blue];
        
        self.icon = [UIImage imageNamed:@"start_step2"];
        self.iconView = [[UIImageView alloc] initWithImage:self.icon];
        self.iconView.frame = CGRectMake(320, 70, 127, 150);
        [self addSubview: self.iconView];

    }
    return self;
}


- (void)animateIn
{
  
    [UIView animateWithDuration:.6 delay:.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.iconView.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width) - 127, 70, 127, 150);
        self.description.frame = CGRectMake(30, 40, 170, 200);
    } completion:nil];
}

-(void)animateOut {
    NSLog(@"We animeren out");
    [UIView animateWithDuration:.5 delay:.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundColor = [UIColor beige];
    } completion:nil];
    [UIView animateWithDuration:.6 delay:.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.iconView.frame = CGRectMake(320, 80, 140, 150);
        self.description.frame = CGRectMake(-320, 60, 150, 200);
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
