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
    NSLog(@"Did update status");
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
            NSLog(@"[GameViewController] Start from clean slate no data found in archive, lauching step 1");
            GameStep1ViewController *startVC = [[GameStep1ViewController alloc] initWithNibName:nil bundle:nil];
            self = [self initWithRootViewController:startVC];
            if (self) {
                self.currentScreen = GameScreenStep1;
            }
        } else {
            NSLog(@"[GameViewController] Start again with existing data");
            
            NSData *burgerData = [[NSUserDefaults standardUserDefaults] objectForKey:@"burger"];
            Burger *burger = [Burger burgerFromNSData:burgerData];
            self.burger = burger;
            
            self.sharedCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"QRCode"];
            NSLog(@"[GameViewController] Code uit de userdefaults: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"QRCode"]);
            
//            [self createIngredientsAndUsers];
            
            [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
            GameResultViewController *vc = [[GameResultViewController alloc] initWithBurger:self.burger andSharedCode:self.sharedCode];
            self = [self initWithRootViewController:vc];
            self.currentScreen = GameScreenResult;
        }

    }
    
    return self;
}

- (void)closeButtonClicked:(CloseButton *)closeButton
{
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    
    [self terminateSession];
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
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedBurger:) name:@"RECEIVED_BURGER" object:nil];

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

- (void)receivedBurger:(NSNotification *)notification
{
    if (!self.sharedCode) {
        self.burger = [Burger burgerFromNSData:[notification.userInfo objectForKey:@"burger"]];
        
        [self terminateSession];
        self.sharedCode = [NSString stringWithFormat:@"%@-%@", self.burger.id, self.user.id];
        [self showResult];
    }
}

- (void)postBurgerToServer
{
    [KGStatusBar showWithStatus: @"Saving your burger"];
    
    NSMutableString *JSONObject = [[NSMutableString alloc] initWithString:@"{\"ingredients\":["];
    for (NSString *peerID in self.sessionManager.connectedPeers) {
        User *user = [self.sessionManager userForPeer:peerID];
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
        
        self.burger = [[Burger alloc] init];
        self.burger.id = responseStr;
        for (NSString *peerID in self.sessionManager.connectedPeers) {
            User *user = [self.sessionManager userForPeer:peerID];
            [self.burger addIngredient:user.ingredient.id];
            [self.burger addUser:user.id];
        }
        
        NSData *burgerData = [self.burger burgerToNSData];
        
        self.sharedCode = [NSString stringWithFormat:@"%@-%@", responseStr, self.user.id];
        
//        NSData *packet = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
//        NSError *error = nil;
        
//        [self.sessionManager sendBurger:responseStr];
        
//        NSMutableArray *receivers = self.sessionManager.connectedPeers;
//        [receivers removeObject:self.sessionManager.session.peerID];
        
        [self.sessionManager sendPacket:burgerData ofType:PacketTypeBurger toPeers:self.sessionManager.connectedPeers];
//        [self.sessionManager.session sendData:packet toPeers:self.sessionManager.connectedPeers withDataMode:GKSendDataReliable error:&error];
        
        [KGStatusBar dismiss];
        
//        [self createIngredientsAndUsers];

        //[self showResultWithIngredients:self.ingredients users:self.users burgerData:burgerData andSharedCode:self.sharedCode];
        //[self showResultWithIngredients:self.ingredients users:self.ingredients andSharedCode:self.sharedCode];
        [self showResult];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
    }];
    
}

- (void)showResult
{
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    self.currentScreen = GameScreenResult;

    [self terminateSession];
    GameResultViewController *vc = [[GameResultViewController alloc] initWithBurger:self.burger andSharedCode:self.sharedCode];
    [self pushViewController:vc animated:YES];
}
//
//- (void)showResultWithIngredients:(NSMutableArray *)ingredients users:(NSMutableArray *)users andSharedCode:(NSString *)sharedcode
//{
//    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
//    self.currentScreen = GameScreenResult;
//    [self pushViewController:[[GameResultViewController alloc] initWithIngredients:self.ingredients users:self.users andSharedCode:self.sharedCode] animated:YES];
//}

- (void)createIngredientsAndUsers
{
    NSLog(@"[GameViewController] Generating ingredients and users from burger");
    
    // All user ids
    self.users = [NSMutableArray array];
    
    for (NSString *userID in self.burger.users) {
        User *temp = [[User alloc] init];
        temp.id = userID;
        [self.users addObject:temp];
    }
    
    // All ingredient ids
    NSMutableArray *ingredients = self.burger.ingredients;
        
    // Load ingredients
    NSArray *allIngredients = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ingredients" ofType:@"plist"]];
    
    self.ingredients = [NSMutableArray array];
    
    for (Ingredient *ingredientID in ingredients) {
        for (NSDictionary *ingredient in allIngredients) {
            if ([[ingredient objectForKey:@"id"] isEqualToString:ingredientID.id]) {
                Ingredient *temp = [[Ingredient alloc] initWithDict:ingredient];
                                
                if ([temp.type isEqualToString:@"sauce"]) {
                    [self.ingredients insertObject:temp atIndex:0];
                } else {
                    [self.ingredients addObject:temp];
                }
            }
        }
    }
}

- (void)showEnjoyYourBurger:(id)sender
{
    self.currentScreen = GameScreenEnjoy;
    [self pushViewController:[[EnjoyViewController alloc] initWithBurger:self.burger] animated:YES];
}

- (void)terminateSession
{
    if (self.sessionManager) {
        [self.sessionManager teardownSession];
        [self.sessionManager.connectedPeers removeAllObjects];
        [self.sessionManager.availablePeers removeAllObjects];
        self.sessionManager = nil;
    }
}

@end
