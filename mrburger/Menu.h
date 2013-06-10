//
//  Menu.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Menu : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSMutableArray *ingredients;
@property (strong, nonatomic) NSString *image;


- (id)initWithDict:(NSDictionary *)dict;


@end
