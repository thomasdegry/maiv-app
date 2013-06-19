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

        self.presentingView = [[ModalPresentingView alloc] initWithMain:self.mainView andModal:self.modal];

        //Listen to event on touch on ingredient
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopScrollView:) name:@"SLIDE_TOUCH" object:nil];
        
    }
    return self;
}

- (id)initWithUser:(User *)user
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.user = user;
        [self doFreeCheck];
    }
    
    return self;
}

- (void)doFreeCheck
{
    [KGStatusBar showWithStatus:@"Getting your information"];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kAPI]];
    NSString *path = [NSString stringWithFormat:@"users/%@/hasfree", self.user.id];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:path parameters:nil];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];

        [KGStatusBar dismiss];
                
        if ([response isEqualToString:@"false"]) {
            PayModalView *payModal = [[PayModalView alloc] initModal];
            [payModal.confirmBtn addTarget:self action:@selector(hidePayModal:) forControlEvents:UIControlEventTouchUpInside];
            [payModal.cancel addTarget:self action:@selector(endGame:) forControlEvents:UIControlEventTouchUpInside];

            self.modal = payModal;
        }
        
        [self performSelector:@selector(showModal:) withObject:nil afterDelay:0.6];

        [[NSUserDefaults standardUserDefaults] setObject:response forKey:@"hasfree"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [KGStatusBar showWithStatus:@"Error connecting…"];
        
        InternetModalView *internetModal = [[InternetModalView alloc] initModal];
        [internetModal.cancelBtn addTarget:self action:@selector(endGame:) forControlEvents:UIControlEventTouchUpInside];
        
        self.modal = internetModal;
        
        [self performSelector:@selector(showModal:) withObject:nil afterDelay:0.6];
    }];
    
    [operation start];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.mainView stopMotionUpdates];
}

- (void)stopScrollView:(NSNotification *)sender
{
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
    [KGStatusBar dismiss];
    GameViewController *gameVC = (GameViewController *)self.navigationController;
    [gameVC closeButtonClicked:nil];
}

- (void)showModal:(id)sender
{
    [self.mainView stopMotionUpdates];
    [super showModal:nil];
}

- (void)hideModal:(id)sender
{
    [self.mainView startGyroLogging];
    [super hideModal:nil];
}

- (void)hidePayModal:(id)sender
{
    SystemSoundID soundID;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"hamburger" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID ((__bridge CFURLRef)url, &soundID);
    AudioServicesPlaySystemSound(soundID);
    
    [self performSelector:@selector(setInstructions) withObject:nil afterDelay:.6];
    
    [self hideModal:sender];
}

- (void)setInstructions
{
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
}

@end
