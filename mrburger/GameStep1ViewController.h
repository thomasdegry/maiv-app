//
//  GameStep1ViewController.h
//  mrburger
//
//  Created by Pieter Beulque on 7/06/13.
//  Copyright (c) 2013 devine. All rights reserved.
//

#import "GameStepViewController.h"

#import "GameViewController.h"

#import "GameStep1MainView.h"
#import "GameStep1InfoView.h"

#import "ScrollImage.h"
#import "Ingredient.h"

@interface GameStep1ViewController : GameStepViewController

@property (strong, nonatomic) GameStep1MainView *mainView;
@property (strong, nonatomic) Ingredient *currentIngredient;

@end
