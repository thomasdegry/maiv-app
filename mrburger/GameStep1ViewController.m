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
        NSLog(@"init with frame");
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
        
        for (int i = 0; i < floor([_ingredients count] * .5); i++) {
            int replaceIndex = (arc4random() % [_ingredients count]);
            
            while (replaceIndex == i) {
                replaceIndex = (arc4random() % [_ingredients count]);
            }
            
            Ingredient *tempIngredientWR = [_ingredients objectAtIndex:i];
            Ingredient *tempIngredientTBR = [_ingredients objectAtIndex:replaceIndex];
            [_ingredients replaceObjectAtIndex:i withObject:tempIngredientTBR];
            [_ingredients replaceObjectAtIndex:replaceIndex withObject:tempIngredientWR];
        }
        
        path = nil;
        ingredients = nil;
        
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

- (id)initWithUser:(User *)user
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        NSLog(@"init with user");
        self.user = user;
        
        [self doFreeCheck];
        
    }
    return self;
}

- (void)doFreeCheck
{
    NSLog(@"dofreecheck");
    [KGStatusBar showWithStatus:@"Getting your information"];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://student.howest.be/thomas.degry/20122013/MAIV/FOOD/api"]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
                                                            path:[NSString stringWithFormat:@"users/%@/hasfree", self.user.id]
                                                      parameters:nil];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"Response: %@", response);
        [KGStatusBar dismiss];
        
        self.hasFree = YES;
        
        if([response isEqualToString:@"false"]) {
            self.hasFree = NO;
            //gebruiker heeft geen recht meer op een gratis burger
            PayModalView *modalView = [[PayModalView alloc] initModal];
            [modalView.confirmBtn addTarget:self action:@selector(hideModal:) forControlEvents:UIControlEventTouchUpInside];
            [modalView.cancel addTarget:self action:@selector(endGame:) forControlEvents:UIControlEventTouchUpInside];
            self.modal = modalView;
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:response forKey:@"hasfree"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [KGStatusBar showErrorWithStatus:@"Error connecting..?"];
    }];
    [operation start];
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

- (void)endGame:(id)sender
{
    GameViewController *gameVC = (GameViewController *)self.navigationController;
    [gameVC closeButtonClicked:nil];
}

- (void)showModal:(id)sender {  
    [self.mainView stopMotionUpdates];
    [super showModal:nil];
}

- (void)hideModal:(id)sender {
    [self.mainView startGyroLogging];
    [super hideModal:nil];
    
    if(self.hasPlayed == NO && self.hasFree == NO) {
        SystemSoundID soundID;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"hamburger" ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:path];
        AudioServicesCreateSystemSoundID ((__bridge CFURLRef)url, &soundID);
        AudioServicesPlaySystemSound(soundID);
        self.hasPlayed = YES;
    }
    
    if(self.hasFree == NO) {
        [self performSelector:@selector(setInstructions) withObject:nil afterDelay:.6];
    }
}

- (void)setInstructions {
    GameStepInfoView *modalView = [[GameStep1InfoView alloc] initModal];
    [modalView.confirmBtn addTarget:self action:@selector(hideModal:) forControlEvents:UIControlEventTouchUpInside];
    self.modal = modalView;
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
