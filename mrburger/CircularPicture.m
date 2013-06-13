//
//  CircularPicture.m
//  mrburger
//
//  Created by Pieter Beulque on 13/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "CircularPicture.h"

@implementation CircularPicture

@synthesize picturePath = _picturePath;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"happy_face"];
    }
    return self;
}

- (id)initWithPicturePath:(NSString *)path
{
    self = [self initWithFrame:CGRectMake(0, 0, 52, 52)];

    if (self) {
        self.picturePath = path;
        
        self.layer.cornerRadius = 26.0f;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 4.0f;
        self.layer.borderColor = [UIColor white].CGColor;
    }
    
    return self;
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
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    self.image = [UIImage imageWithData:data scale:0.5f];
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
