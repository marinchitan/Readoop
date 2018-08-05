//
//  EHPlainAlert.m
//  HMTest
//
//  Created by Danila Gusev on 09/10/15.
//  Copyright © 2015 josshad. All rights reserved.
//

#import "EHPlainAlert.h"
#import "UIColor+HexRGB.h"

#define EHDEFAULT_TITLE_FONT [UIFont fontWithName:@"HelveticaNeue-Light" size:15]
#define EHDEFAULT_SUBTITLE_FONT [UIFont fontWithName:@"HelveticaNeue-Light" size:12]
#define EHDEFAULT_MAX_ALERTS_NUMBER 3
#define EHDEFAULT_HIDING_DELAY 4
#define EHPOSITIONFORALERT(i) (_EHAlertPosition == ViewAlertPositionBottom)?screenSize.height - 70 * (i + 1) - 0.5 * (i):70 * (i) + 0.5 * (i)

static NSInteger _EHNumberOfVisibleAlerts = EHDEFAULT_MAX_ALERTS_NUMBER;
static ViewAlertPosition _EHAlertPosition = ViewAlertPositionBottom;
static float _EHHidingDelay = EHDEFAULT_HIDING_DELAY;
static UIFont * _EHTitleFont = nil;
static UIFont * _EHSubTitleFont = nil;

static BOOL _EHShouldHideOnTap = YES;
static BOOL _EHShouldShowCloseIcon = YES;

static NSMutableDictionary * _EHColorsDictionary = nil;
static NSMutableDictionary * _EHIconsDictionary = nil;

float EH_iOS_Version() {
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

@interface NSBundle (ios7Bundle)

@end

@implementation NSBundle (ios7Bundle)

+ (instancetype)ios7Bundle{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSURL *bundleUrl = [mainBundle URLForResource:@"EHPlainAlert" withExtension:@"EHPlainAlert"];
    NSBundle *bundle = [NSBundle bundleWithURL:bundleUrl];
    return bundle;
}

+ (UIImage*)imageNamed:(NSString*)name{
    UIImage *image;
    
    image = [UIImage imageNamed:[NSString stringWithFormat:@"EHPlainAlert.bundle/%@",name]];
    if (image) {
        return image;
    }
    
    image = [UIImage imageWithContentsOfFile:[[[NSBundle ios7Bundle] resourcePath] stringByAppendingPathComponent:name]];
    
    return image;
}
@end

@implementation EHPlainAlert
{
    CGSize screenSize;
    ViewAlertType _alertType;
    BOOL _iconSetted;
}

static NSMutableArray * currentAlertArray = nil;

+ (instancetype)showError:(NSError *)error
{
    return [self showAlertWithTitle:@"Error" message:error.localizedDescription type:ViewAlertError];
}


+ (instancetype)showDomainError:(NSError *)error
{
    return [self showAlertWithTitle:error.domain message:error.localizedDescription type:ViewAlertError];
}


+ (instancetype)showAlertWithTitle:(NSString *)title message:(NSString *)message type:(ViewAlertType)type
{
    EHPlainAlert * alert = [[EHPlainAlert alloc] initWithTitle:title message:message type:type];
    [alert show];
    return alert;
}

+(void)hideAll:(BOOL)animated
{
    for (EHPlainAlert * alert in currentAlertArray)
    {
        [alert hide:@(animated)];
    }
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message type:(ViewAlertType)type;
{
    self = [super init];
    if (self)
    {
        self.titleString = title;
        self.subtitleString = message;
        _shouldShowCloseIcon = -1;
        _shouldHideOnTap = -1;
        if (!currentAlertArray)
        {
            currentAlertArray = [NSMutableArray new];
        }
        [EHPlainAlert  updateColorsDictionary];
        [EHPlainAlert  updateIconsDictionary];
        _alertType = type;
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self)
    {
        if (!currentAlertArray)
        {
            currentAlertArray = [NSMutableArray new];
        }
        [EHPlainAlert updateColorsDictionary];
        [EHPlainAlert  updateIconsDictionary];
    }
    return self;
}

+ (void)updateColorsDictionary
{
    if (!_EHColorsDictionary)
    {
        _EHColorsDictionary = [@{ @(ViewAlertError) : [UIColor colorWithHex:@"#FDB937"],
                                  @(ViewAlertSuccess) : [UIColor colorWithHex:@"#49BB7B"],
                                  @(ViewAlertInfo) :  [UIColor colorWithHex:@"#00B2F4"],
                                  @(ViewAlertPanic) :[UIColor colorWithHex:@"#f24841"]
                                  } mutableCopy];
    }
}

+ (void)updateIconsDictionary
{
    if (!_EHIconsDictionary)
    {
        _EHIconsDictionary = [@{ @(ViewAlertError) : [EHPlainAlert imageNamed:@"eh_alert_error_icon"],
                                  @(ViewAlertSuccess) : [EHPlainAlert imageNamed:@"eh_alert_complete_icon"],
                                  @(ViewAlertInfo) :  [EHPlainAlert imageNamed:@"eh_alert_info_icon"],
                                  @(ViewAlertPanic) :[EHPlainAlert imageNamed:@"eh_alert_error_icon"]
                                  } mutableCopy];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!_EHTitleFont)
    {
        _EHTitleFont = EHDEFAULT_TITLE_FONT;
    }
    if (!_EHSubTitleFont)
    {
        _EHSubTitleFont = EHDEFAULT_SUBTITLE_FONT;
    }
    
    self.view.backgroundColor = [UIColor clearColor];
    
    screenSize = [UIScreen mainScreen].bounds.size;
    self.view.frame = CGRectMake(0, (_EHAlertPosition)?-70:screenSize.height, screenSize.width , 70);
    self.view.layer.masksToBounds = NO;
    
    [self constructAlert];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)constructAlert
{
    UIView * infoView = [UIView new];
    infoView.frame = CGRectMake(0, 0, self.view.bounds.size.width , 70);
    
    
    [self.view addSubview:infoView];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, infoView.frame.size.width - 70, infoView.frame.size.height)];
    
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.numberOfLines = 0;
    [infoView addSubview:titleLabel];
    
    NSMutableAttributedString * titleString = [[NSMutableAttributedString alloc] initWithString:_titleString ? _titleString : @""
                                                                                     attributes:@{NSFontAttributeName : _titleFont ? _titleFont : _EHTitleFont}];
    
    NSAttributedString * messageString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@",_subtitleString ? _subtitleString : @""]
                                                                         attributes:@{NSFontAttributeName : _subTitleFont ? _subTitleFont : _EHSubTitleFont}];
    
    [titleString appendAttributedString:messageString];
    
    titleLabel.attributedText = titleString;
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 70)];
    UIColor * bgColor = [_EHColorsDictionary objectForKey:@(_alertType)];
    if (!_iconSetted)
        _iconImage = [_EHIconsDictionary objectForKey:@(_alertType)];
 
    if (!bgColor)
    {
        bgColor = [UIColor colorWithHex:@"#FDB937"];
    }
 
    
    infoView.backgroundColor = _messageColor ? _messageColor : bgColor;
    imageView.image = _iconImage;   
    imageView.contentMode = UIViewContentModeCenter;
    [infoView addSubview:imageView];
    
    
    if (_shouldShowCloseIcon == 1 || (_EHShouldShowCloseIcon && _shouldShowCloseIcon == -1))
    {
        UIImageView * closeView = [[UIImageView alloc] initWithImage:[EHPlainAlert imageNamed:@"eh_alert_close_icon"]];
        closeView.frame = CGRectMake(infoView.bounds.size.width - 15, 8, 7, 7);
        closeView.contentMode = UIViewContentModeCenter;
        
        closeView.userInteractionEnabled = YES;
        [infoView addSubview:closeView];
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onCloseTap:)];
        [closeView addGestureRecognizer:tapGesture];
    }
    
    
    
    
}

+ (UIImage *)imageNamed:(NSString *)name
{
    if (EH_iOS_Version() < 8)
    {
        return [NSBundle imageNamed:name];
    }
    else
    {
        NSBundle * pbundle = [NSBundle bundleForClass:[self class]];
        NSString *bundleURL = [pbundle pathForResource:@"EHPlainAlert" ofType:@"bundle"];
        NSBundle *imagesBundle = [NSBundle bundleWithPath:bundleURL];
        UIImage * image = [UIImage imageNamed:name inBundle:imagesBundle compatibleWithTraitCollection:nil];
        return image;
    }
}

- (void)show
{
    [self performSelectorOnMainThread:@selector(showInMain) withObject:nil waitUntilDone:NO];
}

- (void)showInMain
{
    @synchronized (currentAlertArray) {
    
        if ([currentAlertArray count] == _EHNumberOfVisibleAlerts)
        {
            [[currentAlertArray firstObject] hide:@(YES)];
        }
        
        NSInteger numberOfAlerts = [currentAlertArray count];
        if (numberOfAlerts == 0)
            [([UIApplication sharedApplication].delegate).window addSubview:self.view];
        else
            [([UIApplication sharedApplication].delegate).window insertSubview:self.view belowSubview:[((EHPlainAlert *)[currentAlertArray lastObject]) view]];
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = CGRectMake(0, EHPOSITIONFORALERT(numberOfAlerts), screenSize.width, 70);
        }];
        
        [currentAlertArray addObject:self];
        
        [self performSelector:@selector(hide:) withObject:@(YES) afterDelay:_EHHidingDelay];
        
    }
}

- (void)hide:(NSNumber *)nAnimated
{
    [self performSelectorOnMainThread:@selector(hideInMain:) withObject:nAnimated waitUntilDone:NO];
}

- (void)hideInMain:(NSNumber *)nAnimated
{
    @synchronized (currentAlertArray) {
        [currentAlertArray removeObject:self];
        BOOL animated = [nAnimated boolValue];
        if (animated)
        {
            [UIView animateWithDuration:0.5 animations:^{
                self.view.alpha = 0.7;
                self.view.frame = CGRectMake(0, (_EHAlertPosition)?-70:screenSize.height, screenSize.width , 70);
            } completion:^(BOOL finished) {
                [self.view removeFromSuperview];
            }];
            
            for (int i = 0; i < [currentAlertArray count]; i++)
            {
                EHPlainAlert * alert = [currentAlertArray objectAtIndex:i];
                [UIView animateWithDuration:0.5 animations:^{
                    alert.view.frame = CGRectMake(0, EHPOSITIONFORALERT(i), screenSize.width, 70);
                }];
            }
        }
        else
        {
            [self.view removeFromSuperview];
            for (int i = 0; i < [currentAlertArray count]; i++)
            {
                EHPlainAlert * alert = [currentAlertArray objectAtIndex:i];
                alert.view.frame = CGRectMake(0, EHPOSITIONFORALERT(i), screenSize.width, 70);
            }
        }
    }
}

- (void)hide
{
    [self hide:@(YES)];
}

- (void)onTap
{
    if (_shouldHideOnTap == 1 || (_EHShouldHideOnTap && _shouldShowCloseIcon == -1)) {
        [self hide];
    }
    
    if (_action != nil)
    {
        _action();
    }
}

- (void)onCloseTap:(UIGestureRecognizer *)gesture
{
    [self hide];
}

#pragma mark - Setters
- (void)setIconImage:(UIImage *)iconImage
{
    _iconImage = iconImage;
    _iconSetted = YES;
}

#pragma mark - Default behaviour

+ (void)updateNumberOfAlerts:(NSInteger)numberOfAlerts
{
    if (numberOfAlerts > 0)
    {
        _EHNumberOfVisibleAlerts = numberOfAlerts;
    }
}

+ (void)updateHidingDelay:(float)delay
{
    if (delay >= 0)
    {
        _EHHidingDelay = delay;
    }
}

+ (void)updateTitleFont:(UIFont *)titleFont
{
    _EHTitleFont = titleFont;
}

+ (void)updateSubTitleFont:(UIFont *)stitleFont
{
    _EHSubTitleFont = stitleFont;
}

+ (void)updateAlertPosition:(ViewAlertPosition)viewPosition
{
    _EHAlertPosition = viewPosition;
}

+ (void)updateAlertColor:(UIColor *)color forType:(ViewAlertType)type
{
    [EHPlainAlert updateColorsDictionary];
    if (color)
    {
        [_EHColorsDictionary setObject:color forKey:@(type)];
    }
    else
    {
        [_EHColorsDictionary removeObjectForKey:@(type)];
    }
}


+ (void)updateAlertIcon:(UIImage *)image forType:(ViewAlertType)type
{
    [EHPlainAlert updateIconsDictionary];
    if (image)
    {
        [_EHIconsDictionary setObject:image forKey:@(type)];
    }
    else
    {
        [_EHIconsDictionary removeObjectForKey:@(type)];
    }
}

+ (void)updateShouldHideOnTap:(BOOL)hide
{
    _EHShouldHideOnTap = hide;
}

+ (void)updateShouldShowCloseIcon:(BOOL)show
{
    _EHShouldShowCloseIcon = show;
}
@end
