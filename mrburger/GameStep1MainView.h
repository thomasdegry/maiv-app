//
//  GameStep1MainView.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>

#import "GameStepMainView.h"
#import "Scrollimage.h"
#import "Ingredient.h"

@interface GameStep1MainView : GameStepMainView <UIScrollViewDelegate>

@property (strong, nonatomic) RoundedButton *btnStart;

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray *scrollImages;
@property (strong, nonatomic) NSMutableArray *categoryIngredients;

@property (nonatomic,strong) CMMotionManager *motMan;
@property (nonatomic) CMAcceleration acceleration;

@property (strong, nonatomic) UIImageView *arrowLeft;
@property (strong, nonatomic) UIImageView *arrowRight;
@property (strong, nonatomic) UILabel *label;

- (id)initWithIngredients:(NSMutableArray *)ingredients andFrame:(CGRect)frame;
- (void) stopMotionUpdates;

@end
