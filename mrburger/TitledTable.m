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
        // Initialization code        
        self.titleBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 70)];
        self.titleBackground.layer.cornerRadius = 11.0f;
        self.titleBackground.backgroundColor = [UIColor orange];
        [self addSubview:self.titleBackground];
        
        self.title = [[UILabel alloc] initAWithFontAlternateAndFrame:CGRectMake(0, 0, frame.size.width, 50) andSize:FontAlternateSizeMedium andColor:[UIColor white]];
        self.title.text = [title uppercaseString];
        [self addSubview:self.title];

        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, frame.size.width, frame.size.height - 30) style:UITableViewStylePlain];
        [self addSubview:self.tableView];
    
        self.unavailable = [[UIView alloc] initWithFrame:CGRectMake(0, 50, frame.size.width, 76)];
        self.unavailable.layer.cornerRadius = 11.0f;
        self.unavailable.backgroundColor = [UIColor orangeDarkened];
        [self addSubview:self.unavailable];
        
        UIView *unavailableMask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 11)];
        unavailableMask.backgroundColor = [UIColor orangeDarkened];
        [self.unavailable addSubview:unavailableMask];
        
        UIImageView *unavailableImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sad_face"]];
        unavailableImage.frame = CGRectMake(11, 11, 52, 52);
        unavailableImage.layer.cornerRadius = 26.0f;
        unavailableImage.layer.masksToBounds = YES;
        unavailableImage.layer.borderWidth = 4.0f;
        unavailableImage.layer.borderColor = [UIColor white].CGColor;
        [self.unavailable addSubview:unavailableImage];
        
        UILabel *unavailableTextLabel = [[UILabel alloc] initAWithFontTravelerAndFrame:CGRectMake(74, 27, 240, 20) andSize:FontTravelerSizeSmall andColor:[UIColor beige]];
        
        unavailableTextLabel.text = @"Poor you. There's no one around...";
        unavailableTextLabel.textAlignment = NSTextAlignmentLeft;
        [self.unavailable addSubview:unavailableTextLabel];
        

    }
    return self;
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
