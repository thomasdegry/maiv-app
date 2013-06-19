//
//  GameResultViewController.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameResultViewController.h"

@interface GameResultViewController ()

@end

@implementation GameResultViewController

@synthesize users = _users;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithBurger:(Burger *)burger andSharedCode:(NSString *)sharedCode
{
    self = [super init];
    if (self) {
        self.burger = burger;
        self.sharedCode = sharedCode;
        
        [self storeBurger:nil];
    }
    return self;
}

- (void)loadView
{
    CGRect frame = [[UIScreen mainScreen] bounds];

    GameResultView *view = [[GameResultView alloc] initWithFrame:frame andBurger:self.burger andSharedCode:self.sharedCode];
    [self setView:view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    GameResultView *view = (GameResultView *)self.view;
    [view.saveForLater addTarget:self action:@selector(dismissScreen:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)storeBurger:(id)sender
{    
    NSData *burgerData = [self.burger burgerToNSData];

    [[NSUserDefaults standardUserDefaults] setObject:self.sharedCode forKey:@"QRCode"];
    [[NSUserDefaults standardUserDefaults] setObject:burgerData forKey:@"burger"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)dismissScreen:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
