//
//  LoginViewController.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "LoginViewController.h"
#import "AFHTTPClient.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize btnClose = _btnClose;
@synthesize btnLogin = _btnLogin;
@synthesize loader = _loader;
@synthesize loginLabel = _loginLabel;
@synthesize loginLabel2 = _loginLabel2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.btnClose = [[CloseButton alloc] initWithX:280 andY:10];
        self.btnClose.delegate = self;
        
        self.btnLogin = [[FacebookButton alloc] initWithText:@"Connect with Facebook" andX:23 andY:190];
        [self.btnLogin addTarget:self action:@selector(loginWithFacebook:) forControlEvents:UIControlEventTouchUpInside];
        
        self.loginLabel = [[UILabel alloc] initWithFontAlternateAndFrame:CGRectMake(110, 80, 100, 50) andSize:(FontAlternateSizeGiant) andColor:[UIColor orange]];
        self.loginLabel.text = @"LOGIN";
        self.loginLabel2 = [[UILabel alloc] initWithFontAlternateAndFrame:CGRectMake(60, 120, 200, 50) andSize:(FontAlternateSizeGiant) andColor:[UIColor blueDarkened]];
        self.loginLabel2.text = @"PRETTY PLEASE";
        
        self.loader = [[Loader alloc] init];
        self.loader.frame = CGRectMake(130, 200, 50, 50);
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
        
         [self.view addSubview:self.loader];
        self.btnLogin.hidden = YES;
        
        [KGStatusBar showWithStatus:@"Connecting to Facebook"];
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
    [KGStatusBar showWithStatus:@"Getting profile information"];
    NSURL *meurl = [NSURL URLWithString:@"https://graph.facebook.com/me"];
    
    SLRequest *merequest = [SLRequest requestForServiceType:SLServiceTypeFacebook requestMethod:SLRequestMethodGET URL:meurl parameters:nil];
    
    merequest.account = _facebookAccount;
    
    [merequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {        
        NSDictionary *facebookInfo = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
        
        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
        
        NSArray *cutName = [[facebookInfo objectForKey:@"name"] componentsSeparatedByString:@" "];
        
        [userInfo setObject:[cutName objectAtIndex:0] forKey:@"name"];
        [userInfo setObject:[facebookInfo objectForKey:@"id"] forKey:@"id"];
        [userInfo setObject:[[facebookInfo objectForKey:@"gender"] substringWithRange:NSMakeRange(0, 1)] forKey:@"gender"];
        
        GameViewController *gameVC = (GameViewController *)self.navigationController;
        gameVC.user = [[User alloc] initWithDict:userInfo];
        NSLog(@"Device token %@", [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"]]);
        gameVC.user.deviceToken = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"]];
        
        NSLog(@"User initted with device token %@", gameVC.user.deviceToken);
        
        //Save user data to user defaults
        [[NSUserDefaults standardUserDefaults] setObject:gameVC.user.id forKey:@"facebook_id"];
        [[NSUserDefaults standardUserDefaults] setObject:gameVC.user.name forKey:@"facebook_name"];
        [[NSUserDefaults standardUserDefaults] setObject:gameVC.user.gender forKey:@"facebook_gender"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [gameVC showNextScreen];
        [self saveToServer];
    }];
}

- (void)saveToServer {
    GameViewController *gameVC = (GameViewController *)self.navigationController;
    
    NSURL *url = [NSURL URLWithString:@"http://student.howest.be/thomas.degry/20122013/MAIV/FOOD/api"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            gameVC.user.id, @"id",
                            gameVC.user.name, @"name",
                            gameVC.user.gender, @"gender",
                            gameVC.user.deviceToken, @"device_token",
                            nil];
    
    [httpClient postPath:@"users" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"Request Successful, response '%@'", responseStr);
        [KGStatusBar dismiss];
        [gameVC showNextScreen];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
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
    [self.view addSubview:self.loginLabel];
    [self.view addSubview:self.loginLabel2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
