//
//  PictureCell.m
//  mrburger
//
//  Created by Pieter Beulque on 9/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "PictureCell.h"

@implementation PictureCell

@synthesize picturePath = _picturePath;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont fontWithName:@"AlternateGothicCom-No2" size:FontAlternateSizeSmall];
        self.backgroundColor = [UIColor colorWithRed:0.949 green:0.275 blue:0.125 alpha:1.000];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(8, 6, 52, 52);
    self.imageView.layer.cornerRadius = 26.0f;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.borderWidth = 4.0f;
    self.imageView.layer.borderColor = [UIColor white].CGColor;
}

- (void)setPicturePath:(NSString *)picturePath
{
    _picturePath = picturePath;
    NSURL *url = [NSURL URLWithString:_picturePath];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    (void)[[NSURLConnection alloc] initWithRequest:urlRequest delegate:self startImmediately:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"connection received response");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"connection received data - !");
    self.imageView.image = [UIImage imageWithData:data scale:0.5f];
    [self layoutSubviews];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"connection failed");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connection finished loading");
}

@end
