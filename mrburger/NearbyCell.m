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
    }
    return self;
}

- (void)showIngredientThumbnail:(NSString *)ingredientID
{
    [[self.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

    UIView *ingredientView = [[UIView alloc] initWithFrame:CGRectMake(216, 0, 74, 64)];
    
    ingredientView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:.1f];
    
    UIImageView *plus = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"plus-button"]];
    plus.frame = CGRectMake(-8, 25, 16, 16);
    
    [ingredientView addSubview:plus];
    
    UIImageView *ingredient = [[UIImageView alloc] initWithImage:[UIImage imageNamed:ingredientID]];
    
    ingredient.contentMode = UIViewContentModeScaleAspectFit;
    ingredient.frame = CGRectMake(12, 25, 50, 17);
    [ingredientView addSubview:ingredient];

    [self.contentView addSubview:ingredientView];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
