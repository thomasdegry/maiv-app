//
//  InfoViewController.m
//  mrburger
//
//  Created by Thomas Degry on 07/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "InfoViewController.h"
#import "RoundedView.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

@synthesize accountStore = _accountStore;
@synthesize facebookAccount = _facebookAccount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    RoundedButton *roundedButton = [[RoundedButton alloc] initWithText:@"Een oranje knop" andX:25 andY:50];
    [self.view addSubview:roundedButton];
    
    RoundedButtonAlternate *roundedButtonAlternate = [[RoundedButtonAlternate alloc] initWithText:@"Blauweknop" andX:25 andY:110];
    [self.view addSubview:roundedButtonAlternate];
    
    CircularButton *circleButton = [[CircularButton alloc] initWithX:280 andY:10];
    [self.view addSubview:circleButton];
    
    CloseButton *closeButton = [[CloseButton alloc] initWithX:120 andY:180];
    [self.view addSubview:closeButton];
    
    InfoButton *infoButton = [[InfoButton alloc] initWithX:160 andY:180];
    [self.view addSubview:infoButton];
    
    FacebookButton *facebook = [[FacebookButton alloc] initWithText:@"Login with Facebook" andX:25 andY:300];
    [facebook addTarget:self action:@selector(loginWithFacebook:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:facebook];
    
}

- (void)loginWithFacebook:(id)sender {
    if(!self.accountStore) {
        self.accountStore = [[ACAccountStore alloc] init];
        
        ACAccountType *facebookAccountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
        
        [_accountStore requestAccessToAccountsWithType:facebookAccountType options:@{ACFacebookAppIdKey: @"197361027085761", ACFacebookPermissionsKey: @[@"email"]} completion:^(BOOL granted, NSError *error) {
            if(granted) {
                NSArray *accounts = [_accountStore accountsWithAccountType:facebookAccountType];
                _facebookAccount = [accounts lastObject];
                NSLog(@"Success");
                
                [self me];
            } else {
                NSLog(@"Fail");
                NSLog(@"Error: %@", error);
            }
        }];
    }
}

- (void)me {
    NSURL *meurl = [NSURL URLWithString:@"https://graph.facebook.com/me"];
    
    SLRequest *merequest = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                              requestMethod:SLRequestMethodGET
                                                        URL:meurl
                                                 parameters:nil];
    
    merequest.account = _facebookAccount;
    
    [merequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        NSString *meDataString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", meDataString);
        
    }];
}

- (void)loadView {
    CGRect frame = [[UIScreen mainScreen] bounds];
    RoundedView *view = [[RoundedView alloc] initWithFrame:frame];
    [self setView:view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
