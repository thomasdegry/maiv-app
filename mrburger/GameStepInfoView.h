//
//  GameStepInfoView.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "ModalView.h"

@interface GameStepInfoView : ModalView

@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *message;
@property (strong, nonatomic) RoundedButton *confirmBtn;

@end
