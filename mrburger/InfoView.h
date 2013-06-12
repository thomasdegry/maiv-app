//
//  InfoView.h
//  mrburger
//
//  Created by tatsBookPro on 9/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "InfoStep1View.h"
#import "InfoStep2View.h"
#import "InfoStep3View.h"
#import "InfoStep4View.h"

@interface InfoView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, strong) UIImage *headerImg;
@property (nonatomic, strong) UIImage *headerTypo;
@property (strong, nonatomic) InfoStep1View *step1;
@property (strong, nonatomic) InfoStep2View *step2;
@property (strong, nonatomic) InfoStep3View *step3;
@property (strong, nonatomic) InfoStep4View *step4;
@property (nonatomic) BOOL isStep1Animated;
@property (nonatomic) BOOL isStep1AnimatedOut;
@property (nonatomic) BOOL isStep2Animated;
@property (nonatomic) BOOL isStep2AnimatedOut;
@property (nonatomic) BOOL isStep3Animated;
@property (nonatomic) BOOL isStep3AnimatedOut;
@property (nonatomic) BOOL isStep4Animated;
@property (nonatomic) BOOL isStep4AnimatedOut;

@end
