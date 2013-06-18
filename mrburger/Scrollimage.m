//
//  Scrollimage.m
//  mrburger
//
//  Created by Thomas Degry on 09/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "ScrollImage.h"

@implementation ScrollImage

@synthesize id = _id;
@synthesize name = _name;
@synthesize type = _type;
@synthesize image = _image;
@synthesize order = _order;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CAShapeLayer *temp = [CAShapeLayer layer];
        temp.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)].CGPath;
        temp.fillColor = [UIColor redColor].CGColor;
        
        UIImage *image = [UIImage imageNamed:self.id];
        UIImageView *imageIV = [[UIImageView alloc] initWithImage:image];
        imageIV.frame = CGRectMake((frame.size.width - image.size.width) / 2, 0, image.size.width, image.size.height);
        [self addSubview:imageIV];
        
        UIImage *shadow = [UIImage imageNamed:@"shadow.png"];
        UIImageView *shadowIV = [[UIImageView alloc] initWithImage:shadow];
        shadowIV.frame = CGRectMake((frame.size.width - shadow.size.width) /2, 70 , shadow.size.width, shadow.size.height);
        [self addSubview:shadowIV];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%i", self.order], @"order", self.id, @"id", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SLIDE_TOUCH" object:self userInfo:dict];
}

- (id)initWithIngredient:(Ingredient *)ingredient andFrame:(CGRect)frame {
    
    if(self) {
        self.image = ingredient.image;
        self.name = ingredient.name;
        self.type = ingredient.type;
        self.id = ingredient.id;
        self.order = ingredient.order;
    }
    
    return [self initWithFrame:frame];
}

@end
