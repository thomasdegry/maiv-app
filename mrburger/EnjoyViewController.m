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
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"QRCode"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ingredients"];
        [[NSUserDefaults standardUserDefaults] synchronize];
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
    [self shareOnFacebook:nil];
	
    EnjoyView *view = (EnjoyView *)self.view;
    [view.closeButton addTarget:self action:@selector(dismissScreen:) forControlEvents:UIControlEventTouchUpInside];
    [view.shareButton addTarget:self action:@selector(shareOnFacebook:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dismissScreen:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
}

- (void)shareOnFacebook:(id)sender
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        EnjoyView *view = (EnjoyView *)self.view;
        UIImage *shot = [self captureBurger:view];
        
        SLComposeViewController *composeVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [composeVC setInitialText:@"I just enjoyed my free burger on PiemelFestival, how cool is that?"];
        [composeVC addImage:shot];
        [self presentViewController:composeVC animated:YES completion:^{}];
    }
}

- (UIImage *)captureBurger:(UIView *)view
{
    CGRect frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *shot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return shot;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
