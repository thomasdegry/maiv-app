//
//  NearbyTableViewController.h
//  ProtoPeers
//
//  Created by Pieter Beulque on 5/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZebraTableViewController.h"

#import "SessionManager.h"

@interface NearbyTableViewController : ZebraTableViewController <UITableViewDataSource, UITableViewDataSource>

@property (strong, nonatomic) SessionManager *sessionManager;

@property (strong, nonatomic) NSMutableArray *nearby;

- (id)initWithSessionManager:(SessionManager *)sessionManager;

@end
