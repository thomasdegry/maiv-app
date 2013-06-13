#import "GameResultView.h"

@implementation GameResultView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.participants = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 72)];
        self.participants.backgroundColor = [UIColor orange];
        [self addSubview:self.participants];
        
        // Creating a sub view with all peers
        UIView *faces = [[UIView alloc] initWithFrame:CGRectMake(0, 4, [self.users count] * 60, 60)];
        int xPos = 0;
        
        for (User *user in self.users) {            
            NSData *userImageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?width=104&height=104", user.id]]];
            UIImage *userImage = [UIImage imageWithData:userImageData scale:0.5f];
            UIImageView *face = [[UIImageView alloc] initWithImage:userImage];
            
            face.frame = CGRectMake(xPos, 6, 52, 52);
            face.layer.cornerRadius = 26.0f;
            face.layer.masksToBounds = YES;
            face.layer.borderWidth = 4.0f;
            face.layer.borderColor = [UIColor white].CGColor;
            
            [faces addSubview:face];
            
            xPos += 60;
        }
        
        CGRect facesFrame = faces.frame;
        facesFrame.origin.x = self.frame.size.width * .5 - (facesFrame.size.width * .5 - 4);
        faces.frame = facesFrame;
        
        [self addSubview:faces];
        
        UILabel *tempCode = [[UILabel alloc] initWithFontAlternateAndFrame:CGRectMake(20, 80, 280, 60) andSize:FontAlternateSizeGiant andColor:[UIColor blue]];
        tempCode.text = self.sharedCode;
        
        [self addSubview:tempCode];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame sharedCode:(NSString *)code andUsers:(NSMutableArray *)users
{
    self = [self initWithFrame:frame];
    if(self) {
        self.users = [[NSArray alloc] initWithArray:users];
        self.sharedCode = code;
        
        [self buildBurger];
    }
    return self;
}

- (void)buildBurger
{
    
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
        CGImageRef image = [[ZXImage imageWithMatrix:result] cgimage];
        UIImage *code = [[UIImage alloc] initWithCGImage:image];
        UIImageView *codeIV = [[UIImageView alloc] initWithImage:code];
        [self addSubview:codeIV];
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
