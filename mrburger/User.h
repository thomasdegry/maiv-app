//
//  User.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *profilePicture;
@property (strong, nonatomic) NSString *deviceToken;

- (id)initWithDict:(NSDictionary *)dict;

@end
