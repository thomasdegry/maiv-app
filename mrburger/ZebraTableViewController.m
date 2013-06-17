//
//  ZebraTableViewController.m
//  mrburger
//
//  Created by Pieter Beulque on 9/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "ZebraTableViewController.h"

@interface ZebraTableViewController ()

@end

@implementation ZebraTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
//    UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
//    footer.backgroundColor = [UIColor clearColor];
//    [self.tableView setTableFooterView:footer];
//    
//    self.tableView.backgroundColor = [UIColor whiteColor];
//
//    self.tableView.separatorColor = [UIColor clearColor];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0f;
}




@end
