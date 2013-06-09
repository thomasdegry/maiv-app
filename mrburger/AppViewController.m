//
//  AppViewController.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "AppViewController.h"

@interface AppViewController ()

@end

@implementation AppViewController
@synthesize selectedIndex = _selectedIndex;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSArray *vcs = [[NSArray alloc] initWithObjects:[[InfoViewController alloc] initWithNibName:nil bundle:nil], [[MenusViewController alloc] initWithNibName:nil bundle:nil], nil];
        
        [self setViewControllers:vcs];
        NSLog(@"Selected index is %i", self.selectedIndex);
        self.tabBar.hidden = YES;
    }
    return self;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    NSLog(@"[Appviewcontroller] %i", selectedIndex);
    [super setSelectedIndex:selectedIndex];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i", selectedIndex], @"selectedIndex", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SELECTED_INDEX_CHANGE" object:self userInfo:dict];
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
