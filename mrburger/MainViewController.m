//
//  MainViewController.m
//  mrburger
//
//  Created by Thomas Degry on 07/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize app = _app;
@synthesize tabBar = _tabBar;
@synthesize gameVC = _gameVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBar = [[TabBar alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 74 - 20, 320, 74)];
        
        [self.tabBar.btnInfo addTarget:self action:@selector(showInfo:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabBar.btnGame addTarget:self action:@selector(showGame:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabBar.btnMenus addTarget:self action:@selector(showMenus:) forControlEvents:UIControlEventTouchUpInside];
        
        self.app = [[AppViewController alloc] initWithNibName:nil bundle:nil];
        //[self enumerateFonts];
       
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectOrientation) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
        
        
        UIImage *drips = [UIImage imageNamed:@"drippingsauce"];
        self.dripsViewLeft = [[UIImageView alloc] initWithImage:drips];
        if([UIScreen mainScreen].bounds.size.height < 568){
            self.dripsViewLeft.frame = CGRectMake(100, -50, 568, 242);

        }else{
            self.dripsViewLeft.frame = CGRectMake(100, 180, 568, 242);

        }
          
      
        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2);
        self.dripsViewLeft.transform = transform;
       
        [self.view addSubview: self.dripsViewLeft];
        
        UIImage *dripsRight = [UIImage imageNamed:@"drippingsauce2"];
        self.dripsViewRight = [[UIImageView alloc] initWithImage:dripsRight];
        if([UIScreen mainScreen].bounds.size.height < 568){
            self.dripsViewRight.frame = CGRectMake(-400, -50, 568, 242);
        }else{
            self.dripsViewRight.frame = CGRectMake(-400, 180, 568, 242);
        }
 
        
        
        CGAffineTransform transform2 = CGAffineTransformMakeRotation((-1)*M_PI_2);
        self.dripsViewRight.transform = transform2;
        
        [self.view addSubview: self.dripsViewRight];
             
    }
    return self;
}

- (void)enumerateFonts {
    NSLog(@"--Start enumerating font--");
    for (NSString *fontFamilyStrings in [UIFont familyNames]) {
        NSLog(@"Font family: %@", fontFamilyStrings);
        for (NSString *fontStrings in [UIFont
                                       fontNamesForFamilyName:fontFamilyStrings]) {
            NSLog(@"-- Font: %@", fontStrings);
        } }
    NSLog(@"--End enumerating font--");
}

- (void)showInfo:(id)sender
{
    [self.app setSelectedIndex:0];
    [self.app.view setNeedsDisplay];
    [self.app.view setNeedsLayout];
}

- (void)showGame:(id)sender
{
    self.gameVC = [[GameViewController alloc] initGame];
    //LoginViewController *gameVC = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:self.gameVC animated:YES completion:^{}];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    [super dismissViewControllerAnimated:flag completion:completion];
    NSLog(@"Dismissing view controller");
    self.gameVC = nil;
}

- (void)showMenus:(id)sender
{
    [self.app setSelectedIndex:1];
    [self.app.view setNeedsDisplay];
    [self.app.view setNeedsLayout];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect appFrame = self.app.view.frame;
    appFrame.origin.y -= 20;
    [self.view addSubview:self.app.view];
    [self.app.view setFrame:appFrame];
    [self.view addSubview:self.tabBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) detectOrientation
{
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft)
    {
        [self resetAnimation];
        self.dripsViewLeft.alpha = 1;
        [UIView animateWithDuration:.6 delay:.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            if([UIScreen mainScreen].bounds.size.height < 568){
                self.dripsViewLeft.frame = CGRectMake(80, -50, 242, 568);
            }else{
                self.dripsViewLeft.frame = CGRectMake(80, 0, 242, 568);
            }
       
        }completion:^(BOOL finished) {
            
        }];
        
        
    } else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)
    {

        [self resetAnimation];
        self.isRight = YES;
        self.dripsViewRight.alpha = 1;

        [UIView animateWithDuration:.6 delay:.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            if([UIScreen mainScreen].bounds.size.height < 568){
                  self.dripsViewRight.frame = CGRectMake(0, -50, 242, 568);
            }else{
                  self.dripsViewRight.frame = CGRectMake(0, 0, 242, 568);
            }
          

        }completion:^(BOOL finished) {
            
        }];
    } else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown)
    {
        [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.dripsViewLeft.alpha = 0;
            if([UIScreen mainScreen].bounds.size.height <568){
                 self.dripsViewLeft.frame = CGRectMake(320, -50, 242,568);
                  self.dripsViewRight.frame = CGRectMake(-250, -50, 242, 568 );
            }else{
                 self.dripsViewLeft.frame = CGRectMake(320, 0, 242,568);
                 self.dripsViewRight.frame = CGRectMake(-250, 0, 242, 568 );
            }
            self.dripsViewRight.alpha = 0;
        
        }completion:^(BOOL finished) {
             
        }];
         
    }
}
-(void)resetAnimation {
    [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    self.dripsViewLeft.alpha = 0;
    self.dripsViewRight.alpha = 0;
        
    if([UIScreen mainScreen].bounds.size.height < 568){
        self.dripsViewLeft.frame = CGRectMake(320, -50, 242,568);
        self.dripsViewRight.frame = CGRectMake(-250, -50, 242, 568 );
    }else{
        self.dripsViewLeft.frame = CGRectMake(320, 0, 242,568);
        self.dripsViewRight.frame = CGRectMake(-250, 0, 242, 568 );
    }
    
    }completion:^(BOOL finished) {
          
    }];
}

@end
