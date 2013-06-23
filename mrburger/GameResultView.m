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
        
        UILabel *getYour = [[UILabel alloc] initWithFontAlternateAndFrame:CGRectMake(20, 80, 280, 60) andSize:FontAlternateSizeBig andColor:[UIColor blue]];
        getYour.text = [@"Go get your free burger" uppercaseString];
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"hasfree"] isEqualToString:@"false"]) {
            getYour.text = [@"Go get your burger!" uppercaseString];
        }
        
        [self addSubview:getYour];
        
        [self buildBurger];
        [self generatefaces];
        
    }
    return self;
}


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
    topIV.frame = CGRectMake(xPos, yPos - 20, top.size.width, top.size.height);
    [self.burgerView addSubview:topIV];
    topIV.alpha = 0;
    
    [UIView animateWithDuration:.5 delay:.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
        topIV.alpha = 1;
        topIV.frame = CGRectMake(xPos, yPos, top.size.width, top.size.height);
        
    } completion:nil];
    yPos += top.size.height + 10;
    
    float delay = .6;
    for (NSString *ingredientID in self.burger.ingredients) {
        
        Ingredient *ingredient = [Ingredient ingredientWithID:ingredientID];
        
        UIImage *burgerObject = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%@", ingredient.id, @"cropped"]];
        UIImageView *burgerObjectIV = [[UIImageView alloc] initWithImage:burgerObject];
        float xPos = (([[UIScreen mainScreen] bounds].size.width - burgerObject.size.width) / 2);
        burgerObjectIV.frame = CGRectMake(xPos, yPos -20, burgerObject.size.width, burgerObject.size.height);
        [self.burgerView addSubview:burgerObjectIV];
        
        
        burgerObjectIV.alpha = 0;
        
        
        [UIView animateWithDuration:.5 delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
            burgerObjectIV.alpha = 1;
            burgerObjectIV.frame = CGRectMake(xPos, yPos, burgerObject.size.width, burgerObject.size.height);
            
        } completion:nil];
        
        delay += .2;
        yPos += burgerObject.size.height + 10;
        
    }
    
    
    [topIV bringSubviewToFront:topIV];
    
    UIImage *bottom = [UIImage imageNamed:@"bread_bottom.png"];
    UIImageView *bottomIV = [[UIImageView alloc] initWithImage:bottom];
    xPos = (([[UIScreen mainScreen] bounds].size.width - bottom.size.width) / 2);
    bottomIV.frame = CGRectMake(xPos, yPos -20, bottom.size.width, bottom.size.height);
    [self.burgerView addSubview:bottomIV];
    bottomIV.alpha = 0;
    
    [UIView animateWithDuration:.5 delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
        bottomIV.alpha = 1;
        bottomIV.frame = CGRectMake(xPos, yPos, bottom.size.width, bottom.size.height);
        
    } completion:^(BOOL finished){
        if(finished){
            [self animateBurger];
        }
    }];
    
    
}

- (void)animateBurger
{
    [UIView animateWithDuration:.3 delay:.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
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
                                   width:150
                                  height:150
                                   error:&error];
    if (result) {
        self.container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height -200)];
        [self addSubview: self.container];
        
        self.container.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3/1.5];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
        self.container.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
        [UIView commitAnimations];
        
        
        
        [[NSUserDefaults standardUserDefaults] setObject:self.sharedCode forKey:@"QRCode"];
        UIView *background = [[UIView alloc] initWithFrame:CGRectMake((([[UIScreen mainScreen] bounds].size.width - 150) / 2), 150, 150, 150)];
        background.backgroundColor = [UIColor orange];
        background.alpha = 1;
        [background.layer setCornerRadius:10];
        [self.container addSubview:background];
        
        UIImage *shadow = [UIImage imageNamed:@"shadow"];
        UIImageView *shadowIV = [[UIImageView alloc] initWithImage:shadow];
        shadowIV.alpha = 1;
        shadowIV.frame = CGRectMake((([[UIScreen mainScreen] bounds].size.width - shadow.size.width) / 2), 320 , shadow.size.width, shadow.size.height);
        [self.container addSubview:shadowIV];
        
        CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
        self.qr = [[UIImage alloc] initWithCGImage:image];
        UIImageView *codeIV = [[UIImageView alloc] initWithImage:self.qr];
        codeIV.frame = CGRectMake((([[UIScreen mainScreen] bounds].size.width - self.qr.size.width) / 2), 160, self.qr.size.width, self.qr.size.height);
        codeIV.alpha = 1;
        [self.container addSubview:codeIV];
        
        if([[UIScreen mainScreen] bounds].size.height > 480) {
            NSLog(@"iPhone5");
            background.frame = CGRectMake(background.frame.origin.x, (background.frame.origin.y + 20) , background.frame.size.width, background.frame.size.height);
            codeIV.frame = CGRectMake(codeIV.frame.origin.x, (codeIV.frame.origin.y + 20), codeIV.frame.size.width, codeIV.frame.size.height);
            shadowIV.frame = CGRectMake(shadowIV.frame.origin.x, (shadowIV.frame.origin.y + 30), shadowIV.frame.size.width, shadowIV.frame.size.height);
        }
        
        self.saveForLater.hidden = NO;
        
    } else {
        NSString* errorMessage = [error localizedDescription];
        NSLog(@"Error %@", errorMessage);
    }
}

- (void)bounce1AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
    self.container.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    [UIView commitAnimations];
}

- (void)bounce2AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce3AnimationStopped)];
    self.container.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    [UIView commitAnimations];
}

- (void)bounce3AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce4AnimationStopped)];
    self.container.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95, 0.95);
    [UIView commitAnimations];
}
- (void)bounce4AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3/2];
    self.container.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    [UIView commitAnimations];
}

@end
