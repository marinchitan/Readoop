//
//  RegisterViewController.m
//  Readoop
//
//  Created by Marin Chitan on 04/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "RegisterViewController.h"
#import "Color.h"
#import "Navigation.h"
#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <EHPlainAlert/EHPlainAlert.h>
#import <SCLAlertView-Objective-C/SCLAlertView.h>
#import "AlertUtils.h"
#import "AppLabels.h"
#import "NSString+FontAwesome.h"
#import "Session.h"
#import "UserDefaultsManager.h"
#import "User.h"
#import <Realm/Realm.h>
#import "RealmUtils.h"
#import "IonIcons.h"


@interface RegisterViewController ()
@property (assign, nonatomic) CGFloat initialCornerRadius;

@property (assign, nonatomic) FieldState userState;
@property (assign, nonatomic) FieldState passwState;
@property (assign, nonatomic) FieldState confpasswState;
@property (assign, nonatomic) FieldState nameState;
@property (assign, nonatomic) FieldState emailState;

@property (strong, nonatomic) NSString *validIcon;
@property (strong, nonatomic) NSString *invalidIcon;

@property (nonatomic, strong) Session* appSession;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.initialCornerRadius = 5.0;
    [self setUpUI];
    [self setUpRegisterPanel];
    [self setUpSignals];
    self.appSession = [Session sharedSession];
}

- (void)viewWillAppear:(BOOL)animated {
    [Navigation hideNavBar:[self navigationController]];
}

- (void)placeHolders{

}

- (void)setUpUI {
    [Navigation showStatusBar];
    [Navigation makeStatusBarLightStyle];
    [Navigation hideNavBar:[self navigationController]];
    [Navigation paintStatusBarWithColor:[Color getMainRed]];
    self.view.backgroundColor = [Color getMainRed];
}

- (void)setUpRegisterPanel {
    self.registerPanel.layer.cornerRadius = 30;
    self.registerPanel.layer.masksToBounds = YES;
    self.registerPanel.backgroundColor = [[Color getWhite] colorWithAlphaComponent:1];
    
    self.usernameField.layer.cornerRadius = self.initialCornerRadius;
    self.passwordFied.layer.cornerRadius = self.initialCornerRadius;
    self.confirmpasswordField.layer.cornerRadius = self.initialCornerRadius;
    self.fullnameField.layer.cornerRadius = self.initialCornerRadius;
    self.emailField.layer.cornerRadius = self.initialCornerRadius;
    self.doneButton.layer.cornerRadius = self.initialCornerRadius;
    self.cancelButton.layer.cornerRadius = self.initialCornerRadius;
    
    self.usernameField.layer.borderColor = [[Color getTextFieldBorderGray] CGColor];
    self.passwordFied.layer.borderColor = [[Color getTextFieldBorderGray] CGColor];
    self.confirmpasswordField.layer.borderColor = [[Color getTextFieldBorderGray] CGColor];
    self.fullnameField.layer.borderColor = [[Color getTextFieldBorderGray] CGColor];
    self.emailField.layer.borderColor = [[Color getTextFieldBorderGray] CGColor];
    
    self.usernameField.layer.masksToBounds = YES;
    self.passwordFied.layer.masksToBounds = YES;
    self.confirmpasswordField.layer.masksToBounds = YES;;
    self.fullnameField.layer.masksToBounds = YES;
    self.emailField.layer.masksToBounds = YES;
    
    self.usernameField.layer.borderWidth = 1.0f;
    self.passwordFied.layer.borderWidth = 1.0f;
    self.confirmpasswordField.layer.borderWidth = 1.0f;
    self.fullnameField.layer.borderWidth = 1.0f;
    self.emailField.layer.borderWidth = 1.0f;
    
    self.doneButton.backgroundColor = [Color getPassiveBariolRed];
    self.doneButton.enabled = NO;
    [self.doneButton setTitleColor:[Color getMainPassiveGray] forState:UIControlStateDisabled];
    self.cancelButton.backgroundColor = [Color getMainPassiveGray];
    
    self.usernameLabel.hidden = YES;
    self.passwordLabel.hidden = YES;
    self.confirmpasswordLabel.hidden = YES;
    self.fullnameLabel.hidden = YES;
    self.emailLabel.hidden = YES;
    
    self.usernameValidText.font = [UIFont fontWithName:kFontAwesomeFamilyName size:20];
    self.passwordValidText.font = [UIFont fontWithName:kFontAwesomeFamilyName size:20];
    self.confirmpasswValidText.font = [UIFont fontWithName:kFontAwesomeFamilyName size:20];
    self.nameValidText.font = [UIFont fontWithName:kFontAwesomeFamilyName size:20];
    self.emailValidText.font = [UIFont fontWithName:kFontAwesomeFamilyName size:20];
    
    self.validIcon = [NSString fontAwesomeIconStringForEnum:FACheck];
    self.invalidIcon = [NSString fontAwesomeIconStringForEnum:FATimes];
}

- (void)setUpSignals {
    //Text signals
    RACSignal *usernameTextSignal = [self.usernameField rac_textSignal];
    RACSignal *passwordTextSignal = [self.passwordFied rac_textSignal];
    RACSignal *confirmpasswordTextSignal = [self.confirmpasswordField rac_textSignal];
    RACSignal *fullnameTextSignal = [self.fullnameField rac_textSignal];
    RACSignal *emailTextSignal = [self.emailField rac_textSignal];
    
    //Text legnth signals for enabling the done button
    RACSignal *userNameSignal = [usernameTextSignal map:^id _Nullable(NSString * _Nullable value) {
        BOOL usernameContainsText = value.length > 0;
        return @(usernameContainsText);
    }];
    RACSignal *passwordSignal = [passwordTextSignal map:^id _Nullable(NSString * _Nullable value) {
        BOOL passwordContainsText = value.length > 0;
        return @(passwordContainsText);
    }];
    RACSignal *conifrmpasswordSignal = [confirmpasswordTextSignal map:^id _Nullable(NSString * _Nullable value) {
        BOOL confirmpasswordContainsText = value.length > 0;
        return @(confirmpasswordContainsText);
    }];
    
    //Signals for floating labels
    RAC(self.usernameLabel, hidden) = [usernameTextSignal map:^id _Nullable(NSString *  _Nullable value) {
        BOOL usernameContainsText = !(value.length > 0);
        return @(usernameContainsText);
    }];
    RAC(self.passwordLabel, hidden) = [passwordTextSignal map:^id _Nullable(NSString *  _Nullable value) {
        BOOL passwordContainsText = !(value.length > 0);
        return @(passwordContainsText);
    }];
    RAC(self.confirmpasswordLabel, hidden) = [confirmpasswordTextSignal map:^id _Nullable(NSString *  _Nullable value) {
        BOOL confirmpassContainsText = !(value.length > 0);
        return @(confirmpassContainsText);
    }];
    RAC(self.fullnameLabel, hidden) = [fullnameTextSignal map:^id _Nullable(NSString *  _Nullable value) {
        BOOL fullnameContainsText = !(value.length > 0);
        return @(fullnameContainsText);
    }];
    RAC(self.emailLabel, hidden) = [emailTextSignal map:^id _Nullable(NSString *  _Nullable value) {
        BOOL emailContainsText = !(value.length > 0);
        return @(emailContainsText);
    }];
    
    //Logic for done button
    RAC(self.doneButton, enabled) = [RACSignal combineLatest:@[userNameSignal, passwordSignal, conifrmpasswordSignal]
                                                        reduce:^id _Nonnull (NSNumber *userNameLength, NSNumber *passwordLength, NSNumber * confirmPasswordLength){
                                                            return @([userNameLength boolValue] && [passwordLength boolValue] && [confirmPasswordLength boolValue]);
                                                        }];
    
    RAC(self.doneButton, backgroundColor) = [RACSignal combineLatest:@[userNameSignal, passwordSignal, conifrmpasswordSignal]
                                                              reduce:^id _Nonnull (NSNumber *userNameLength, NSNumber *passwordLength, NSNumber * confirmPasswordLength){
                                                                  return [userNameLength boolValue] && [passwordLength boolValue] && [confirmPasswordLength boolValue] ? [Color getBariolRed] :
                                                                  [Color getPassiveBariolRed];
                                                              }];
    
    //Signals for suggestion labels
    RAC(self.usernameValidText, text) = [usernameTextSignal map:^id _Nullable(NSString *  _Nullable value) {
        if(value.length == 0 ){
            return @"";
        } else {
            return [self validateUsernameLength] && [self validateUsernameSpaces] && [self validateUsernameUnique] ? self.validIcon : self.invalidIcon;
        }
    }];
    RAC(self.passwordValidText, text) = [passwordTextSignal map:^id _Nullable(NSString *  _Nullable value) {
        if(value.length == 0 ){
            return @"";
        } else {
            return [self validatePasswordLength] && [self validatePasswordSpaces] ? self.validIcon : self.invalidIcon;
        }
    }];
    RAC(self.confirmpasswValidText, text) = [confirmpasswordTextSignal map:^id _Nullable(NSString *  _Nullable value) {
        if(value.length == 0 ){
            return @"";
        } else {
            return [self validateConfirmpassword] ? self.validIcon : self.invalidIcon;
        }
    }];
    RAC(self.nameValidText, text) = [fullnameTextSignal map:^id _Nullable(NSString *  _Nullable value) {
        if(value.length == 0 ){
            return @"";
        } else {
            return [self validateName] ? self.validIcon : self.invalidIcon;
        }
    }];
    RAC(self.emailValidText, text) = [emailTextSignal map:^id _Nullable(NSString *  _Nullable value) {
        if(value.length == 0 ){
            return @"";
        } else {
            return [self validateEmail] ? self.validIcon : self.invalidIcon;
        }
    }];
    
    //Field states logic handling
    
    RAC(self, userState) = [usernameTextSignal map:^id _Nullable(NSString *  _Nullable value) {
        if(value.length == 0 ){
            return @(empty_field);
        } else {
            return [self validateUsernameLength] && [self validateUsernameSpaces] && [self validateUsernameUnique] ? @(valid_field) : @(invalid_field);
        }
    }];
    RAC(self, passwState) = [passwordTextSignal map:^id _Nullable(NSString *  _Nullable value) {
        if(value.length == 0 ){
            return @(empty_field);
        } else {
            return [self validatePasswordLength] && [self validatePasswordSpaces] ? @(valid_field) : @(invalid_field);
        }
    }];
    RAC(self, confpasswState) = [confirmpasswordTextSignal map:^id _Nullable(NSString *  _Nullable value) {
        if(value.length == 0 ){
            return @(empty_field);
        } else {
            return [self validateConfirmpassword] ? @(valid_field) : @(invalid_field);
        }
    }];
    RAC(self, nameState) = [fullnameTextSignal map:^id _Nullable(NSString *  _Nullable value) {
        if(value.length == 0 ){
            return @(empty_field);
        } else {
            return [self validateName] ? @(valid_field) : @(invalid_field);
        }
    }];
    RAC(self, emailState) = [emailTextSignal map:^id _Nullable(NSString *  _Nullable value) {
        if(value.length == 0 ){
            return @(empty_field);
        } else {
            return [self validateEmail] ? @(valid_field) : @(invalid_field);
        }
    }];
}

- (BOOL)validateUsernameLength {
    return self.usernameField.text.length >= 4;
}

- (BOOL)validateUsernameSpaces {
    NSRange whiteSpaceRange = [self.usernameField.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    return whiteSpaceRange.location == NSNotFound ? YES : NO;
}

- (BOOL)validateUsernameUnique {
    User *retrievedUser = [[User objectsWhere:@"username == %@",self.usernameField.text] firstObject];
    if(retrievedUser){
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)validatePasswordLength {
    return self.passwordFied.text.length >= 6;
}

- (BOOL)validatePasswordSpaces {
    NSRange whiteSpaceRange = [self.passwordFied.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    return whiteSpaceRange.location == NSNotFound ? YES : NO;
}

- (BOOL)validateConfirmpassword {
    return [self.confirmpasswordField.text isEqualToString:self.passwordFied.text] ? YES : NO;
}

- (BOOL)validateName {
    return [self.fullnameField.text rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location == NSNotFound;
}

- (BOOL)validateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self.emailField.text];
}

- (IBAction)done:(id)sender {
    NSMutableString *errorString = [NSMutableString new];
    if(![self validateUsernameLength]) {
        [errorString appendString:[AppLabels getLengthError:@"Username" withExcepectedLength:@"4"]];
        [errorString appendString:@"\n\n"];
    }
    
    if(![self validatePasswordLength]) {
        [errorString appendString:[AppLabels getLengthError:@"Password" withExcepectedLength:@"6"]];
        [errorString appendString:@"\n\n"];
    }
    
    if(![self validateUsernameLength]) {
        [errorString appendString:[AppLabels getLengthError:@"Username" withExcepectedLength:@"4"]];
        [errorString appendString:@"\n\n"];
    }
    
    if(![self validateUsernameUnique]) {
        [errorString appendString:[AppLabels getUniqueUsernameError]];
        [errorString appendString:@"\n\n"];
    }
    
    if(![self validatePasswordSpaces]) {
        [errorString appendString:[AppLabels getSpaceError:@"Password"]];
        [errorString appendString:@"\n\n"];
    }
    
    if(![self validateConfirmpassword]) {
        [errorString appendString:[AppLabels getDifferentPasswordsError]];
        [errorString appendString:@"\n\n"];
    }
    
    if(![self validateEmail] && self.emailField.text.length > 0) {
        [errorString appendString:[AppLabels getEmailError]];
        [errorString appendString:@"\n\n"];
    }
    
    if(![self validateName] && self.fullnameField.text.length > 0) {
        [errorString appendString:[AppLabels getNameError]];
        [errorString appendString:@"\n\n"];
    }
    
    __weak RegisterViewController *weakSelf = self;
    if([errorString isEqualToString:@""]){
        //create new user and add it to realm
        User *newUser = [[User alloc] init];
        RLMResults<User *> *currentUsers = [User allObjects];
        NSNumber *primaryKey = [NSNumber numberWithInt:5001 + (int)currentUsers.count];
        NSLog(@"Current user primaryKey: %@", primaryKey);
        newUser.userId = primaryKey;
        newUser.username = self.usernameField.text;
        newUser.password = self.passwordFied.text;
        
        if([self.fullnameField.text isEqualToString:@""] && [self.emailField.text isEqualToString:@""]) {
            //No email and name supplied
        } else if([self.fullnameField.text isEqualToString:@""]){
            newUser.email = self.emailField.text;
        } else if([self.emailField.text isEqualToString:@""]){
            newUser.fullName = self.fullnameField.text;
        } else {
            newUser.email = self.emailField.text;
            newUser.fullName = self.fullnameField.text;
        }
        
        //MONGOPUT
        [RealmUtils addUserObject:newUser];
        self.appSession.currentUser = newUser;
        
        //if succesessfully registered save credentials to cache, so next time will be seamless logged
        [UserDefaultsManager saveCredentialsUsername:self.usernameField.text password:self.passwordFied.text];
        self.appSession.wayOfArrival = register_path;
        [self.navigationController pushViewController:[ViewController getTabbedDashboard] animated:YES];
    } else {
        [AlertUtils showAlertModal:errorString withTitle:@"Wrong data supplied" withCancelButton:@"Got it!" onVC:weakSelf];
    }
}

- (IBAction)cancel:(id)sender {
    __weak RegisterViewController *weakSelf = self;
    //[self.navigationController popViewControllerAnimated:YES];
    [AlertUtils showInformation:@"All the supplied data will be lost, do you want to continue?"
                      withTitle:@"Cancel"
               withActionButton:@"Yes"
               withCancelButton:@"No"
                     withAction:^{[self.navigationController popViewControllerAnimated:YES];}
                           onVC:weakSelf];
}

- (IBAction)usernameSugest:(id)sender {
    __weak RegisterViewController *weakSelf = self;
    if(self.userState == valid_field) {
        [AlertUtils showSuccess:@"Your input is eligible" withTitle:@"Correct!" withCancelButton:@"Got it" onVC:weakSelf];
    } else if(self.userState == invalid_field) {
        NSMutableString *errorString = [NSMutableString new];
        
        if(![self validateUsernameUnique]) {
            [errorString appendString:[AppLabels getUniqueUsernameError]];
            [errorString appendString:@"\n\n"];
        }
        if(![self validateUsernameLength]) {
            [errorString appendString:[AppLabels getLengthError:@"Username" withExcepectedLength:@"4"]];
            [errorString appendString:@"\n"];
        }
        if(![self validateUsernameSpaces]) {
            [errorString appendString:[AppLabels getSpaceError:@"Username"]];
        }
        
        [AlertUtils showAlertModal:errorString withTitle:@"Wrong data supplied!" withCancelButton:@"Got it" onVC:weakSelf];
        
    }
}

- (IBAction)passwordSugest:(id)sender {
    __weak RegisterViewController *weakSelf = self;
    if(self.passwState == valid_field) {
        [AlertUtils showSuccess:@"Your input is eligible" withTitle:@"Correct!" withCancelButton:@"Got it" onVC:weakSelf];
    } else if(self.passwState == invalid_field) {
        NSMutableString *errorString = [NSMutableString new];
        if(![self validatePasswordLength]) {
            [errorString appendString:[AppLabels getLengthError:@"Password" withExcepectedLength:@"6"]];
            [errorString appendString:@"\n"];
        }
        if(![self validatePasswordSpaces]) {
            [errorString appendString:[AppLabels getSpaceError:@"Password"]];
        }
        [AlertUtils showAlertModal:errorString withTitle:@"Wrong data supplied!" withCancelButton:@"Got it" onVC:weakSelf];
        
    }
}

- (IBAction)confirmpasswSugest:(id)sender {
    __weak RegisterViewController *weakSelf = self;
    if(self.confpasswState == valid_field) {
        [AlertUtils showSuccess:@"Your input is eligible" withTitle:@"Correct!" withCancelButton:@"Got it" onVC:weakSelf];
    } else if(self.confpasswState == invalid_field) {
        NSMutableString *errorString = [NSMutableString new];
        if(![self validateConfirmpassword]) {
            [errorString appendString:[AppLabels getDifferentPasswordsError]];
        }
        [AlertUtils showAlertModal:errorString withTitle:@"Wrong data supplied!" withCancelButton:@"Got it" onVC:weakSelf];
    }
}

- (IBAction)nameSugest:(id)sender {
    __weak RegisterViewController *weakSelf = self;
    if(self.nameState == valid_field) {
        [AlertUtils showSuccess:@"Your input is eligible" withTitle:@"Correct!" withCancelButton:@"Got it" onVC:weakSelf];
    } else if(self.nameState == invalid_field) {
        NSMutableString *errorString = [NSMutableString new];
        if(![self validateName]) {
            [errorString appendString:[AppLabels getNameError]];
        }
        [AlertUtils showAlertModal:errorString withTitle:@"Wrong data supplied!" withCancelButton:@"Got it" onVC:weakSelf];
    }
}

- (IBAction)emailSugest:(id)sender {
    __weak RegisterViewController *weakSelf = self;
    if(self.emailState == valid_field) {
        [AlertUtils showSuccess:@"Your input is eligible" withTitle:@"Correct!" withCancelButton:@"Got it" onVC:weakSelf];
    } else if(self.emailState == invalid_field) {
        NSMutableString *errorString = [NSMutableString new];
        if(![self validateEmail]) {
            [errorString appendString:[AppLabels getEmailError]];
        }
        [AlertUtils showAlertModal:errorString withTitle:@"Wrong data supplied!" withCancelButton:@"Got it" onVC:weakSelf];
    }
}


@end
