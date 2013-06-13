#import "GameStep1MainView.h"

@implementation GameStep1MainView

@synthesize scrollView = _scrollView;
@synthesize scrollImages = _scrollImages;
@synthesize motMan = _motMan;
@synthesize isScrolling = _isScrolling;

#define kFilteringFactor 0.1

static UIAccelerationValue rollingX = 0;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Set header text
        self.header.lblTitle.text = [@"Step 1 of 3" uppercaseString];
        
        // Set instruction instead of button
        self.tapInstructions = [[UILabel alloc] initWithFontTravelerAndFrame:CGRectMake(40, (frame.size.height - 65), 240, 20) andSize:FontTravelerSizeSmall andColor:[UIColor colorWithRed:0.678 green:0.675 blue:0.624 alpha:1.000]];
        self.tapInstructions.text = @"Tap to lock your ingredient!";
        self.tapInstructions.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.tapInstructions];
        
        // Set button to start game but hide it
        self.btnStart = [[RoundedButton alloc] initWithText:@"Add to burger!" andX:20 andY:(frame.size.height - 85)];
        self.btnStart.frame = CGRectMake(self.btnStart.frame.origin.x, ([[UIScreen mainScreen] bounds].size.height), self.btnStart.frame.size.width, self.btnStart.frame.size.height);
        self.btnStart.alpha = 0;
        [self addSubview:self.btnStart];

        // Set title
        UILabel *lblHello = [[UILabel alloc] initWithFontAlternateAndFrame:CGRectMake(0, 60, 320, 55) andSize:FontAlternateSizeBig andColor:[UIColor orange]];
        lblHello.text = [@"Hello there" uppercaseString];
        [self addSubview:lblHello];
        
        // Add lock marker
        self.locked = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vingkske.png"]];
        self.locked.frame = CGRectMake(245, 140, 30, 30);
        self.locked.alpha = 0;
        self.locked.layer.anchorPoint = CGPointMake(self.locked.frame.size.width / 2, self.locked.frame.size.height / 2);
        [self addSubview:self.locked];
    }
    return self;
}

- (id)initWithIngredients:(NSMutableArray *)ingredients andFrame:(CGRect)frame
{
    self = [self initWithFrame:frame];
    
    if (self) {
        self.categoryIngredients = ingredients;
        
        Ingredient *ingredient = [self.categoryIngredients objectAtIndex:0];
        
        UILabel *greeting;
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"facebook_gender"] isEqualToString:@"m"]) {
            greeting = [[UILabel alloc] initWithFontAlternateAndFrame:CGRectMake(0, 100, frame.size.width, 40) andSize:FontAlternateSizeBig andColor:[UIColor blue]];
            greeting.text = [[NSString stringWithFormat:@"%@ %@", @"Mr.", ingredient.type] uppercaseString];
        } else {
            greeting = [[UILabel alloc] initWithFontMissionAndFrame:CGRectMake(0, 104, frame.size.width, 40) andSize:FontMissionSizeSmall andColor:[UIColor blue]];
            greeting.text = [[NSString stringWithFormat:@"%@ %@", @"Ms.", ingredient.type] capitalizedString];
        }

        [self addSubview:greeting];
        [self createScrollView];
    }
    
    return self;
}

- (void)createScrollView
{
    self.scrollImages = [NSMutableArray arrayWithCapacity:5];
    
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
        
        xPos += scrollImage.frame.size.width;
        i++;
    }
    
    float width = [self.scrollImages count] * [[UIScreen mainScreen] bounds].size.width;
    self.scrollView.contentSize = CGSizeMake(width, 235);
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self addSubview:self.scrollView];
    
    int middleIndex = ceil([self.scrollImages count] / 2);
    Ingredient *middleIngredient = [self.categoryIngredients objectAtIndex:middleIndex-1];
    [self.scrollView setContentOffset:CGPointMake((middleIndex - 1) * [[UIScreen mainScreen] bounds].size.width, 0) animated:NO];
    
    UIImage *arrow = [UIImage imageNamed:@"arrow.png"];
    self.arrowLeft = [[UIImageView alloc] initWithImage:arrow];
    self.arrowLeft.frame = CGRectMake(19, 183, arrow.size.width, arrow.size.height);
    [self addSubview:self.arrowLeft];
    
    self.arrowRight = [[UIImageView alloc] initWithImage:arrow];
    self.arrowRight.transform = CGAffineTransformMakeRotation(3.14159265);
    self.arrowRight.frame = CGRectMake(292, 183, arrow.size.width, arrow.size.height);
    [self addSubview:self.arrowRight];
    
    [self startGyroLogging];
    
    //Label
    self.label = [[UILabel alloc] initWithFontAlternateAndFrame:CGRectMake(0, 310, [[UIScreen mainScreen] bounds].size.width, 50) andSize:FontAlternateSizeBig andColor:[UIColor blue]];
    self.label.text = [middleIngredient.name uppercaseString];
    [self addSubview:self.label];
    
    //iPhone 5 styling
    if ([[UIScreen mainScreen] bounds].size.height >= 568) {
        self.scrollView.frame = CGRectMake(0, 170, [[UIScreen mainScreen] bounds].size.width, 235);
        self.arrowLeft.frame = CGRectMake(19, 253, arrow.size.width, arrow.size.height);
        self.arrowRight.frame = CGRectMake(292, 253, arrow.size.width, arrow.size.height);
        self.label.frame = CGRectMake(0, 380, [[UIScreen mainScreen] bounds].size.width, 50);
    }
    
    //Place locked next to label for first time
    CGSize textSize = [[self.label text] sizeWithFont:[self.label font] forWidth:self.label.bounds.size.width lineBreakMode:NSLineBreakByWordWrapping];
    int positionX = ([[UIScreen mainScreen] bounds].size.width / 2) + (textSize.width / 2) + 10;
    self.locked.frame = CGRectMake(positionX, (self.label.frame.origin.y - 5), self.locked.frame.size.width, self.locked.frame.size.height);
}

- (void)startGyroLogging
{
    if (!self.motMan) {
        self.motMan = [[CMMotionManager alloc] init];
        self.motMan.accelerometerUpdateInterval = 1/4;
    }
    
    if (self.motMan.accelerometerAvailable) {
        self.isScrolling = YES;
        [self.motMan startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
            [self moveByMotion:accelerometerData andExtraMovement:0];
        }];
    }
}

- (void)moveByMotion:(CMAccelerometerData *)motion andExtraMovement:(float)extraMov
{
    if (self.isScrolling) {
        rollingX = (motion.acceleration.x * kFilteringFactor) + (rollingX * (1.0 - kFilteringFactor));

        float xOffSet = (float)self.scrollView.contentOffset.x - (rollingX * 10);
        float min = 0;
        float max = ([self.scrollImages count] - 1) * [[UIScreen mainScreen] bounds].size.width;
        
        if (xOffSet < min) {
            xOffSet = min;
        } else if (xOffSet > max) {
            xOffSet = max;
        }
        
        [self.scrollView setContentOffset:CGPointMake(xOffSet, 0) animated:NO];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int index = (((self.scrollView.contentOffset.x) + 160)) / [UIScreen mainScreen].bounds.size.width;

    self.arrowLeft.hidden = (index == 0);
    self.arrowRight.hidden = (index == [self.scrollImages count] - 1);
    
    Ingredient *currentIngredient = [self.categoryIngredients objectAtIndex:index];
    self.label.text = [currentIngredient.name uppercaseString];
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
        
        CGSize textSize = [[self.label text] sizeWithFont:[self.label font] forWidth:self.label.bounds.size.width lineBreakMode:NSLineBreakByWordWrapping];
        int positionX = ([[UIScreen mainScreen] bounds].size.width / 2) + (textSize.width / 2) + 10;
        self.locked.frame = CGRectMake(positionX, (self.label.frame.origin.y - 5), self.locked.frame.size.width, self.locked.frame.size.height);

        [self.scrollView setContentOffset:CGPointMake(index * 320, 0) animated:YES];

        [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.btnStart.frame = CGRectMake(self.btnStart.frame.origin.x, (self.btnStart.frame.origin.y - 90), self.btnStart.frame.size.width, self.btnStart.frame.size.height);
            self.btnStart.alpha = 1;
            
            self.tapInstructions.frame = CGRectMake(self.tapInstructions.frame.origin.x, (self.tapInstructions.frame.origin.y + 10), self.tapInstructions.frame.size.width, self.tapInstructions.frame.size.height);
            self.tapInstructions.alpha = 0;
            
            self.locked.frame = CGRectMake(self.locked.frame.origin.x, self.locked.frame.origin.y, 23, 23);
            self.locked.alpha = 1;
        } completion:nil];
                
    } else {
        [self startGyroLogging];
        
        [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.btnStart.frame = CGRectMake(self.btnStart.frame.origin.x, (self.btnStart.frame.origin.y + 90), self.btnStart.frame.size.width, self.btnStart.frame.size.height);
            self.btnStart.alpha = 0;
            
            self.tapInstructions.frame = CGRectMake(self.tapInstructions.frame.origin.x, (self.tapInstructions.frame.origin.y - 10), self.tapInstructions.frame.size.width, self.tapInstructions.frame.size.height);
            self.tapInstructions.alpha = 1;
            
            self.locked.frame = CGRectMake(self.locked.frame.origin.x, self.locked.frame.origin.y, 30, 30);
            self.locked.alpha = 0;
        } completion:nil];
    }
}

@end
