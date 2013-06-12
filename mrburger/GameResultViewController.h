//
//  GameResultViewController.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GameResultView.h"
#import "ZXingObjC.h"

#import "SessionManager.h"

@interface GameResultViewController : UIViewController

@property (strong, nonatomic) SessionManager *sessionManager;
@property (strong, nonatomic) NSString *sharedCode;

- (id)initWithSessionManager:(SessionManager *)sessionManager andSharedCode:(NSString *)sharedCode;

@end
