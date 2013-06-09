//
//  TabBarButton.h
//  mrburger
//
//  Created by Thomas Degry on 09/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarButton : UIButton

@property (strong, nonatomic) NSString *iconName;
@property (strong, nonatomic) NSString *label;
@property (strong, nonatomic) UILabel *tabbarLabel;

- (id)initWithIconName:(NSString *)iconName frame:(CGRect)frame andLabel:(NSString *)label;

@end
