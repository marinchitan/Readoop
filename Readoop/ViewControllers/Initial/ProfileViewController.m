//
//  ProfileViewController.m
//  Readoop
//
//  Created by Marin Chitan on 20/02/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "ProfileViewController.h"
#import "Color.h"
#import "Navigation.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <EHPlainAlert/EHPlainAlert.h>
#import <SCLAlertView-Objective-C/SCLAlertView.h>

@interface ProfileViewController ()
@property (assign, nonatomic) CGFloat initialCornerRadius;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.initialCornerRadius = 5.0;
    [self setUpUI];
    [self setUpProfilePanel];
    [self setUpSignals];
}

- (void)setUpUI {
    [Navigation showStatusBar];
    [Navigation makeStatusBarLightStyle];
    [Navigation hideNavBar:[self navigationController]];
    [Navigation paintStatusBarWithColor:[Color getMainRed]];
    
    self.view.backgroundColor = [Color getMainRed];
}

- (void)setUpProfilePanel {
    self.profileView.layer.cornerRadius = 30;
    self.profileView.layer.masksToBounds = YES;
    self.profileView.backgroundColor = [[Color getWhite] colorWithAlphaComponent:0.98];
    self.welcomeLabel.textColor = [Color getMainWhite];
    
    self.usernameField.layer.cornerRadius = self.initialCornerRadius;
    self.signInButton.layer.cornerRadius = self.initialCornerRadius;
    self.passwordField.layer.cornerRadius = self.initialCornerRadius;
    self.signUpButton.layer.cornerRadius = self.initialCornerRadius;
    self.cancelButton.layer.cornerRadius = self.initialCornerRadius;
    
    self.usernameField.layer.borderColor = [[Color getTextFieldBorderGray] CGColor];
    self.passwordField.layer.borderColor = [[Color getTextFieldBorderGray] CGColor];
    self.usernameField.layer.masksToBounds = YES;
    self.usernameField.layer.borderWidth = 1.0f;
    self.passwordField.layer.masksToBounds = YES;
    self.passwordField.layer.borderWidth = 1.0f;
    
    self.signInButton.enabled = NO;
    self.signInButton.backgroundColor = [Color getPassiveBariolRed];
    [self.signInButton setTitleColor:[Color getMainPassiveGray] forState:UIControlStateDisabled];
    
    self.signUpButton.backgroundColor = [Color getMainRed];
    self.cancelButton.backgroundColor = [Color getMainPassiveGray];
}

- (void)setUpSignals {
    /*RAC(self.usernameField.layer, borderWidth) = [RACObserve(self.usernameField, isFirstResponder) map:^id _Nullable(id  _Nullable value) {
        BOOL isFieldFocused = [value boolValue];
        return isFieldFocused ? @3.0 : @1.0;
    }];*/
    
    //Handle the focus cases for the fields
    RAC(self.usernameField.layer, borderWidth) = [[[self.usernameField rac_signalForControlEvents:UIControlEventEditingDidBegin] merge:[self.usernameField rac_signalForControlEvents:UIControlEventEditingDidEnd]] map:^id _Nullable(UITextField *value) {
        return value.isFirstResponder ? @2 : @0.8;
    }];
    RAC(self.passwordField.layer, borderWidth) = [[[self.passwordField rac_signalForControlEvents:UIControlEventEditingDidBegin] merge:[self.passwordField rac_signalForControlEvents:UIControlEventEditingDidEnd]] map:^id _Nullable(UITextField *value) {
        return value.isFirstResponder ? @2 : @0.8;
    }];
    RAC(self.usernameField.layer, borderColor) = [[[self.usernameField rac_signalForControlEvents:UIControlEventEditingDidBegin] merge:[self.usernameField rac_signalForControlEvents:UIControlEventEditingDidEnd]] map:^id _Nullable(UITextField *value) {
        return value.isFirstResponder ? [[Color getSilverGray] CGColor] : [[Color getTextFieldBorderGray] CGColor];
    }];
    RAC(self.passwordField.layer, borderColor) = [[[self.passwordField rac_signalForControlEvents:UIControlEventEditingDidBegin] merge:[self.passwordField rac_signalForControlEvents:UIControlEventEditingDidEnd]] map:^id _Nullable(UITextField *value) {
        return value.isFirstResponder ? [[Color getSilverGray] CGColor] : [[Color getTextFieldBorderGray] CGColor];
    }];
    RAC(self.usernameField, backgroundColor) = [[[self.usernameField rac_signalForControlEvents:UIControlEventEditingDidBegin] merge:[self.usernameField rac_signalForControlEvents:UIControlEventEditingDidEnd]] map:^id _Nullable(UITextField *value) {
        return value.isFirstResponder ? [Color getWhite] : [UIColor clearColor];
    }];
    RAC(self.passwordField, backgroundColor) = [[[self.passwordField rac_signalForControlEvents:UIControlEventEditingDidBegin] merge:[self.passwordField rac_signalForControlEvents:UIControlEventEditingDidEnd]] map:^id _Nullable(UITextField *value) {
        return value.isFirstResponder ? [Color getWhite] : [UIColor clearColor];
    }];
    
    
    RACSignal *usernameSignal = [[self.usernameField rac_textSignal] map:^id _Nullable(NSString * _Nullable value) {
        BOOL containsText = value.length > 0;
        return @(containsText);
    }];
    
    RACSignal *passwordSignal = [[self.passwordField rac_textSignal] map:^id _Nullable(NSString * _Nullable value) {
        BOOL containsText = value.length > 0;
        return @(containsText);
    }];
    
    //CombineLatest waits untill both signals emit a signal
    //Reduce returns a value from both signals combined
    RAC(self.signInButton, enabled) = [RACSignal combineLatest:@[usernameSignal, passwordSignal]
                                                        reduce:^id (NSNumber *usernameValid, NSNumber *passwordValid){
                                                            return @([usernameValid boolValue] && [passwordValid boolValue]);
                                                        }];
    
    RAC(self.signInButton, backgroundColor) = [RACSignal combineLatest:@[usernameSignal, passwordSignal]
                                                        reduce:^id (NSNumber *usernameValid, NSNumber *passwordValid){
                                                            return [usernameValid boolValue] && [passwordValid boolValue] ?
                                                            [Color getMainRed] : [Color getPassiveBariolRed];
                                                        }];
}

- (IBAction)signIn:(id)sender {
    NSLog(@"Sign in pressed");
    [EHPlainAlert showAlertWithTitle:@"Success" message:@"Successfully loged in" type:ViewAlertSuccess];
}

- (IBAction)signUp:(id)sender {
    
}

- (IBAction)cancel:(id)sender {
    //SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    //[alert showWarning:self title:@"Hello World" subTitle:@"This is a more descriptive text." closeButtonTitle:@"Done" duration:0.0f];
    SCLAlertViewBuilder *builder = [SCLAlertViewBuilder new]
    .addButtonWithActionBlock(@"Yes", ^{ exit(0); });
    SCLAlertViewShowBuilder *showBuilder = [SCLAlertViewShowBuilder new]
    .style(SCLAlertViewStyleError)
    .title(@"Quit")
    .closeButtonTitle(@"No")
    .subTitle(@"Do you want to quit the application ?")
    .duration(0);
    [showBuilder showAlertView:builder.alertView onViewController:self];
}


@end
