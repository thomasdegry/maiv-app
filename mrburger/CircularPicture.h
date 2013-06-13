//
//  CircularPicture.h
//  mrburger
//
//  Created by Pieter Beulque on 13/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularPicture : UIImageView

@property (strong, nonatomic) NSString *picturePath;

- (id)initWithPicturePath:(NSString *)path;

@end
