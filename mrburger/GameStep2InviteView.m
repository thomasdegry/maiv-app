//
//  GameStep2InviteView.m
//  mrburger
//
//  Created by Pieter Beulque on 9/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameStep2InviteView.h"
#import "IphoneLoop.h"

@implementation GameStep2InviteView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initModal
{
    self = [super initModal];
    if (self) {
        UILabel *paragraph = [[UILabel alloc] initWithFontAlternateAndFrame:CGRectMake(130, 125, 160, 120) andSize:FontAlternateSizeSmall andColor:[UIColor blueDarkened]];
        paragraph.text = [@"Build a burger with your iPhones! Put your iPhone underneath the other to accept the invitation!" uppercaseString];
        [paragraph makeParagraph];
        [self addSubview:paragraph];
        
        IphoneLoop *iphoneLoopAnimation = [[IphoneLoop alloc] initWithFrame:CGRectMake(-15, 0, 160, 259)];
        [self addSubview:iphoneLoopAnimation];
        
        self.confirmBtn.hidden = YES;
        
        self.declineBtn = [[RoundedButtonAlternate alloc] initWithText:@"Decline" andX:23 andY:(self.frame.size.height - 87)];
        [self addSubview:self.declineBtn];

    }
    return self;
}

- (id)initModalWithUser:(User *)user
{
    self = [self initModal];
    if(self) {
        self.user = user;
        
        self.title.text = [NSString stringWithFormat:@"%@ wants you!", self.user.name];
        self.title.frame = CGRectMake(0, 75, 320, 50);
        [self.title setFont:[UIFont fontWithName:@"Mission-Script" size:FontMissionSizeSmall]];
        
        [self setFace];
    }
    
    return self;
}

- (void)setFace
{
    // Creating a sub view with all peers
    UIView *faces = [[UIView alloc] initWithFrame:CGRectMake(0, 8, 60, 60)];
    int xPos = 0;
    
    CircularPicture *face = [[CircularPicture alloc] initWithPicturePath:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?width=104&height=104", self.user.id]];
        
    face.frame = CGRectMake(xPos, 6, 52, 52);
        
    [faces addSubview:face];
        
    
    CGRect facesFrame = faces.frame;
    facesFrame.origin.x = self.frame.size.width * .5 - (facesFrame.size.width * .5 - 4);
    faces.frame = facesFrame;
    
    [self addSubview:faces];
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
