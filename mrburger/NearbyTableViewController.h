//
//  NearbyTableViewController.h
//  ProtoPeers
//
//  Created by Pieter Beulque on 5/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZebraTableViewController.h"

#import "NearbyCell.h"
#import "UnavailableCell.h"

#import "SessionManager.h"

@interface NearbyTableViewController : ZebraTableViewController <UITableViewDataSource, UITableViewDataSource>

@property (strong, nonatomic) SessionManager *sessionManager;

@property (strong, nonatomic) NSArray *nearby;
@property (strong, nonatomic) UnavailableCell *unavailable;

- (id)initWithSessionManager:(SessionManager *)sessionManager;

@end
