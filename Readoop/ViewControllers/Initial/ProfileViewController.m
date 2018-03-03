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
    self.profileView.backgroundColor = [[Color getWhite] colorWithAlphaComponent:0.95];
    self.welcomeLabel.textColor = [Color getMainWhite];
    self.signInButton.tintColor = [Color getMainWhite];
    self.signInButton.backgroundColor = [Color getMainRed];
}

@end
