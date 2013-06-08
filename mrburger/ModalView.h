//
//  ModalView.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModalView;

@protocol ModalDelegate <NSObject>

- (void)modalView:(ModalView *)modalView isConfirmed:(BOOL)proceed;

@end

@interface ModalView : UIView

@property (assign, nonatomic) id delegate;

- (id)initModal;

@end
