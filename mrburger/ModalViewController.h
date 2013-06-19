//
//  ModalViewController.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ModalPresentingView.h"
#import "ModalView.h"

@interface ModalViewController : UIViewController <ModalDelegate>

@property (strong, nonatomic) ModalPresentingView *presentingView;
@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) ModalView *modal;
@property BOOL isShowingModal;

- (void)showModal:(id)sender;
- (void)hideModal:(id)sender;

- (void)modalView:(ModalView *)modalView isConfirmed:(BOOL)proceed;

@end
