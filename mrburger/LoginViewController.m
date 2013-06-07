//
//  LoginViewController.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize btnClose = _btnClose;
@synthesize btnLogin = _btnLogin;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.btnClose = [[CloseButton alloc] initWithX:280 andY:10];
        self.btnClose.delegate = self;
        
    }
    return self;
}

- (void)closeButtonClicked:(id)closeButton
{
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
}

- (void)loadView
{
    self.view = [[RoundedView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view addSubview:self.btnClose];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
