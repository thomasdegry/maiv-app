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
