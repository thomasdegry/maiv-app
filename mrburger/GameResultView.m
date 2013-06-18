#import "GameResultView.h"

@implementation GameResultView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andBurger:(Burger *)burger andSharedCode:(NSString *)sharedCode
{
    self = [self initWithFrame:frame];
    if (self) {
        self.burger = burger;
        self.sharedCode = sharedCode;
        
        CGRect frame = [[UIScreen mainScreen] bounds];
        self.saveForLater = [[RoundedButton alloc] initWithText:@"Save for later" andX:((frame.size.width - 274) / 2) andY:(frame.size.height - 85)];
        self.saveForLater.hidden = YES;
        [self addSubview:self.saveForLater];
        
        NSLog(@"[GameViewController] Generating ingredients and users from burger");
        
//        // All ingredient ids
//        NSMutableArray *ingredients = self.burger.ingredients;
//        
//        // Load ingredients
//        NSArray *allIngredients = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ingredients" ofType:@"plist"]];
//        
//        self.ingredients = [NSMutableArray array];
//        
//        for (Ingredient *ingredientID in ingredients) {
//            for (NSDictionary *ingredient in allIngredients) {
//                if ([[ingredient objectForKey:@"id"] isEqualToString:ingredientID.id]) {
//                    Ingredient *temp = [[Ingredient alloc] initWithDict:ingredient];
//                    
//                    if ([temp.type isEqualToString:@"sauce"]) {
//                        [self.ingredients insertObject:temp atIndex:0];
//                    } else {
//                        [self.ingredients addObject:temp];
//                    }
//                }
//            }
//        }
        
        [self buildBurger];
        [self generatefaces];

    }
    return self;
}

//- (id)initWithFrame:(CGRect)frame sharedCode:(NSString *)code users:(NSMutableArray *)users andIngredients:(NSMutableArray *)ingredients
//{
//    self = [self initWithFrame:frame];
//    if(self) {
//        self.users = [[NSArray alloc] initWithArray:users];
//        self.sharedCode = code;
//        self.ingredients = ingredients;
//        
//        UILabel *tempCode = [[UILabel alloc] initWithFontAlternateAndFrame:CGRectMake(20, 80, 280, 60) andSize:FontAlternateSizeBig andColor:[UIColor blue]];
//        tempCode.text = [@"Get your free burger" uppercaseString];
//        
//        [self addSubview:tempCode];
//        
//        CGRect frame = [[UIScreen mainScreen] bounds];
//        self.saveForLater = [[RoundedButton alloc] initWithText:@"Save for later" andX:((frame.size.width - 274) / 2) andY:(frame.size.height - 85)];
//        self.saveForLater.hidden = YES;
//        [self addSubview:self.saveForLater];
//        
//        [self buildBurger];
//        [self generatefaces];
//    }
//    
//    return self;
//}
//
//- (id)initWithFrame:(CGRect)frame sharedCode:(NSString *)code andUsers:(NSMutableArray *)users
//{
//    self = [self initWithFrame:frame];
//    if(self) {
//        NSLog(@"%@", code);
//        self.users = [[NSArray alloc] initWithArray:users];
//        self.sharedCode = code;
//        
//        UILabel *tempCode = [[UILabel alloc] initWithFontAlternateAndFrame:CGRectMake(20, 80, 280, 60) andSize:FontAlternateSizeBig andColor:[UIColor blue]];
//        tempCode.text = [@"Get your free burger" uppercaseString];
//        
//        [self addSubview:tempCode];
//        
//        CGRect frame = [[UIScreen mainScreen] bounds];
//        self.saveForLater = [[RoundedButton alloc] initWithText:@"Save for later" andX:((frame.size.width - 274) / 2) andY:(frame.size.height - 85)];
//        self.saveForLater.hidden = YES;
//        [self addSubview:self.saveForLater];
//
//        [self buildBurger];
//        [self generatefaces];
//    }
//    return self;
//}

- (void)generatefaces
{
    self.participants = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 72)];
    self.participants.backgroundColor = [UIColor orange];
    [self addSubview:self.participants];
        
    // Creating a sub view with all peers
    UIView *faces = [[UIView alloc] initWithFrame:CGRectMake(0, 4, [self.burger.users count] * 60, 60)];
    int xPos = 0;
    
    for (NSString *userID in self.burger.users) {
        CircularPicture *face = [[CircularPicture alloc] initWithPicturePath:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?width=104&height=104", userID]];
        
        face.frame = CGRectMake(xPos, 6, 52, 52);
        
        [faces addSubview:face];
        
        xPos += 60;
    }
    
    CGRect facesFrame = faces.frame;
    facesFrame.origin.x = self.frame.size.width * .5 - (facesFrame.size.width * .5 - 4);
    faces.frame = facesFrame;
    
    [self addSubview:faces];
}

- (void)buildBurger
{
    self.burgerView = [[UIView alloc] initWithFrame:CGRectMake(0, 160, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - 160)];
    [self addSubview:self.burgerView];
    
    int yPos = 0;
    
    UIImage *top = [UIImage imageNamed:@"bread_top.png"];
    UIImageView *topIV = [[UIImageView alloc] initWithImage:top];
    float xPos = (([[UIScreen mainScreen] bounds].size.width - top.size.width) / 2);
    topIV.frame = CGRectMake(xPos, yPos, top.size.width, top.size.height);
    [self.burgerView addSubview:topIV];
    
    yPos += top.size.height + 10;
    
//    NSMutableArray *renderIngredients = [NSMutableArray array];
    
    //        for (Ingredient *ingredientID in ingredients) {
    //            for (NSDictionary *ingredient in allIngredients) {
    //                if ([[ingredient objectForKey:@"id"] isEqualToString:ingredientID.id]) {
    //                    Ingredient *temp = [[Ingredient alloc] initWithDict:ingredient];
    //
    //                    if ([temp.type isEqualToString:@"sauce"]) {
    //                        [self.ingredients insertObject:temp atIndex:0];
    //                    } else {
    //                        [self.ingredients addObject:temp];
    //                    }
    //                }
    //            }
    //        }

    
    
    NSLog(@"------");
    for (NSString *ingredientID in self.burger.ingredients) {
                
        Ingredient *ingredient = [Ingredient ingredientWithID:ingredientID];
        
        UIImage *burgerObject = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%@", ingredient.image, @"cropped"]];
//        NSLog(@"%@", [NSString stringWithFormat:@"%@_%@", ingredient.image, @"cropped"]);
        UIImageView *burgerObjectIV = [[UIImageView alloc] initWithImage:burgerObject];
        float xPos = (([[UIScreen mainScreen] bounds].size.width - burgerObject.size.width) / 2);
        burgerObjectIV.frame = CGRectMake(xPos, yPos, burgerObject.size.width, burgerObject.size.height);
        [self.burgerView addSubview:burgerObjectIV];
        
        yPos += burgerObject.size.height + 10;
    }
    
    NSLog(@"------");
    
    [topIV bringSubviewToFront:topIV];
    
    UIImage *bottom = [UIImage imageNamed:@"bread_bottom.png"];
    UIImageView *bottomIV = [[UIImageView alloc] initWithImage:bottom];
    xPos = (([[UIScreen mainScreen] bounds].size.width - bottom.size.width) / 2);
    bottomIV.frame = CGRectMake(xPos, yPos, bottom.size.width, bottom.size.height);
    [self.burgerView addSubview:bottomIV];
    
    [self animateBurger];
}

- (void)animateBurger
{
//    int middleIndex = [self.burgerParts count] / 2;
//    
//    UIImageView *middleOne = [self.burgerParts objectAtIndex:middleIndex];
//    CGRect goToFrame = middleOne.frame;
//    
//    float delay = 1;
//    int topOffset = 0;
//    int bottomOffset = 0;
//    for (int i = 0; i < [self.burgerParts count]; i++) {
//        UIImageView *imageView = [self.burgerParts objectAtIndex:i];
//        Ingredient *ingredient = [self.burgerIngredients objectAtIndex:i];
//        if(i <= middleIndex - 1) {
//            NSLog(@"Kleiner dan middle index voor ingredient met naam %@", ingredient.name);
//            [UIView animateWithDuration:0.3 delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
//                imageView.frame = CGRectMake(imageView.frame.origin.x, goToFrame.origin.y - topOffset, imageView.frame.size.width, imageView.frame.size.height);
//            }completion:nil];
//            topOffset += 5;
//        } else {
//            NSLog(@"Groter dan middle index voor ingredient met naam %@", ingredient.name);
//            [UIView animateWithDuration:0.3 delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
//                imageView.frame = CGRectMake(imageView.frame.origin.x, goToFrame.origin.y + goToFrame.size.height + bottomOffset, imageView.frame.size.width, imageView.frame.size.height);
//            }completion:nil];
//            bottomOffset += 5;
//        }
//    }
    
    [UIView animateWithDuration:.3 delay:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.burgerView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, self.burgerView.frame.size.width, self.burgerView.frame.size.height);
    }completion:^ (BOOL finished){
        if(finished) {
            [self generateCode];
        }
    }];
    
}
- (void)generateCode
{
    NSError* error = nil;
    ZXMultiFormatWriter* writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix* result = [writer encode:self.sharedCode
                                  format:kBarcodeFormatQRCode
                                   width:200
                                  height:200
                                   error:&error];
    if (result) {
        [[NSUserDefaults standardUserDefaults] setObject:self.sharedCode forKey:@"QRCode"];
        UIView *background = [[UIView alloc] initWithFrame:CGRectMake((([[UIScreen mainScreen] bounds].size.width - 200) / 2), 150, 200, 200)];
        background.backgroundColor = [UIColor orange];
        background.alpha = 0;
        [background.layer setCornerRadius:10];
        [self addSubview:background];
        
        UIImage *shadow = [UIImage imageNamed:@"shadow"];
        UIImageView *shadowIV = [[UIImageView alloc] initWithImage:shadow];
        shadowIV.alpha = 0;
        shadowIV.frame = CGRectMake((([[UIScreen mainScreen] bounds].size.width - shadow.size.width) / 2), 350, shadow.size.width, shadow.size.height);
        [self addSubview:shadowIV];
        
        CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
        self.qr = [[UIImage alloc] initWithCGImage:image];
        UIImageView *codeIV = [[UIImageView alloc] initWithImage:self.qr];
        codeIV.frame = CGRectMake((([[UIScreen mainScreen] bounds].size.width - self.qr.size.width) / 2), 160, self.qr.size.width, self.qr.size.height);
        codeIV.alpha = 0;
        [self addSubview:codeIV];
        
        
        //Save for later button
        self.saveForLater.hidden = NO;
        
        [UIView animateWithDuration:.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            codeIV.alpha = 1;
            background.alpha = 1;
            shadowIV.alpha = 1;
        }completion:nil];
    } else {
        NSString* errorMessage = [error localizedDescription];
        NSLog(@"Error %@", errorMessage);
    }
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
