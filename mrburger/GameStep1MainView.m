#import "GameStep1MainView.h"

@implementation GameStep1MainView

@synthesize scrollView = _scrollView;
@synthesize scrollImages = _scrollImages;
@synthesize motMan = _motMan;
@synthesize isScrolling = _isScrolling;

#define kFilteringFactor 0.1

static UIAccelerationValue rollingX=0;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.header.lblTitle.text = [@"Step 1 of 3" uppercaseString];
        
        self.tabInstructions = [[UILabel alloc] initAWithFontTravelerAndFrame:CGRectMake(40, (frame.size.height - 65), 240, 20) andSize:FontTravelerSizeSmall andColor:[UIColor colorWithRed:0.678 green:0.675 blue:0.624 alpha:1.000]];
        self.tabInstructions.text = @"Tap to lock your ingredient!";
        self.tabInstructions.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.tabInstructions];
        
        self.btnStart = [[RoundedButton alloc] initWithText:@"Add to burger!" andX:20 andY:(frame.size.height - 85)];
        [self addSubview:self.btnStart];
        //self.btnStart.hidden = YES;
        self.btnStart.frame = CGRectMake(self.btnStart.frame.origin.x, ([[UIScreen mainScreen] bounds].size.height), self.btnStart.frame.size.width, self.btnStart.frame.size.height);
        self.btnStart.alpha = 0;
        
        UILabel *lblHello = [[UILabel alloc] initAWithFontAlternateAndFrame:CGRectMake(0, 60, 320, 55) andSize:FontAlternateSizeBig andColor:[UIColor orange]];
        lblHello.text = [@"Hello there" uppercaseString];
        [self addSubview:lblHello];
        
        //Check on lock
        UIImage *lockImage = [UIImage imageNamed:@"vingkske.png"];
        self.locked = [[UIImageView alloc] initWithImage:lockImage];
        self.locked.frame = CGRectMake(245, 140, 30, 30);
        self.locked.alpha = 0;
        self.locked.layer.anchorPoint = CGPointMake(self.locked.frame.size.width / 2, self.locked.frame.size.height / 2);
        [self addSubview:self.locked];
    
    }
    return self;
}

- (id)initWithIngredients:(NSMutableArray *)ingredients andFrame:(CGRect)frame
{
    self =  [self initWithFrame:frame];
    
    if (self) {
        self.categoryIngredients = ingredients;
        
        Ingredient *ingredient = [self.categoryIngredients objectAtIndex:0];
        UILabel *greeting;
        NSString *gender = @"";
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"facebook_gender"] isEqualToString:@"m"]) {
            gender = @"Mr.";
            greeting = [[UILabel alloc] initAWithFontAlternateAndFrame:CGRectMake(0, 100, frame.size.width, 40) andSize:FontAlternateSizeBig andColor:[UIColor blue]];
            greeting.text = [[NSString stringWithFormat:@"%@ %@", gender, ingredient.type] uppercaseString];
        } else {
            gender = @"Ms.";
            greeting = [[UILabel alloc] initAWithFontMissionAndFrame:CGRectMake(0, 104, frame.size.width, 40) andSize:FontMissionSizeSmall andColor:[UIColor blue]];
            greeting.text = [[NSString stringWithFormat:@"%@ %@", gender, ingredient.type] capitalizedString];
        }

        [self addSubview:greeting];
        
        [self createScrollView];
    }
    
    return self;
}

- (void)createScrollView
{
    self.scrollImages = [[NSMutableArray alloc] init];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.width, 235)];
    self.scrollView.scrollEnabled = NO;

    self.scrollView.delegate = self;
    
    int xPos = 0;
    int i = 0;
    for (Ingredient *ingredient in self.categoryIngredients) {
        ingredient.order = i;
        ScrollImage *scrollImage = [[ScrollImage alloc] initWithIngredient:ingredient andFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 235)];
        
        scrollImage.frame = CGRectMake(xPos, 70, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [self.scrollImages addObject:scrollImage];
        [self.scrollView addSubview:scrollImage];
        xPos = xPos + scrollImage.frame.size.width;
        i++;
    }
    
    float width = [self.scrollImages count] * [[UIScreen mainScreen] bounds].size.width;
    self.scrollView.contentSize = CGSizeMake(width, 235);
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self addSubview:self.scrollView];
    
    int middleIndex = ceil([self.scrollImages count] / 2);
    Ingredient *middleIngredient = [self.categoryIngredients objectAtIndex:middleIndex-1];
    [self.scrollView setContentOffset:CGPointMake((middleIndex - 1) * [[UIScreen mainScreen] bounds].size.width, 0) animated:NO];
    
    
    //Arrows
    UIImage *arrowLeft = [UIImage imageNamed:@"arrow.png"];
    self.arrowLeft = [[UIImageView alloc] initWithImage:arrowLeft];
    self.arrowLeft.frame = CGRectMake(19, 183, arrowLeft.size.width, arrowLeft.size.height);
    [self addSubview:self.arrowLeft];
    
    self.arrowRight = [[UIImageView alloc] initWithImage:arrowLeft];
    self.arrowRight.transform = CGAffineTransformMakeRotation(3.14159265);
    self.arrowRight.frame = CGRectMake(292, 183, arrowLeft.size.width, arrowLeft.size.height);
    [self addSubview:self.arrowRight];
    
    [self startGyroLogging];
    
    
    //Label
    self.label = [[UILabel alloc] initAWithFontAlternateAndFrame:CGRectMake(0, 310, [[UIScreen mainScreen] bounds].size.width, 50) andSize:FontAlternateSizeBig andColor:[UIColor blue]];
    self.label.text = [middleIngredient.name uppercaseString];
    [self addSubview:self.label];
    
    
    //iPhone 5 styling
    if([[UIScreen mainScreen] bounds].size.height >= 568) {
        self.scrollView.frame = CGRectMake(0, 170, [[UIScreen mainScreen] bounds].size.width, 235);
        self.arrowLeft.frame = CGRectMake(19, 253, arrowLeft.size.width, arrowLeft.size.height);
        self.arrowRight.frame = CGRectMake(292, 253, arrowLeft.size.width, arrowLeft.size.height);
        self.label.frame = CGRectMake(0, 380, [[UIScreen mainScreen] bounds].size.width, 50);
    }
    
    //Place locked next to label for first time
    CGSize textSize = [[self.label text] sizeWithFont:[self.label font] forWidth:self.label.bounds.size.width lineBreakMode:NSLineBreakByWordWrapping];
    int positionX = ([[UIScreen mainScreen] bounds].size.width / 2) + (textSize.width / 2) + 10;
    self.locked.frame = CGRectMake(positionX, (self.label.frame.origin.y - 5), self.locked.frame.size.width, self.locked.frame.size.height);
}

- (void)startGyroLogging
{
    if( !self.motMan ){
        self.motMan = [[CMMotionManager alloc] init];
        self.motMan.accelerometerUpdateInterval = 1/4;
    }
    
    if(self.motMan.accelerometerAvailable){
        self.isScrolling = YES;
        [self.motMan startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
            [self moveByMotion:accelerometerData andExtraMovement:0];
        }];
        
    }
}

- (void)moveByMotion:(CMAccelerometerData *)motion andExtraMovement:(float)extraMov
{
    if( self.isScrolling ){
        rollingX = (motion.acceleration.x * kFilteringFactor) + (rollingX * (1.0 - kFilteringFactor));
        //if(abs(rollingX) > 0.2) {
        float xOffSet = self.scrollView.contentOffset.x;
        xOffSet = xOffSet - (rollingX * 10);
        if(xOffSet < 0) {
            xOffSet = 0;
        } else if(xOffSet > ([self.scrollImages count] - 1) * [[UIScreen mainScreen] bounds].size.width) {
            xOffSet = ([self.scrollImages count] - 1) * [[UIScreen mainScreen] bounds].size.width;
        }
        
        [self.scrollView setContentOffset:CGPointMake(xOffSet, 0) animated:NO];
        //}
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int index = (((self.scrollView.contentOffset.x) + 160)) / [UIScreen mainScreen].bounds.size.width;
    if(index == 0) {
        self.arrowLeft.hidden = YES;
        self.arrowRight.hidden = NO;
    } else if(index == ([self.scrollImages count] - 1)) {
        self.arrowLeft.hidden = NO;
        self.arrowRight.hidden = YES;
    } else {
        self.arrowLeft.hidden = NO;
        self.arrowRight.hidden = NO;
    }
    
    Ingredient *currentIngredient = [self.categoryIngredients objectAtIndex:index];
    self.label.text = [currentIngredient.name uppercaseString];
    
    //Positioneren vinkje
    CGSize textSize = [[self.label text] sizeWithFont:[self.label font] forWidth:self.label.bounds.size.width lineBreakMode:NSLineBreakByWordWrapping];
    int positionX = ([[UIScreen mainScreen] bounds].size.width / 2) + (textSize.width / 2) + 10;
    self.locked.frame = CGRectMake(positionX, (self.label.frame.origin.y - 5), self.locked.frame.size.width, self.locked.frame.size.height);
}

- (void)stopMotionUpdates
{
    [[NSOperationQueue currentQueue] cancelAllOperations];
    
    [self.motMan stopAccelerometerUpdates];
    [self.motMan stopDeviceMotionUpdates];

}

- (void)lockAndScrollTo:(int)index
{
    if(self.isScrolling) {
        self.isScrolling = NO;
        [self stopMotionUpdates];
        
        int xOffset = index * 320;

        [self.scrollView setContentOffset:CGPointMake(xOffset, 0) animated:YES];
        //self.btnStart.hidden = NO;
        [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.btnStart.frame = CGRectMake(self.btnStart.frame.origin.x, (self.btnStart.frame.origin.y - 90), self.btnStart.frame.size.width, self.btnStart.frame.size.height);
            self.btnStart.alpha = 1;
            self.tabInstructions.frame = CGRectMake(self.tabInstructions.frame.origin.x, (self.tabInstructions.frame.origin.y + 10), self.tabInstructions.frame.size.width, self.tabInstructions.frame.size.height);
            self.tabInstructions.alpha = 0;
        }completion:nil];
        
        [UIView animateWithDuration:.3 animations:^{
            self.locked.frame = CGRectMake(self.locked.frame.origin.x, self.locked.frame.origin.y, 23, 23);
            self.locked.alpha = 1;
        }completion:nil];
        
        
    } else {
        [self startGyroLogging];
        
        //self.btnStart.hidden = YES;
        [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.btnStart.frame = CGRectMake(self.btnStart.frame.origin.x, (self.btnStart.frame.origin.y + 90), self.btnStart.frame.size.width, self.btnStart.frame.size.height);
            self.btnStart.alpha = 0;
            self.tabInstructions.frame = CGRectMake(self.tabInstructions.frame.origin.x, (self.tabInstructions.frame.origin.y - 10), self.tabInstructions.frame.size.width, self.tabInstructions.frame.size.height);
            self.tabInstructions.alpha = 1;
        }completion:nil];
        
        [UIView animateWithDuration:.3 animations:^{
            self.locked.frame = CGRectMake(self.locked.frame.origin.x, self.locked.frame.origin.y, 30, 30);
            self.locked.alpha = 0;
        }completion:nil];
    }
}

@end
