//
//  ModalPresentingView.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ModalMainView.h"
#import "ModalView.h"

@interface ModalPresentingView : UIView

@property (strong, nonatomic) ModalMainView *mainView;
@property (strong, nonatomic) ModalView *modal;

- (void)showModal;
- (void)hideModal;

- (id)initWithMain:(ModalMainView *)main andModal:(ModalView *)modal;

@end
