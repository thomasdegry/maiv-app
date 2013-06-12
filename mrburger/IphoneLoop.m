//
//  IphoneLoop.m
//  mrburger
//
//  Created by tatsBookPro on 11/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "IphoneLoop.h"

@implementation IphoneLoop

@synthesize paths = _paths;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.paths = [[NSMutableArray alloc] init];
        
        for (int i = 0; i <= 49; i++) {
            NSString *resource = (i < 10) ? [NSString stringWithFormat:@"iphoneloop_0000%i", i] : [NSString stringWithFormat:@"iphoneloop_000%i", i];
            
            NSString *path = [[NSBundle mainBundle] pathForResource:resource ofType:@"png" inDirectory:@"iphoneloop"];
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
            
            [self.paths addObject:image];
        }
        
        UIImageView *sequenceView = [[UIImageView alloc] initWithFrame:frame];
        
        // load all the frames of our animation
        sequenceView.animationImages = self.paths;
        sequenceView.frame = CGRectMake(0, 0, 160, 295);
        sequenceView.animationDuration = 3;
        sequenceView.animationRepeatCount = 0;
        [sequenceView startAnimating];
        
        [self addSubview:sequenceView];
    }
    
    return self;
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
