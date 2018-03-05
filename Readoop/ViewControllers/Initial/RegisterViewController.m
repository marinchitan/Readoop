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

@interface RegisterViewController ()
@property (assign, nonatomic) CGFloat initialCornerRadius;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.initialCornerRadius = 5.0;
    [self setUpUI];
    [self setUpRegisterPanel];
    
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
    
}

- (void)setUpSignals {
    
}

@end
