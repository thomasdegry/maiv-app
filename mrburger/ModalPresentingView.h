//
//  ModalPresentingView.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "ModalView.h"
#import "RoundedView.h"

@interface ModalPresentingView : RoundedView

@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) ModalView *modal;
@property (strong, nonatomic) CAShapeLayer *overlay;

- (void)showModal;
- (void)hideModal;

- (id)initWithMain:(UIView *)main andModal:(ModalView *)modal;

@end
