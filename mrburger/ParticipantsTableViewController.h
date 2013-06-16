//
//  ParticipantsTableViewController.h
//  ProtoPeers
//
//  Created by Pieter Beulque on 5/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZebraTableViewController.h"

#import "SessionManager.h"

#import "ParticipantCell.h"

@interface ParticipantsTableViewController : ZebraTableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) SessionManager *sessionManager;

@property (strong, nonatomic) NSArray *participants;

- (id)initWithSessionManager:(SessionManager *)sessionManager;

@end
