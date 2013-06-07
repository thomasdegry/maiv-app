//
//  RoundedButton.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundedButton : UIButton

@property (strong, nonatomic) NSString *string;
@property (strong, nonatomic) UILabel *label;

- (id)initWithText:(NSString *)text andX:(float)x andY:(float)y;

@end
