//
//  EnjoyViewController.m
//  mrburger
//
//  Created by Thomas Degry on 14/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "EnjoyViewController.h"

@interface EnjoyViewController ()

@end

@implementation EnjoyViewController

@synthesize ingredients = _ingredients;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithIngredients:(NSArray *)ingredients
{
    self = [super initWithNibName:nil bundle:nil];
    if(self) {
        self.ingredients = ingredients;
    }
    
    return self;
}

- (void)loadView
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    EnjoyView *view = [[EnjoyView alloc] initWithFrame:frame andIngredients:self.ingredients];
    [self setView:view];
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
