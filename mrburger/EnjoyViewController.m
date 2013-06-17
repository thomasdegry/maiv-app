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
    NSLog(@"sdkqfjm");
    self = [super initWithNibName:nil bundle:nil];
    if(self) {
        NSLog(@"in self");
        self.ingredients = ingredients;
        
        NSString *QR = [[NSUserDefaults standardUserDefaults] objectForKey:@"QRCode"];
        NSLog(@"%@", QR);
        NSArray *codeInformation = [QR componentsSeparatedByString:@"-"];
        self.burgerID = [codeInformation objectAtIndex:0];
        self.userID = [codeInformation objectAtIndex:1];
        
        [self setPaidOnServer];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"QRCode"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return self;
}

- (void)setPaidOnServer
{
    [KGStatusBar showWithStatus: @"Validating your order"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://student.howest.be"]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
                                                            path:[NSString stringWithFormat:@"thomas.degry/20122013/MAIV/FOOD/api/creations/pay/%@/%@", self.userID, self.burgerID]
                                                      parameters:nil];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Print the response body in text
        NSLog(@"Response: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        [KGStatusBar dismiss];
        [self delete];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [operation start];
}

-(BOOL)delete {
    NSString *path = [self mrburgerArchivePath];
    NSLog(@"[GameResultViewControlller] Save to path %@", path);
    return [NSKeyedArchiver archiveRootObject:[[NSMutableArray alloc] init] toFile:path];
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
        [composeVC addURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://student.howest.be/thomas.degry/20122013/MAIV/mrburger/gallery/%@", self.burgerID]]];
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

- (NSString *)mrburgerArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"mrburger.archive"];
}

@end
