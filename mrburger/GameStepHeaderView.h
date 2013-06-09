//
//  GameStepHeaderView.h
//  mrburger
//
//  Created by Pieter Beulque on 8/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameStepHeaderView : UIView

@property (strong, nonatomic) UILabel *lblTitle;
@property (strong, nonatomic) CloseButton *btnClose;
@property (strong, nonatomic) InfoButton *btnInfo;

- (id)initWithTitle:(NSString *)title;

@end
