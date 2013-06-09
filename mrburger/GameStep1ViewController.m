//
//  GameStep1ViewController.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameStep1ViewController.h"

@interface GameStep1ViewController ()

@end

@implementation GameStep1ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.mainView = (GameStep1MainView *)[[GameStep1MainView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [self.mainView.btnStart addTarget:self action:@selector(startGame:) forControlEvents:UIControlEventTouchUpInside];
        
        self.modal = [[GameStep1InfoView alloc] initModal];
        self.modal.delegate = self;
        
        self.presentingView = [[GameStep1View alloc] initWithMain:self.mainView andModal:self.modal];
    }
    return self;
}

- (void)startGame:(id)sender
{
    GameViewController *gameVC = (GameViewController *)self.navigationController;
    [gameVC showNextScreen];
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
