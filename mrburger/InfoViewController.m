//
//  InfoViewController.m
//  mrburger
//
//  Created by Thomas Degry on 07/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "InfoViewController.h"
#import "RoundedView.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    RoundedButton *roundedButton = [[RoundedButton alloc] initWithText:@"Een oranje knop" andX:25 andY:50];
    [self.view addSubview:roundedButton];
    
    RoundedButtonAlternate *roundedButtonAlternate = [[RoundedButtonAlternate alloc] initWithText:@"Blauweknop" andX:25 andY:110];
    [self.view addSubview:roundedButtonAlternate];
    
    CircularButton *circleButton = [[CircularButton alloc] initWithX:280 andY:10];
    [self.view addSubview:circleButton];
    
    CloseButton *closeButton = [[CloseButton alloc] initWithX:120 andY:180];
    [self.view addSubview:closeButton];
    
    InfoButton *infoButton = [[InfoButton alloc] initWithX:160 andY:180];
    [self.view addSubview:infoButton];
    
}

- (void)loadView {
    CGRect frame = [[UIScreen mainScreen] bounds];
    RoundedView *view = [[RoundedView alloc] initWithFrame:frame];
    [self setView:view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
