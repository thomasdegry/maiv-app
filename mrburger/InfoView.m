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
        self.delegate = self;
        
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
        
        
       
        self.step1 = [[InfoStep1View alloc] initWithFrame:CGRectMake(0, 510, 320, 290)];
        [self addSubview: self.step1];
        
        self.step2 = [[InfoStep2View alloc] initWithFrame:CGRectMake(0,  self.step1.frame.origin.y +  self.step1.frame.size.height, 320, 290)];
        [self addSubview:  self.step2];
        
         self.step3 = [[InfoStep3View alloc] initWithFrame:CGRectMake(0,  self.step2.frame.origin.y +  self.step2.frame.size.height, 320, 290)];
        [self addSubview:  self.step3];
        
         self.step4 = [[InfoStep4View alloc] initWithFrame:CGRectMake(0,  self.step3.frame.origin.y +  self.step3.frame.size.height, 320, 290)];
        [self addSubview:  self.step4];
    
        
    }
    return self;
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSLog(@"speed, %f", velocity.y);
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    
    if (CGRectIntersectsRect(scrollView.bounds, CGRectMake(self.step1.frame.origin.x, (self.step1.frame.origin.y + 100), self.step1.frame.size.width, (self.step1.frame.size.height - 100)))){
        if (!self.isStep1Animated){
            [self.step1 animateIn];
            self.isStep1Animated = TRUE;
            self.isStep1AnimatedOut = FALSE;
        }        
    }
    if (!CGRectIntersectsRect(scrollView.bounds, CGRectMake(self.step1.frame.origin.x, (self.step1.frame.origin.y + 100), self.step1.frame.size.width, (self.step1.frame.size.height - 100) ))){
        if (!self.isStep1AnimatedOut){
            [self.step1 animateOut];
            self.isStep1AnimatedOut = TRUE;
            self.isStep1Animated = FALSE;
        }
    }
    
    
    if (CGRectIntersectsRect(scrollView.bounds, CGRectMake(self.step2.frame.origin.x, (self.step2.frame.origin.y + 100), self.step2.frame.size.width, (self.step2.frame.size.height - 100)))){
        if (!self.isStep2Animated){
            [self.step2 animateIn];
            self.isStep2Animated = TRUE;
            self.isStep2AnimatedOut = FALSE;
        }
    }
    if (!CGRectIntersectsRect(scrollView.bounds, CGRectMake(self.step2.frame.origin.x, (self.step2.frame.origin.y + 100), self.step2.frame.size.width, (self.step2.frame.size.height - 100) ))){
        if (!self.isStep2AnimatedOut){
            [self.step2 animateOut];
            self.isStep2AnimatedOut = TRUE;
            self.isStep2Animated = FALSE;
        }
    }
    
    
    if (CGRectIntersectsRect(scrollView.bounds, CGRectMake(self.step3.frame.origin.x, (self.step3.frame.origin.y + 100), self.step3.frame.size.width, (self.step3.frame.size.height - 100)))){
        if (!self.isStep3Animated){
            [self.step3 animateIn];
            self.isStep3Animated = TRUE;
            self.isStep3AnimatedOut = FALSE;
        }
    }
    if (!CGRectIntersectsRect(scrollView.bounds, CGRectMake(self.step3.frame.origin.x, (self.step3.frame.origin.y + 100), self.step3.frame.size.width, (self.step3.frame.size.height - 100) ))){
        if (!self.isStep3AnimatedOut){
            [self.step3 animateOut];
            self.isStep3AnimatedOut = TRUE;
            self.isStep3Animated = FALSE;
        }
    }
    
    

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
