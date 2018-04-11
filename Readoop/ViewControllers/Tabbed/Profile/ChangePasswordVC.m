//
//  ChangePasswordVC.m
//  Readoop
//
//  Created by Marin Chitan on 06/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "ChangePasswordVC.h"
#import "Essentials.h"

@interface ChangePasswordVC ()
@property (nonatomic, strong) NSString* lockedIcon;
@property (nonatomic, strong) NSString* unlockedIcon;
@end

@implementation ChangePasswordVC

- (void)viewDidLoad {
    self.backButtonEnabled = YES;
    [super viewDidLoad];
    [self setupUI];
    [self setupSignals];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    [ViewUtils setUpField:self.oldPasswordField withRadius:self.initialCornerRadius];
    [ViewUtils setUpField:self.nwPasswordField withRadius:self.initialCornerRadius];
    [ViewUtils setUpField:self.reNewPasswordField withRadius:self.initialCornerRadius];
    [ViewUtils setUpButton:self.saveButton withRadius:self.initialCornerRadius];
    [ViewUtils setUpButton:self.cancelButton withRadius:self.initialCornerRadius];
    
    [ViewUtils setUpStandardInactiveButton:self.saveButton];
    [ViewUtils setUpCancelActiveBUtton:self.cancelButton];
    
    [ViewUtils setUpIconLabel:self.lockIcon withSize:30];
    
    self.lockedIcon = [NSString fontAwesomeIconStringForEnum:FALock];
    self.unlockedIcon = [NSString fontAwesomeIconStringForEnum:FAUnlock];
    self.lockIcon.text = self.lockedIcon;
}

- (void)setupSignals {
    
    RACSignal *oldPasswordTextSignal = [self.oldPasswordField rac_textSignal];
    RACSignal *newPasswordTextSignal = [self.nwPasswordField rac_textSignal];
    RACSignal *reNewPasswordTextSignal = [self.reNewPasswordField rac_textSignal];
    
    RACSignal *oldPassWordSignal = [oldPasswordTextSignal map:^id (NSString* value) {
        return @(value.length > 0);
    }];
    RACSignal *newPasswordSignal = [newPasswordTextSignal map:^id (NSString* value) {
        return @(value.length > 0);
    }];
    RACSignal *reNewPasswordSignal = [reNewPasswordTextSignal map:^id (NSString* value) {
        return @(value.length > 0);
    }];
    
    //Signal for lock icon
    RAC(self.lockIcon, text) = [oldPasswordTextSignal map:^id (NSString* password) {
        return [self checkOldPasswordValidity:password] ? self.unlockedIcon : self.lockedIcon;
    }];
    
    //Save button signal
    RAC(self.saveButton, enabled) = [RACSignal combineLatest:@[oldPassWordSignal, newPasswordSignal, reNewPasswordSignal]                       reduce:^id (NSNumber *validOld, NSNumber *validNew, NSNumber *validReNew){
            return @([validOld boolValue] && [validNew boolValue] && [validReNew boolValue]);
    }];
    
    RAC(self.saveButton, backgroundColor) = [RACSignal combineLatest:@[oldPassWordSignal, newPasswordSignal, reNewPasswordSignal]                       reduce:^id (NSNumber *validOld, NSNumber *validNew, NSNumber *validReNew){
            return [validOld boolValue] && [validNew boolValue] && [validReNew boolValue] ?
                [Color getBariolRed] : [Color getPassiveBariolRed];
    }];
    
}

- (BOOL)checkOldPasswordValidity:(NSString *)password {
    NSString *sessionPassword = self.appSession.currentUser.password;
    return [password isEqualToString:sessionPassword] ? YES : NO;
}

- (BOOL)validateNewPasswordLength {
    return self.nwPasswordField.text.length >= 6;
}

- (BOOL)validateNewPasswordSpaces {
    NSRange whiteSpaceRange = [self.nwPasswordField.text rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    return whiteSpaceRange.location == NSNotFound ? YES : NO;
}

- (BOOL)validateNewConfirmPassword {
    return [self.reNewPasswordField.text isEqualToString:self.nwPasswordField.text] ? YES : NO;
}

- (IBAction)save:(id)sender {
    NSMutableString *errorString = [NSMutableString new];
    
    if(![self validateNewPasswordLength]) {
        [errorString appendString:[AppLabels getLengthError:@"New Password" withExcepectedLength:@"6"]];
        [errorString appendString:@"\n\n"];
    }
    
    if(![self validateNewPasswordSpaces]) {
        [errorString appendString:[AppLabels getSpaceError:@"New Password"]];
        [errorString appendString:@"\n\n"];
    }
    
    if(![self validateNewConfirmPassword]) {
        [errorString appendString:[AppLabels getDifferentNewPasswordsError]];
        [errorString appendString:@"\n\n"];
    }
    
    if(![self checkOldPasswordValidity:self.oldPasswordField.text]) {
        [errorString appendString:[AppLabels getWrongOldPasswordError]];
        [errorString appendString:@"\n\n"];
    }
    
    __weak ChangePasswordVC *weakSelf = self;
    if([errorString isEqualToString:@""]){
    //success
        //MONGOPUT
        [RealmUtils changePasswordForUser:self.appSession.currentUser newPassword:self.nwPasswordField.text];
        [AlertUtils showSuccess:@"Password was changed"
                      withTitle:@"Success!"
               withActionButton:@"Ok"
                     withAction:^{[self.navigationController popViewControllerAnimated:YES];}
                           onVC:weakSelf];
    } else {
    //errors
        [AlertUtils showAlertModal:errorString
                         withTitle:@"Wrong data supplied"
                  withCancelButton:@"Got it!"
                              onVC:weakSelf];
    }
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
