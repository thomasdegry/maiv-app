//
//  ModalViewController.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

@end

@implementation ModalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    ModalMainView *main = [[ModalMainView alloc] initWithFrame:bounds];
    ModalView *modal = [[ModalView alloc] initModal];
    modal.delegate = self;
    
    self.presentingView = [[ModalPresentingView alloc] initWithMain:main andModal:modal];
    self.view = self.presentingView;
    
    [main.btnModal addTarget:self action:@selector(showModal:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showModal:(id)sender
{
    [self.presentingView showModal];
}

- (void)hideModal:(id)sender
{
    [self.presentingView hideModal];
}

- (void)modalView:(ModalView *)modalView isConfirmed:(BOOL)proceed
{
    [self hideModal:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
