//
//  NearbyCell.m
//  mrburger
//
//  Created by Pieter Beulque on 9/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "NearbyCell.h"

@implementation NearbyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.detailTextLabel.textColor = [UIColor beige];
        self.detailTextLabel.font = [UIFont fontWithName:@"Traveler-Medium" size:FontTravelerSizeSmall];
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        
        UIView *ingredientView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - 95, 0, 95, 64)];
        
        ingredientView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:.6f];
        
        UIImageView *plus = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"plus-button"]];
        plus.frame = CGRectMake(-8, 25, 16, 16);
        
        [ingredientView addSubview:plus];
        
        [self.contentView addSubview:ingredientView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
