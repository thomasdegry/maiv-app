//
//  SequenceView.m
//  loaderDemo
//
//  Created by tatsBookPro on 9/06/13.
//  Copyright (c) 2013 tatsBookPro. All rights reserved.
//

#import "SequenceView.h"

@implementation SequenceView

@synthesize paden = _paden;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.paden = [[NSMutableArray alloc] init];
        
        for (int i=0; i <= 74; i++){
            NSString *foto = @"";
            
            if (i < 10){
                foto = [NSString stringWithFormat:@"loader_0000%i", i];
            }else{
                foto = [NSString stringWithFormat:@"loader_000%i", i];
            }
           
            NSLog(@"Foto %@", foto);
            NSString *path = [[NSBundle mainBundle] pathForResource:foto ofType:@"png" inDirectory:@"images"];
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
            
            [self.paden addObject:image];
        }
        
        self.paden_array = [[NSArray alloc] initWithArray:self.paden];
        
        UIImageView *sequenceView = [[UIImageView alloc] initWithFrame:frame];
        
        // load all the frames of our animation
        sequenceView.animationImages = self.paden_array;
        sequenceView.frame = CGRectMake(0, 0, 50, 50);
            // all frames will execute in 1.75 seconds
        
            sequenceView.animationDuration = 1.75;
            // repeat the annimation forever
            sequenceView.animationRepeatCount = 0;
            // start animating
            [sequenceView startAnimating];
            // add the animation view to the main window
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
