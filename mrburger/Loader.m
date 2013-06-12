//
//  SequenceView.m
//  loaderDemo
//
//  Created by tatsBookPro on 9/06/13.
//  Copyright (c) 2013 tatsBookPro. All rights reserved.
//

#import "Loader.h"

@implementation Loader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSMutableArray *paths = [[NSMutableArray alloc] init];
        
        for (int i = 0; i <= 74; i++) {
            NSString *resource = (i < 10) ? [NSString stringWithFormat:@"loader_0000%i", i] : [NSString stringWithFormat:@"loader_000%i", i];
                       
            NSString *path = [[NSBundle mainBundle] pathForResource:resource ofType:@"png" inDirectory:@"images"];
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
            
            [paths addObject:image];
        }
                
        UIImageView *sequenceView = [[UIImageView alloc] initWithFrame:frame];
        
        sequenceView.animationImages = paths;
        sequenceView.frame = CGRectMake(0, 0, 50, 50);
        sequenceView.animationDuration = 1.75;
        sequenceView.animationRepeatCount = 0;
        [sequenceView startAnimating];
        
        [self addSubview:sequenceView];
    }
    
    return self;
}


@end
