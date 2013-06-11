//
//  GameStep3ViewController.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameStep3ViewController.h"

@interface GameStep3ViewController ()

@end

@implementation GameStep3ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.mainView = [[GameStep3MainView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.modal = [[GameStep3InfoView alloc] initModal];
        self.modal.delegate = self;
                
        self.presentingView = [[GameStep3View alloc] initWithMain:self.mainView andModal:self.modal];
    }
    return self;
}

- (id)initWithSessionManager:(SessionManager *)sessionManager
{
    self = [self initWithNibName:nil bundle:nil];
    
    if (self) {
        self.sessionManager = sessionManager;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
