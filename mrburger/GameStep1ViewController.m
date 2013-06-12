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

@synthesize currentIngredient = _currentIngredient;
@synthesize timer = _timer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSArray *categories = [[NSArray alloc] initWithObjects:@"meat", @"sauce", @"topping", @"vegetable", nil];
        NSUInteger randomIndex = arc4random() % [categories count];
        NSString *category = [categories objectAtIndex:randomIndex];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ingredients" ofType:@"plist"];
        NSDictionary *ingredients = [[NSDictionary alloc] initWithContentsOfFile:path];
        NSArray *category_ingredients = [[NSArray alloc] initWithArray:[ingredients objectForKey:category]];
        
        self.categoryIngredients = [[NSMutableArray alloc] init];
        for (NSDictionary *ingredient in category_ingredients) {
            Ingredient *tempIngredient = [[Ingredient alloc] initWithDict:ingredient];
            [self.categoryIngredients addObject:tempIngredient];
        }
        
        self.mainView = [[GameStep1MainView alloc] initWithIngredients:self.categoryIngredients andFrame:[[UIScreen mainScreen] bounds]];
        [self.mainView.btnStart addTarget:self action:@selector(startGame:) forControlEvents:UIControlEventTouchUpInside];
        self.modal = [[GameStep1InfoView alloc] initModal];
        self.modal.delegate = self;
        [self.mainView stopMotionUpdates];

        self.presentingView = [[GameStep1View alloc] initWithMain:self.mainView andModal:self.modal];
        
        [self performSelector:@selector(showModal:) withObject:nil afterDelay:.6];
        //Listen to event on touch on ingredient
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopScrollView:) name:@"SLIDE_TOUCH" object:nil];
    }
    return self;
}



- (void)viewWillDisappear:(BOOL)animated {
    [self.mainView stopMotionUpdates];
}

- (void)stopScrollView:(NSNotification *)sender {
    int order = [[sender.userInfo objectForKey:@"order"] intValue];
    self.currentIngredient = [self.categoryIngredients objectAtIndex:order];
    [self.mainView lockAndScrollTo:order];
}


- (void)startGame:(id)sender
{
    if (self.currentIngredient) {
        GameViewController *gameVC = (GameViewController *)self.navigationController;
        
        gameVC.user.ingredient.id = self.currentIngredient.id;
        gameVC.user.ingredient.name = self.currentIngredient.name;
        [gameVC showNextScreen];
    }
}

- (void)showModal:(id)sender {  
    [self.mainView stopMotionUpdates];
    [super showModal:nil];
}

- (void)hideModal:(id)sender {
    [self.mainView startGyroLogging];
    [super hideModal:nil];
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
