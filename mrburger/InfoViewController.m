//
//  InfoViewController.m
//  mrburger
//
//  Created by Thomas Degry on 07/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "InfoViewController.h"
#import "RoundedView.h"
#import "InfoScrollView.h"

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
        self.view.backgroundColor = [UIColor beige];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
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
    InfoMainView *mainView = [[InfoMainView alloc] initWithFrame:frame];
    [self setView:mainView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
