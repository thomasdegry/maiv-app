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
    }
    return self;
}

- (void)showIngredientThumbnail:(NSString *)ingredientID
{
    [[self.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIView *ingredientView = [[UIView alloc] initWithFrame:CGRectMake(216, 0, 74, 64)];
    
    ingredientView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:.1f];
        
    UIImageView *ingredient = [[UIImageView alloc] initWithImage:[UIImage imageNamed:ingredientID]];
    
    ingredient.contentMode = UIViewContentModeScaleAspectFit;
    ingredient.frame = CGRectMake(12, 25, 50, 17);
    [ingredientView addSubview:ingredient];
    
    [self.contentView addSubview:ingredientView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
