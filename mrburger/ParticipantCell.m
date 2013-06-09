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
        self.textLabel.font = [UIFont fontWithName:@"AlternateGothicCom-No2" size:FontAlternateSizeSmall];
        self.textLabel.textColor = [UIColor brownColor];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(11, 11, 52, 52);
    self.imageView.layer.cornerRadius = 22.0f;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.borderWidth = 4.0f;
    self.imageView.layer.borderColor = [UIColor redColor].CGColor;
}

@end
