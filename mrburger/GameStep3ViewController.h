//
//  GameStep3ViewController.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameStepViewController.h"

#import "GameStep3InfoView.h"
#import "GameStep3MainView.h"
#import "GameStep3View.h"

#import "SessionManager.h"

@interface GameStep3ViewController : GameStepViewController

@property (strong, nonatomic) SessionManager *sessionManager;

- (id)initWithSessionManager:(SessionManager *)sessionManager;

@end
