//
//  ParticipantCell.m
//  mrburger
//
//  Created by Pieter Beulque on 9/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "ParticipantCell.h"

@implementation ParticipantCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor orange];
        self.textLabel.textColor = [UIColor brown];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.detailTextLabel.textColor = [UIColor beige];
        self.detailTextLabel.font = [UIFont fontWithName:@"Traveler-Medium" size:FontTravelerSizeSmall];
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        
        UIView *ingredientView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - 95, 0, 95, 64)];
        
        ingredientView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:.6f];
        
        [self.contentView addSubview:ingredientView];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
