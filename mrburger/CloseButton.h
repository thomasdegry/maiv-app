//
//  CloseButton.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "CircularButton.h"

@class CloseButton;

@protocol CloseButtonDelegate

- (void)closeButtonClicked:(CloseButton *)closeButton;

@end

@interface CloseButton : CircularButton

@property (weak, nonatomic) id delegate;

@end
