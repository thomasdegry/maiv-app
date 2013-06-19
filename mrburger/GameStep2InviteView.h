//
//  GameStep2InviteView.h
//  mrburger
//
//  Created by Pieter Beulque on 9/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameStepInfoView.h"
#import "User.h"

@interface GameStep2InviteView : GameStepInfoView

@property (strong, nonatomic) RoundedButtonAlternate *declineBtn;
@property (strong, nonatomic) User *user;

- (id)initModalWithUser:(User *)user;

@end
