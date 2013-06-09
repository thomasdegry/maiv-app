//
//  ParticipantsTableViewController.h
//  ProtoPeers
//
//  Created by Pieter Beulque on 5/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SessionManager.h"

@interface ParticipantsTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) SessionManager *sessionManager;

@property (strong, nonatomic) NSMutableArray *participants;

- (id)initWithSessionManager:(SessionManager *)sessionManager;

@end
