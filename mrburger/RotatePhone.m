//
//  RotatePhone.m
//  mrburger
//
//  Created by tatsBookPro on 11/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "RotatePhone.h"

@implementation RotatePhone

@synthesize paths = _paths;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.paths = [[NSMutableArray alloc] init];
        
        for (int i = 0; i <= 74; i++) {
            NSString *resource = (i < 10) ? [NSString stringWithFormat:@"iphoneRotate_0000%i", i] : [NSString stringWithFormat:@"iphoneRotate_000%i", i];
            
            NSString *path = [[NSBundle mainBundle] pathForResource:resource ofType:@"png" inDirectory:@"iphone_rotate"];
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
            
            [self.paths addObject:image];
        }
        
        UIImageView *sequenceView = [[UIImageView alloc] initWithFrame:frame];
        
        // load all the frames of our animation
        sequenceView.animationImages = self.paths;
        sequenceView.frame = CGRectMake(0, 0, 160, 201);
        sequenceView.animationDuration = 3;
        sequenceView.animationRepeatCount = 0;
        [sequenceView startAnimating];
        
        [self addSubview:sequenceView];
    }
    
    return self;
}

@end
