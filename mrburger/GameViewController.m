#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

@synthesize user = _user;
@synthesize currentScreen = _currentScreen;
@synthesize sharedCode = _sharedCode;
@synthesize manager = _manager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        
        self.navigationBarHidden = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showEnjoyYourBurger:) name:@"SHOW_ENJOY" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self.sessionManager selector:@selector(destroySession) name:@"DESTROY_SESSION" object:nil];
    }
    return self;
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    [self isLECapableHardware];
}

- (BOOL) isLECapableHardware
{
    NSString * state = nil;
    
    switch ([self.manager state])
    {
        case CBCentralManagerStateUnsupported:
            state = @"The platform/hardware doesn't support Bluetooth Low Energy.";
            break;
        case CBCentralManagerStateUnauthorized:
            state = @"The app is not authorized to use Bluetooth Low Energy.";
            break;
        case CBCentralManagerStatePoweredOff:
            state = @"Bluetooth is currently powered off.";
            break;
        case CBCentralManagerStatePoweredOn:
            return TRUE;
        case CBCentralManagerStateUnknown:
        default:
            return FALSE;
            
    }
    
    NSLog(@"Central manager state: %@", state);
    return FALSE;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initGame
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"facebook_id"] == nil) {
        //User is not logged in with facebook yet
        LoginViewController *startVC = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
        self = [self initWithRootViewController:startVC];
        if (self) {
            self.currentScreen = GameScreenLogin;
        }
    } else {
        //User is logged in with facebook
        self.user = [[User alloc] init];
        self.user.id = [[NSUserDefaults standardUserDefaults] objectForKey:@"facebook_id"];
        self.user.name = [[NSUserDefaults standardUserDefaults] objectForKey:@"facebook_name"];
        self.user.gender = [[NSUserDefaults standardUserDefaults] objectForKey:@"facebook_gender"];
        self.user.deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
        self.user.ingredient = [[Ingredient alloc] init];
        
        
        //Check if ingredients stored in NSArchive
        if(![[NSUserDefaults standardUserDefaults] objectForKey:@"QRCode"]) {
            //Geen data in archive
            NSLog(@"Start from clean slate no data found in archive, lauching step 1");
            GameStep1ViewController *startVC = [[GameStep1ViewController alloc] initWithNibName:nil bundle:nil];
            self = [self initWithRootViewController:startVC];
            if (self) {
                self.currentScreen = GameScreenStep1;
            }
        } else {
            NSLog(@"Start again with existing data");
            NSArray *ingredients = [NSKeyedUnarchiver unarchiveObjectWithFile:[self mrburgerArchivePath]];
            self.ingredients = [[NSMutableArray alloc] initWithArray:ingredients];
            self.sharedCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"QRCode"];
            NSLog(@"Code uit de userdefaults: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"QRCode"]);
            
            [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
            self.users = [[NSMutableArray alloc] init];
            GameResultViewController *vc = [[GameResultViewController alloc] initWithIngredients:self.ingredients users:self.users andSharedCode:self.sharedCode];
            self = [self initWithRootViewController:vc];
            self.currentScreen = GameScreenResult;

        }
        
        
        
        
    }
    
    return self;
}

- (void)closeButtonClicked:(CloseButton *)closeButton
{
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    
    if (self.sessionManager) {
        [self.sessionManager destroySession];
    }
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
}

- (void)dismissScreen:(NSNotification *)sender
{
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
}

- (void)showNextScreen
{    
    GameStepViewController *nextScreen = nil;
    
    switch (self.currentScreen) {
        case GameScreenLogin:
            nextScreen = [[GameStep1ViewController alloc] initWithNibName:nil bundle:nil];
            self.currentScreen = GameScreenStep1;
            break;
        
        case GameScreenStep1:
            self.sessionManager = [[SessionManager alloc] initWithUser:self.user];
            nextScreen = [[GameStep2ViewController alloc] initWithSessionManager:self.sessionManager];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedCode:) name:@"RECEIVED_CODE" object:nil];

            self.currentScreen = GameScreenStep2;
            break;
                        
        default:
            break;
    }
    
    if (nextScreen) {
        [KGStatusBar dismiss];
        [self pushViewController:nextScreen animated:YES];
    }
    
}

- (void)receivedCode:(NSNotification *)notification
{
    if (!self.sharedCode) {
        [self createIngredientsAndUsers];
        self.sharedCode = [NSString stringWithFormat:@"%@-%@", [notification.userInfo objectForKey:@"code"], self.user.id];
        [self showResultWithIngredients:self.ingredients users:self.users andSharedCode:self.sharedCode];
    }
}

- (void)postBurgerToServer
{
    [KGStatusBar showWithStatus: @"Saving your burger"];
    NSMutableString *JSONObject = [[NSMutableString alloc] initWithString:@"{\"ingredients\":["];
    for (NSString *peerID in self.sessionManager.connectedPeers) {
        User *user = [self.sessionManager userForPeerID:peerID];
        NSString *object = [NSString stringWithFormat:@"{\"user_id\": \"%@\", \"ingredient_id\": \"%@\"}, ", user.id, user.ingredient.id];
        [JSONObject appendString:object];
    }
    [JSONObject deleteCharactersInRange:NSMakeRange([JSONObject length]-2, 2)];
    [JSONObject appendString:@"]}"];        
        
    NSURL *url = [NSURL URLWithString:@"http://student.howest.be/thomas.degry/20122013/MAIV/FOOD/api"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            JSONObject, @"ingredients",
                            nil];
    
    [httpClient postPath:@"burgers" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"Request Successful, response '%@'", responseStr);
        self.sharedCode = [NSString stringWithFormat:@"%@-%@", responseStr, self.user.id];
        
        NSData *packet = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        
        [self.sessionManager.session sendData:packet toPeers:self.sessionManager.connectedPeers withDataMode:GKSendDataReliable error:&error];
        
        [KGStatusBar dismiss];
        [self createIngredientsAndUsers];
        [self showResultWithIngredients:self.ingredients users:self.users andSharedCode:self.sharedCode];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
    }];
    
}

- (void)showResultWithIngredients:(NSMutableArray *)ingredients users:(NSMutableArray *)users andSharedCode:(NSString *)sharedcode
{
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    self.currentScreen = GameScreenResult;
    //[self pushViewController:[[GameResultViewController alloc] initWithSessionManager:self.sessionManager andSharedCode:self.sharedCode] animated:YES];
    [self pushViewController:[[GameResultViewController alloc] initWithIngredients:ingredients users:users andSharedCode:sharedcode] animated:YES];
}

- (void)createIngredientsAndUsers
{
    self.users = [[NSMutableArray alloc] init];
    for (NSString *peerID in self.sessionManager.connectedPeers) {
        User *user = [self.sessionManager userForPeerID:peerID];
        [self.users addObject:user];
        [self.sessionManager.session disconnectPeerFromAllPeers:peerID];
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ingredients" ofType:@"plist"];
    NSArray *ingredients = [[NSArray alloc] initWithContentsOfFile:path];
    
    self.ingredients = [[NSMutableArray alloc] init];
    for(User *user in self.users) {
        for (NSDictionary *ingredient in ingredients) {
            if([[ingredient objectForKey:@"id"] isEqualToString:user.ingredient.id]) {
                Ingredient *tempIngredient = [[Ingredient alloc] initWithDict:ingredient];
                
                if([[ingredient objectForKey:@"type"] isEqualToString:@"sauce"]) {
                    [self.ingredients insertObject:tempIngredient atIndex:0];
                } else {
                    [self.ingredients addObject:tempIngredient];
                }
            }
        }
    }
}

- (void)showEnjoyYourBurger:(id)sender
{
    self.currentScreen = GameScreenEnjoy;
    [self pushViewController:[[EnjoyViewController alloc] initWithIngredients:self.ingredients] animated:YES];
}

- (NSString *)mrburgerArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"mrburger.archive"];
}

@end
