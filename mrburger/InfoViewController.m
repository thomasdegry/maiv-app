//
//  InfoViewController.m
//  mrburger
//
//  Created by Thomas Degry on 07/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

@synthesize mainView = _mainView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor beige];
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)loadView {
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.mainView = [[InfoMainView alloc] initWithFrame:frame];

    [self setView:self.mainView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"fuck dees");
    self.mainView.infoView = nil;
    self.mainView = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self loadView];
}



@end
