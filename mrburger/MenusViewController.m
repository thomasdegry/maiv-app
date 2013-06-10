//
//  MenusViewController.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "MenusViewController.h"
#import "Menu.h"

@interface MenusViewController ()

@end

@implementation MenusViewController

@synthesize rawBurgers = _rawBurgers;
@synthesize burgers = _burgers;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
                
        NSString *path = [[NSBundle mainBundle] pathForResource:@"menuList" ofType:@"plist"];
        self.rawBurgers = [NSMutableArray arrayWithContentsOfFile:path];
     
        self.burgers = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in self.rawBurgers) {            
            Menu *burger = [[Menu alloc] initWithDict:dict];
            [self.burgers addObject:burger];
        }
        

        
    }
    return self;
}

- (void)loadView
{
    CGRect frame = [[UIScreen mainScreen] bounds];
     self.view = [[MenusView alloc] initWithFrame:frame andBurgers:self.burgers];
    
    [self setView:self.view];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.view = nil;
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
