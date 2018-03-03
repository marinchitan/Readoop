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

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self setUpProfilePanel];
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
    
    self.usernameField.layer.borderColor = [[Color getTextFieldBorderGray] CGColor];
    self.passwordField.layer.borderColor = [[Color getTextFieldBorderGray] CGColor];
    self.usernameField.layer.masksToBounds = YES;
    self.usernameField.layer.borderWidth = 1.0f;
    self.passwordField.layer.masksToBounds = YES;
    self.passwordField.layer.borderWidth = 1.0f;
}

- (IBAction)signIn:(id)sender {
}

- (IBAction)signUp:(id)sender {
}

- (IBAction)cancel:(id)sender {
}


@end
