//
//  EditProfileVC.m
//  Readoop
//
//  Created by Marin Chitan on 06/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "EditProfileVC.h"
#import "Essentials.h"

@interface EditProfileVC ()

@end

@implementation EditProfileVC

- (void)viewDidLoad {
    self.backButtonEnabled = YES;
    [super viewDidLoad];
    [self setupUI];
    [self setupSignals];
    [self populateDataIfNeccessary];
    // Do any additional setup after loading the view.
}

- (void)populateDataIfNeccessary {
    NSString *email = self.appSession.currentUser.email;
    NSString *username = self.appSession.currentUser.username;
    NSString *fullName = self.appSession.currentUser.fullName;
    
    if(email){
        self.emailField.text = email;
    }
    
    if(username){
        self.usernameField.text = username;
    }
    
    if(fullName){
        self.fullnameField.text = fullName;
    }
    
    self.doneButton.enabled = YES;
    self.doneButton.backgroundColor = [Color getBariolRed];
    
}

- (void)setupUI {
    [ViewUtils setUpField:self.usernameField withRadius:self.initialCornerRadius];
    [ViewUtils setUpField:self.emailField withRadius:self.initialCornerRadius];
    [ViewUtils setUpField:self.fullnameField withRadius:self.initialCornerRadius];
    [ViewUtils setUpButton:self.doneButton withRadius:self.initialCornerRadius];
    [ViewUtils setUpButton:self.cancelButton withRadius:self.initialCornerRadius];
    
    [ViewUtils setUpCancelActiveBUtton:self.cancelButton];
    [ViewUtils setUpStandardInactiveButton:self.doneButton];
}

- (void)setupSignals {
    RACSignal *usernameTextSignal = [[self.usernameField rac_textSignal] map:^id(NSString *value) {
        return @(value.length > 0);
    }];
    RACSignal *emailTextSignal = [[self.emailField rac_textSignal] map:^id(NSString *value) {
        return @(value.length > 0);
    }];
    RACSignal *fullnameTextSignal = [[self.fullnameField rac_textSignal] map:^id(NSString *value) {
        return @(value.length > 0);
    }];
    
    
    //Merge signals because the user can edit only one field and let the other fields untouched
    //so not every fied should emmit a signal to be considered
    RAC(self.doneButton, enabled) = [[RACSignal merge:@[usernameTextSignal, emailTextSignal, fullnameTextSignal]]
                                     map:^id (NSNumber *value) {
                                         return @([value boolValue]);
                                     }];
    
    RAC(self.doneButton, backgroundColor) = [[RACSignal merge:@[usernameTextSignal, emailTextSignal, fullnameTextSignal]]
                                     map:^id (NSNumber *value) {
                                         return [value boolValue] ? [Color getBariolRed] : [Color getPassiveBariolRed];
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
    NSString *currentUsername = self.appSession.currentUser.username;
    User *retrievedUser = [[User objectsWhere:@"username == %@",self.usernameField.text] firstObject];
    if(retrievedUser && ![self.usernameField.text isEqualToString:currentUsername]){
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)validateName {
    return [self.fullnameField.text rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location == NSNotFound;
}

- (BOOL)validateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self.emailField.text];
}

- (IBAction)saveData:(id)sender {
    NSMutableString *errorString = [NSMutableString new];
    
    if(![self validateUsernameLength]) {
        [errorString appendString:[AppLabels getLengthError:@"Username" withExcepectedLength:@"4"]];
        [errorString appendString:@"\n\n"];
    }
    
    if(![self validateUsernameUnique]) {
        [errorString appendString:[AppLabels getUniqueUsernameError]];
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
    
    if(![self validateUsernameSpaces] && self.usernameField.text.length > 0) {
        [errorString appendString:[AppLabels getSpaceError:@"Username"]];
        [errorString appendString:@"\n\n"];
    }
    
    __weak EditProfileVC *weakSelf = self;
    if([errorString isEqualToString:@""]){
        //success
        //MONGOPUT
        
        [RealmUtils changeUsernameForUser:self.appSession.currentUser newUsername:self.usernameField.text];
        [RealmUtils changeEmailForUser:self.appSession.currentUser newEmail:self.emailField.text];
        [RealmUtils changeFullNameForUser:self.appSession.currentUser newName:self.fullnameField.text];
        
        [AlertUtils showSuccess:@"Data supplied"
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
