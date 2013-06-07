//
//  LoginViewController.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize btnClose = _btnClose;
@synthesize btnLogin = _btnLogin;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.btnClose = [[CloseButton alloc] initWithX:280 andY:10];
        self.btnClose.delegate = self;
        
        self.btnLogin = [[FacebookButton alloc] initWithText:@"Connect with Facebook" andX:23 andY:180];
        [self.btnLogin addTarget:self action:@selector(loginWithFacebook:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)closeButtonClicked:(id)closeButton
{
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
}

- (void)loginWithFacebook:(id)sender
{
    if(!self.accountStore) {
        self.accountStore = [[ACAccountStore alloc] init];
        
        ACAccountType *facebookAccountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
        
        [_accountStore requestAccessToAccountsWithType:facebookAccountType options:@{ACFacebookAppIdKey: @"197361027085761", ACFacebookPermissionsKey: @[@"email"]} completion:^(BOOL granted, NSError *error) {
            if (granted) {
                NSArray *accounts = [_accountStore accountsWithAccountType:facebookAccountType];
                _facebookAccount = [accounts lastObject];                
                [self getFacebookInformation];
            } else {
                [self closeButtonClicked:nil];
            }
        }];
    }
}

- (void)getFacebookInformation
{
    NSURL *meurl = [NSURL URLWithString:@"https://graph.facebook.com/me"];
    
    SLRequest *merequest = [SLRequest requestForServiceType:SLServiceTypeFacebook requestMethod:SLRequestMethodGET URL:meurl parameters:nil];
    
    merequest.account = _facebookAccount;
    
    [merequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {        
        NSDictionary *userInfo = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
        
        GameViewController *gameVC = (GameViewController *)self.navigationController;
        gameVC.user = [[User alloc] initWithDict:userInfo];
        NSLog(@"Device token %@", [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"]]);
        gameVC.user.deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    }];
}

- (void)loadView
{
    self.view = [[RoundedView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view addSubview:self.btnClose];
    [self.view addSubview:self.btnLogin];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
