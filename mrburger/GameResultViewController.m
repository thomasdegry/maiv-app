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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithSessionManager:(SessionManager *)sessionManager andSharedCode:(NSString *)sharedCode
{
    self = [self initWithNibName:nil bundle:nil];
    
    if (self) {
        self.sessionManager = sessionManager;
        self.sharedCode = sharedCode;
    }
    
    return self;
}

- (void)loadView
{
    self.view = [[GameResultView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Creating a sub view with all peers
    UIView *faces = [[UIView alloc] initWithFrame:CGRectMake(0, 4, [self.sessionManager.connectedPeers count] * 60, 60)];
    int xPos = 0;
    
    for (NSString *peerID in self.sessionManager.connectedPeers) {
        User *user = [self.sessionManager userForPeerID:peerID];
        NSLog(@"%@", user.name);
        
        NSData *userImageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?width=104&height=104", user.id]]];
        UIImage *userImage = [UIImage imageWithData:userImageData scale:0.5f];
        UIImageView *face = [[UIImageView alloc] initWithImage:userImage];
        
        face.frame = CGRectMake(xPos, 6, 52, 52);
        face.layer.cornerRadius = 26.0f;
        face.layer.masksToBounds = YES;
        face.layer.borderWidth = 4.0f;
        face.layer.borderColor = [UIColor white].CGColor;
        
        [faces addSubview:face];
        
        xPos += 60;
    }

    CGRect facesFrame = faces.frame;
    facesFrame.origin.x = self.view.frame.size.width * .5 - (facesFrame.size.width * .5 - 4);
    faces.frame = facesFrame;
	
    [self.view addSubview:faces];
    
    UILabel *tempCode = [[UILabel alloc] initAWithFontAlternateAndFrame:CGRectMake(20, 80, 280, 60) andSize:FontAlternateSizeGiant andColor:[UIColor blue]];
    tempCode.text = self.sharedCode;
    
    [self.view addSubview:tempCode];
}

- (void)createQRCodeFromID:(NSString *)identifier
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
