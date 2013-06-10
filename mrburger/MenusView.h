//
//  MenusView.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenusView : RoundedView

@property (nonatomic, strong) NSMutableArray *burgers;
@property (nonatomic, strong) UIImage *headerImg;

-(id)initWithFrame:(CGRect)frame andBurgers:(NSMutableArray*)burgers;

@end
