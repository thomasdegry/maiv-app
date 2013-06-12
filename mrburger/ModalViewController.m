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
    return self;
}

- (void)loadView
{    
    self.view = self.presentingView;
}

- (void)setModal:(ModalView *)modal
{
    _modal = modal;
    if (self.presentingView) {
        self.presentingView.modal = self.modal;
    }
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
