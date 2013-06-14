//
//  ModalPresentingView.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//


#import "ModalPresentingView.h"


@implementation ModalPresentingView
{
    CGRect _modalFrame;
}

@synthesize overlay = _overlay;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

- (id)initWithMain:(UIView *)main andModal:(ModalView *)modal
{
    self = [self initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.mainView = main;
        self.modal = modal;
        _modalFrame = self.modal.frame;
        
        self.overlay = [CAShapeLayer layer];
        self.overlay.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)].CGPath;
        self.overlay.fillColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.64f].CGColor;
        self.overlay.opacity = 0;
        [self.layer addSublayer:self.overlay];
        
        self.modal.hidden = YES;
        
        [self addSubview:self.mainView];
        [self addSubview:self.modal];
        
      
    }
    return self;
}

- (void)setModal:(ModalView *)modal
{
    [[self subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
    _modal = modal;
    
    [self addSubview:self.mainView];
    [self addSubview:self.modal];
}

- (void)showModal
{
    self.modal.hidden = NO;
    [self.mainView setUserInteractionEnabled:NO];    CGRect hideFrame = _modalFrame;
    
    hideFrame.origin.y = self.frame.size.height;
    self.modal.frame = hideFrame;
    
    CABasicAnimation *animationOverlay = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animationOverlay.duration = .3;
    animationOverlay.fromValue = [NSNumber numberWithFloat:0.0f];
    animationOverlay.toValue = [NSNumber numberWithFloat:1.0f];
    animationOverlay.removedOnCompletion = NO;
    [self.overlay addAnimation:animationOverlay forKey:@"overlay"];
    self.overlay.opacity = 1;
    
    [UIView animateWithDuration:0.22 delay:.4 options:UIViewAnimationOptionCurveLinear animations:^{
        self.mainView.layer.zPosition = -1000;
        CATransform3D trRotate = CATransform3DIdentity;
        trRotate.m34 = 1.0 / -2000;
        self.mainView.layer.transform = CATransform3DRotate(trRotate, 10 * (M_PI / 180), 1, 0, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.44 animations:^{
            self.mainView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        }];
    }];
    
    [UIView animateWithDuration:0.36 delay:0.22 options:UIViewAnimationOptionCurveLinear animations:^{
        self.modal.frame = _modalFrame;
    } completion:nil];
}

- (void)hideModal
{
    [self.mainView setUserInteractionEnabled:YES];
    
    CGRect hideFrame = _modalFrame;
    hideFrame.origin.y = self.frame.size.height;
    
    [UIView animateWithDuration:0.22 animations:^{
        self.modal.frame = hideFrame;
        
        self.mainView.layer.zPosition = 0;
        CATransform3D trRotate = CATransform3DIdentity;
        trRotate.m34 = 1.0 / 2000;
        self.mainView.layer.transform = CATransform3DRotate(trRotate, -10 * (M_PI / 180), 1, 0, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.44 animations:^{
            self.mainView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            CABasicAnimation *animationFadeOutOverlay = [CABasicAnimation animationWithKeyPath:@"opacity"];
            animationFadeOutOverlay.duration = 1;
            animationFadeOutOverlay.fromValue = [NSNumber numberWithFloat:0.0f];
            animationFadeOutOverlay.toValue = [NSNumber numberWithFloat:0.5f];
            [self.overlay addAnimation:animationFadeOutOverlay forKey:@"overlay"];
            self.overlay.opacity = 0.5;
        } completion:^(BOOL finished) {
            self.modal.hidden = YES;
        }];
    }];
}

@end