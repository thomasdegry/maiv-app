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
        
        self.btnStart = [[RoundedButton alloc] initWithText:@"Add to burger!" andX:20 andY:(frame.size.height - 85)];
        [self addSubview:self.btnStart];
        self.btnStart.hidden = YES;
        
        UILabel *lblHello = [[UILabel alloc] initAWithFontAlternateAndFrame:CGRectMake(0, 60, 320, 55) andSize:FontAlternateSizeBig andColor:[UIColor orange]];
        lblHello.text = [@"Hello there" uppercaseString];
        [self addSubview:lblHello];
        
        //Check on lock
        UIImage *lockImage = [UIImage imageNamed:@"vingkske.png"];
        self.locked = [[UIImageView alloc] initWithImage:lockImage];
        self.locked.frame = CGRectMake(245, 140, 30, 30);
        self.locked.alpha = 0;
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
    self.scrollView.delegate = self;
    
    int xPos = 0;
    int i = 0;
    for (Ingredient *ingredient in self.categoryIngredients) {
        ingredient.order = i;
        Scrollimage *scrollImage = [[Scrollimage alloc] initWithIngredient:ingredient andFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 235)];
        
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
}

-(void) startGyroLogging
{
    self.motMan = [[CMMotionManager alloc] init];
    self.motMan.accelerometerUpdateInterval = 10/60;
    
    if(self.motMan.accelerometerAvailable){
        self.isScrolling = YES;
        [self.motMan startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
            [self moveByMotion:accelerometerData andExtraMovement:0];
        }];
        
    }
}

- (void) moveByMotion:(CMAccelerometerData *)motion andExtraMovement:(float)extraMov
{
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int index = (((self.scrollView.contentOffset.x) + 80)) / [UIScreen mainScreen].bounds.size.width;
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
    
}

- (void)stopMotionUpdates
{
    [self.motMan stopDeviceMotionUpdates];
    [self.motMan stopAccelerometerUpdates];
}

- (void)lockAndScrollTo:(int)index
{
    NSLog(@"LockAndScrollTo with index %i", index);
    if(self.isScrolling) {
        NSLog(@"self.isScrolling = true");
        int xOffset = index * 320;
        [self.scrollView setContentOffset:CGPointMake(xOffset, 0) animated:YES];
        [self stopMotionUpdates];
        self.isScrolling = NO;
        self.scrollView.scrollEnabled = NO;
        
        self.btnStart.hidden = NO;
        
        [UIView animateWithDuration:.3 animations:^{
            self.locked.frame = CGRectMake(245, 140, 23, 23);
            self.locked.alpha = 1;
        }completion:nil];
    } else {
        NSLog(@"self.isScrolling = false");
        [self startGyroLogging];
        self.isScrolling = YES;
        self.scrollView.scrollEnabled = YES;
        
        self.btnStart.hidden = YES;
        
        [UIView animateWithDuration:.3 animations:^{
            self.locked.frame = CGRectMake(245, 140, 30, 30);
            self.locked.alpha = 0;
        }completion:nil];
    }
}

@end
