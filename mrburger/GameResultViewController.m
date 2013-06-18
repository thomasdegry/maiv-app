//
//  GameResultViewController.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameResultViewController.h"

@interface GameResultViewController ()

@end

@implementation GameResultViewController

@synthesize users = _users;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithBurger:(Burger *)burger andSharedCode:(NSString *)sharedCode
{
    self = [super init];
    if (self) {
        self.burger = burger;
        self.sharedCode = sharedCode;
        
        [self storeBurger:nil];
    }
    return self;
}

//- (id)initWithIngredients:(NSMutableArray *)ingredients users:(NSMutableArray *)users andSharedCode:(NSString *)sharedCode
//{
//    self = [self initWithNibName:nil bundle:nil];
//    
//    if (self) {
//        NSLog(@"[GameResultViewController] alloc initWithSharedCode %@", sharedCode);
//        self.sharedCode = sharedCode;
//        self.ingredients = ingredients;
//        self.users = users;
//        
//        [self storeBurger:nil];
//    }
//    
//    return self;
//}

- (void)loadView
{
    CGRect frame = [[UIScreen mainScreen] bounds];

//    GameResultView *view = [[GameResultView alloc] initWithFrame:frame sharedCode:self.sharedCode users:self.users andIngredients:self.ingredients];
    GameResultView *view = [[GameResultView alloc] initWithFrame:frame andBurger:self.burger andSharedCode:self.sharedCode];
    [self setView:view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    GameResultView *view = (GameResultView *)self.view;
    [view.saveForLater addTarget:self action:@selector(dismissScreen:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)storeBurger:(id)sender
{
    NSLog(@"[GameResultViewController] Store burger");
        
//    Burger *burger = [[Burger alloc] init];
//    burger.ingredients = self.ingredients;
//    burger.users = self.users;
    
    NSData *burgerData = [self.burger burgerToNSData];
    
//    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:burger, @"burger", nil];
//    
//    NSMutableData *data = [[NSMutableData alloc] init];
//    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
//    [archiver encodeObject:dict forKey:@"burger"];
//    [archiver finishEncoding];

    [[NSUserDefaults standardUserDefaults] setObject:self.sharedCode forKey:@"QRCode"];
    [[NSUserDefaults standardUserDefaults] setObject:burgerData forKey:@"burger"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)dismissScreen:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
