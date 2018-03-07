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
    RACSignal *usernameTextSignal = [self.usernameField rac_textSignal];
    RACSignal *passwordTextSignal = [self.passwordFied rac_textSignal];
    RACSignal *confirmpasswordTextSignal = [self.confirmpasswordField rac_textSignal];
    RACSignal *fullnameTextSignal = [self.fullnameField rac_textSignal];
    RACSignal *emailTextSignal = [self.emailField rac_textSignal];
    
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
    
}

- (IBAction)done:(id)sender {
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
