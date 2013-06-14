//
//  AppDelegate.h
//  mrburger
//
//  Created by Thomas Degry on 07/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

#import "MainViewController.h"
#import "InfoViewController.h"

#import "ModalViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) CBCentralManager *manager;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
