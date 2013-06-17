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
        NSLog(@"GameresultVC init");
    }
    return self;
}

- (id)initWithIngredients:(NSMutableArray *)ingredients users:(NSMutableArray *)users andSharedCode:(NSString *)sharedCode
{
    self = [self initWithNibName:nil bundle:nil];
    
    if (self) {
        NSLog(@"%@", sharedCode);
        self.sharedCode = sharedCode;
        self.ingredients = ingredients;
        self.users = users;
    }
    
    return self;
}

- (void)loadView
{
    NSLog(@"GameresultVC loadView");
    CGRect frame = [[UIScreen mainScreen] bounds];
    GameResultView *view = [[GameResultView alloc] initWithFrame:frame sharedCode:self.sharedCode users:self.users andIngredients:self.ingredients];
    [self setView:view];
}

- (void)viewDidLoad
{
    NSLog(@"ViewDidLoad");
    [super viewDidLoad];
    GameResultView *view = (GameResultView *)self.view;
    NSLog(@"Bestaat die knop wel ja - %@", view.saveForLater.label.text);
    [view.saveForLater addTarget:self action:@selector(storeBurger:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)storeBurger:(id)sender
{
    NSLog(@"Store burger");
    
    GameResultView *view = (GameResultView *)self.view;
    NSArray *ingredients = [[NSArray alloc] initWithArray:view.ingredients];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.sharedCode forKey:@"QRCode"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    BOOL gelukt = [self save];
    NSLog(gelukt ? @"Save gelukt" : @"Save failed");
    
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
}

-(BOOL)save {
    NSString *path = [self mrburgerArchivePath];
    NSLog(@"[GameResultViewControlller] Save to path %@", path);
    return [NSKeyedArchiver archiveRootObject:self.ingredients toFile:path];
}

- (NSString *)mrburgerArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"mrburger.archive"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
