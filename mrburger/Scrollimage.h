//
//  Scrollimage.h
//  mrburger
//
//  Created by Thomas Degry on 09/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "Ingredient.h"

@interface Scrollimage : UIView

@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *id;
@property (assign) int order;

- (id)initWithIngredient:(Ingredient *)ingredient andFrame:(CGRect)frame;

@end
