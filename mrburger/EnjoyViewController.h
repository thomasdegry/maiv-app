//
//  EnjoyViewController.h
//  mrburger
//
//  Created by Thomas Degry on 14/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "EnjoyView.h"

@interface EnjoyViewController : UIViewController

@property (strong, nonatomic) NSArray *ingredients;

- (id)initWithIngredients:(NSArray *)ingredients;

@end
