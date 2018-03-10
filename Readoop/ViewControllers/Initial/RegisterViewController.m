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

@interface RegisterViewController ()
@property (assign, nonatomic) CGFloat initialCornerRadius;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.initialCornerRadius = 5.0;
    [self setUpUI];
    [self setUpRegisterPanel];
    [self setUpSignals];
}

- (void)viewWillAppear:(BOOL)animated {
    [Navigation hideNavBar:[self navigationController]];
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
}

- (BOOL)validateUsernameLength {
    return self.usernameField.text.length >= 4;
}

- (BOOL)validateUsernameSpaces {
    NSRange whiteSpaceRange = [self.usernameField.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    return whiteSpaceRange.location == NSNotFound ? YES : NO;
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
    
    if(![self validateUsernameSpaces]) {
        [errorString appendString:[AppLabels getSpaceError:@"Username"]];
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
    
    
    __weak RegisterViewController *weakSelf = self;
    if([errorString isEqualToString:@""]){
        NSLog(@"No errors");
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

@end
