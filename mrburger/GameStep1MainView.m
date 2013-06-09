//
//  GameStep1MainView.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameStep1MainView.h"

@implementation GameStep1MainView

@synthesize scrollView = _scrollView;
@synthesize scrollImages = _scrollImages;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.header.lblTitle.text = [@"Step 1 of 3" uppercaseString];
        
        self.btnStart = [[RoundedButton alloc] initWithText:@"Get Started!" andX:20 andY:390];
        [self addSubview:self.btnStart];
        
        UILabel *lblHello = [[UILabel alloc] initAWithFontAlternateAndFrame:CGRectMake(0, 60, 320, 55) andSize:FontAlternateSizeBig andColor:[UIColor orange]];
        lblHello.text = [@"Hello there" uppercaseString];
        [self addSubview:lblHello];
    }
    return self;
}

- (id)initWithIngredients:(NSMutableArray *)ingredients andFrame:(CGRect)frame
{
    self =  [self initWithFrame:frame];
    
    if (self) {
        self.categoryIngredients = ingredients;
        [self createScrollView];
    }
    
    return self;
}

- (void)createScrollView
{
    self.scrollImages = [[NSMutableArray alloc] init];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.width, 235)];
    
    int xPos = 0;
    for (Ingredient *ingredient in self.categoryIngredients) {
        Scrollimage *scrollImage = [[Scrollimage alloc] initWithIngredient:ingredient andFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 235)];
        
        scrollImage.frame = CGRectMake(xPos, 70, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [self.scrollImages addObject:scrollImage];
        [self.scrollView addSubview:scrollImage];
        xPos = xPos + scrollImage.frame.size.width;
    }
    
    float width = [self.scrollImages count] * [[UIScreen mainScreen] bounds].size.width;
    self.scrollView.contentSize = CGSizeMake(width, 235);
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    
    [self addSubview:self.scrollView];
    
    
    //Arrows
    UIImage *arrowLeft = [UIImage imageNamed:@"arrow.png"];
    UIImageView *arrowLeftIV = [[UIImageView alloc] initWithImage:arrowLeft];
    arrowLeftIV.frame = CGRectMake(19, 183, arrowLeft.size.width, arrowLeft.size.height);
    [self addSubview:arrowLeftIV];
    
    UIImageView *arrowRightIV = [[UIImageView alloc] initWithImage:arrowLeft];
    arrowRightIV.transform = CGAffineTransformMakeRotation(3.14159265);
    arrowRightIV.frame = CGRectMake(292, 183, arrowLeft.size.width, arrowLeft.size.height);
    [self addSubview:arrowRightIV];
    
    [self startGyroLogging];
}

-(void) startGyroLogging
{
    self.motMan = [[CMMotionManager alloc] init];
    self.motMan.accelerometerUpdateInterval = 10/60;
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
