//
//  InfoStep2View.h
//  mrburger
//
//  Created by tatsBookPro on 12/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoPartView.h"

@interface InfoStep2View : InfoPartView
@property (strong, nonatomic) UIImageView* iconView;

-(void)animateOut;
-(void)animateIn;

@end
