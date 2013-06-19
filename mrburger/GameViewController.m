#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

@synthesize user = _user;
@synthesize currentScreen = _currentScreen;
@synthesize sharedCode = _sharedCode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {        
        CBCentralManager *bluetoothManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        bluetoothManager = nil;
        
        self.navigationBarHidden = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showEnjoyYourBurger:) name:@"SHOW_ENJOY" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self.sessionManager selector:@selector(destroySession) name:@"DESTROY_SESSION" object:nil];
    }
    return self;
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    central = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (id)initGame
{
    UIViewController *rootViewController;
    GameScreen currentScreen;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"facebook_id"] == nil) {

        //User is not logged in with facebook yet
        rootViewController = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
        currentScreen = GameScreenLogin;

    } else {
        
        //User is logged in with facebook
        self.user = [[User alloc] init];
        self.user.id = [[NSUserDefaults standardUserDefaults] objectForKey:@"facebook_id"];
        self.user.name = [[NSUserDefaults standardUserDefaults] objectForKey:@"facebook_name"];
        self.user.gender = [[NSUserDefaults standardUserDefaults] objectForKey:@"facebook_gender"];
        self.user.deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
        self.user.ingredient = [[Ingredient alloc] init];
        
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"QRCode"]) {
            
            // User doesn't have a saved burger
            rootViewController = [[GameStep1ViewController alloc] initWithUser:self.user];
            currentScreen = GameScreenStep1;
            
        } else {
            
            NSData *burgerData = [[NSUserDefaults standardUserDefaults] objectForKey:@"burger"];
            Burger *burger = [Burger burgerFromNSData:burgerData];
            self.burger = burger;
            
            self.sharedCode = [[NSUserDefaults standardUserDefaults] objectForKey:@"QRCode"];
                        
            [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
            
            rootViewController = [[GameResultViewController alloc] initWithBurger:self.burger andSharedCode:self.sharedCode];
            currentScreen = GameScreenResult;
        }

    }
    
    self = [self initWithRootViewController:rootViewController];

    if (self) {
        self.currentScreen = currentScreen;
    }

    return self;
}

- (void)closeButtonClicked:(CloseButton *)closeButton
{
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    [KGStatusBar dismiss];
    
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
            nextScreen = [[GameStep1ViewController alloc] initWithUser:self.user];
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
        
    NSURL *url = [NSURL URLWithString:kAPI];
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
        
        [self.sessionManager sendPacket:burgerData ofType:PacketTypeBurger toPeers:self.sessionManager.connectedPeers];
        
        [KGStatusBar dismiss];

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

- (void)showEnjoyYourBurger:(id)sender
{
    self.currentScreen = GameScreenEnjoy;
    [self pushViewController:[[EnjoyViewController alloc] initWithBurger:self.burger] animated:YES];
}

- (void)terminateSession
{
    if (self.sessionManager) {
        [self.sessionManager stopSearching];
        [self.sessionManager teardownSession];
        [self.sessionManager.connectedPeers removeAllObjects];
        [self.sessionManager.availablePeers removeAllObjects];
        self.sessionManager = nil;
    }
}

@end
