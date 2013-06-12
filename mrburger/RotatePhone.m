//
//  RotatePhone.m
//  mrburger
//
//  Created by tatsBookPro on 11/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "RotatePhone.h"

@implementation RotatePhone

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSMutableArray *paths = [NSMutableArray arrayWithCapacity:86];
        
        for (int i = 4; i <= 41; i++) {
            NSString *resource = [NSString stringWithFormat:@"iphoneRotate_000%i", i];
            
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:resource ofType:@"png" inDirectory:@"iphone_rotate"]];
        
            [paths addObject:image];
        }
        
        for (int i = 41; i >= 4; i--) {
            [paths addObject:[paths objectAtIndex:(i - 4)]];
        }
                
        UIImageView *sequenceView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 133, 146)];
        
        sequenceView.animationImages = paths;
        sequenceView.animationDuration = 3;
        sequenceView.animationRepeatCount = 0;
        [sequenceView startAnimating];
        
        [self addSubview:sequenceView];
    }
    
    return self;
}

@end
