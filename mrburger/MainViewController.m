//
//  MainViewController.m
//  mrburger
//
//  Created by Thomas Degry on 07/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize app = _app;
@synthesize tabBar = _tabBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBar = [[TabBar alloc] initWithFrame:CGRectMake(0, 380, 320, 80)];
        
        [self.tabBar.btnInfo addTarget:self action:@selector(showInfo:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabBar.btnGame addTarget:self action:@selector(showGame:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabBar.btnMenus addTarget:self action:@selector(showMenus:) forControlEvents:UIControlEventTouchUpInside];
        
        self.app = [[AppViewController alloc] initWithNibName:nil bundle:nil];
        [self enumerateFonts];

    }
    return self;
}

- (void)enumerateFonts {
    NSLog(@"--Start enumerating font--");
    for (NSString *fontFamilyStrings in [UIFont familyNames]) {
        NSLog(@"Font family: %@", fontFamilyStrings);
        for (NSString *fontStrings in [UIFont
                                       fontNamesForFamilyName:fontFamilyStrings]) {
            NSLog(@"-- Font: %@", fontStrings);
        } }
    NSLog(@"--End enumerating font--");
}

- (void)showInfo:(id)sender
{
    [self.app setSelectedIndex:0];
    [self.app.view setNeedsDisplay];
    [self.app.view setNeedsLayout];
}

- (void)showGame:(id)sender
{
    GameViewController *gameVC = [[GameViewController alloc] initGame];
    //LoginViewController *gameVC = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:gameVC animated:YES completion:^{}];
}

- (void)showMenus:(id)sender
{
    [self.app setSelectedIndex:1];
    [self.app.view setNeedsDisplay];
    [self.app.view setNeedsLayout];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect appFrame = self.app.view.frame;
    appFrame.origin.y -= 20;
    [self.view addSubview:self.app.view];
    [self.app.view setFrame:appFrame];
    [self.view addSubview:self.tabBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
