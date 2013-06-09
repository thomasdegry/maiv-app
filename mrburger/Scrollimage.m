//
//  Scrollimage.m
//  mrburger
//
//  Created by Thomas Degry on 09/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "Scrollimage.h"

@implementation Scrollimage

@synthesize id = _id;
@synthesize name = _name;
@synthesize type = _type;
@synthesize image = _image;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage *image = [UIImage imageNamed:self.image];
        UIImageView *imageIV = [[UIImageView alloc] initWithImage:image];
        imageIV.frame = CGRectMake((frame.size.width - image.size.width) / 2, 0, image.size.width, image.size.height);
        [self addSubview:imageIV];
    }
    return self;
}

- (id)initWithIngredient:(Ingredient *)ingredient andFrame:(CGRect)frame {
    
    if(self) {
        self.image = ingredient.image;
        self.name = ingredient.name;
        self.type = ingredient.type;
        self.id = ingredient.id;
    }
    
    return [self initWithFrame:frame];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end