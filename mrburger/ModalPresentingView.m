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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithMain:(ModalMainView *)main andModal:(ModalView *)modal
{
    self = [self initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        self.mainView = main;
        self.modal = modal;
        _modalFrame = self.modal.frame;
        
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
    
    CGRect hideFrame = _modalFrame;
    hideFrame.origin.y = self.frame.size.height;
    self.modal.frame = hideFrame;
    
    [UIView animateWithDuration:0.22 animations:^{
        
        self.mainView.layer.zPosition = -1000;
        CATransform3D trRotate = CATransform3DIdentity;
        trRotate.m34 = 1.0 / -2000;
        self.mainView.layer.transform = CATransform3DRotate(trRotate, 10 * (M_PI / 180), 1, 0, 0);
        
    } completion:^(BOOL finished) {
        // 1. Set alpha for 'inactive' feeling
        // 2. Scale photo view down for depth and resetting the rotation transformation
        [UIView animateWithDuration:0.44 animations:^{
            self.mainView.alpha = .08;
            self.mainView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        }];
    }];
    
    [UIView animateWithDuration:0.36 delay:0.22 options:UIViewAnimationOptionCurveLinear animations:^{
        self.modal.frame = _modalFrame;
    } completion:^(BOOL finished) {}];

}

- (void)hideModal
{
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
            self.mainView.alpha = 1;
            self.mainView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            self.modal.hidden = YES;
        }];
    }];
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
