//
//  TitledTableView.m
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "TitledTable.h"

@implementation TitledTable

@synthesize title = _title;
@synthesize tableView = _tableView;
@synthesize unavailable = _unavailable;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andTitle:(NSString *)title
{
    self = [self initWithFrame:frame];
    if (self) {
        self.titleBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 40)];
        self.titleBackground.backgroundColor = [UIColor orange];
        
        CAShapeLayer *titleMask = [CAShapeLayer layer];
        titleMask.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, frame.size.width, 40) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:(CGSize){13.0f, 13.0f}].CGPath;
        self.titleBackground.layer.mask = titleMask;

        [self addSubview:self.titleBackground];
        
        self.title = [[UILabel alloc] initWithFontAlternateAndFrame:CGRectMake(0, 0, frame.size.width, 40) andSize:FontAlternateSizeMedium andColor:[UIColor white]];
        self.title.text = [title uppercaseString];
        [self addSubview:self.title];

        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, frame.size.width, frame.size.height - 30) style:UITableViewStylePlain];
        
        self.tableView.backgroundColor = [UIColor colorWithRed:0.957 green:0.890 blue:0.729 alpha:0.500];
        self.tableView.separatorColor = [UIColor clearColor];
        
        CAShapeLayer *tableMask = [CAShapeLayer layer];
        tableMask.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, frame.size.width, frame.size.height - 30) byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:(CGSize){13.0f, 13.0f}].CGPath;
        
        self.tableView.layer.mask = tableMask;
        
        [self addSubview:self.tableView];
        
        [self showUnavailable];
    }
    return self;
}

- (void)showUnavailable
{
    self.unavailable = [[UIView alloc] initWithFrame:CGRectMake(0, 40, self.frame.size.width, 70)];
    self.unavailable.backgroundColor = [UIColor orangeDarkened];
    
    CAShapeLayer *unavailableMask = [CAShapeLayer layer];
    unavailableMask.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.frame.size.width, 65) byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:(CGSize){13.0f, 13.0f}].CGPath;

    self.unavailable.layer.mask = unavailableMask;

    [self addSubview:self.unavailable];
        
    UIImageView *unavailableImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sad_face"]];
    unavailableImage.frame = CGRectMake(8, 6, 52, 52);
    unavailableImage.layer.cornerRadius = 26.0f;
    unavailableImage.layer.masksToBounds = YES;
    unavailableImage.layer.borderWidth = 4.0f;
    unavailableImage.layer.borderColor = [UIColor white].CGColor;
    [self.unavailable addSubview:unavailableImage];
    
    UILabel *unavailableTextLabel = [[UILabel alloc] initWithFontTravelerAndFrame:CGRectMake(74, 21, 240, 20) andSize:FontTravelerSizeSmall andColor:[UIColor beige]];
    
    unavailableTextLabel.text = @"Poor you. There's no one around...";
    unavailableTextLabel.textAlignment = NSTextAlignmentLeft;
    [self.unavailable addSubview:unavailableTextLabel];
}

@end
