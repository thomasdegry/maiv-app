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
{
    NSMutableArray *_ingredients;
}

@synthesize currentIngredient = _currentIngredient;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _ingredients = [[NSMutableArray alloc] initWithCapacity:5];
        
        NSString *categories[4];
        categories[0] = @"meat";
        categories[1] = @"sauce";
        categories[2] = @"topping";
        categories[3] = @"vegetable";

        NSString *category = [[NSArray arrayWithObjects:categories count:4] objectAtIndex:(arc4random() % 4)];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ingredients" ofType:@"plist"];
        NSArray *ingredients = [NSArray arrayWithContentsOfFile:path];
        
        for (NSDictionary *ingredient in ingredients) {
            if ([[ingredient objectForKey:@"type"] isEqualToString:category]) {
                [_ingredients addObject:[[Ingredient alloc] initWithDict:ingredient]];
            }
        }
        
        self.mainView = [[GameStep1MainView alloc] initWithIngredients:_ingredients andFrame:[[UIScreen mainScreen] bounds]];
        [self.mainView.btnStart addTarget:self action:@selector(startGame:) forControlEvents:UIControlEventTouchUpInside];
        self.modal = [[GameStep1InfoView alloc] initModal];
        self.modal.delegate = self;
        [self.mainView stopMotionUpdates];

        self.presentingView = [[ModalPresentingView alloc] initWithMain:self.mainView andModal:self.modal];
        
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
    self.currentIngredient = [_ingredients objectAtIndex:order];
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
