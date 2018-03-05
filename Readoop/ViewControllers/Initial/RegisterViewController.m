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

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    self.registerPanel.backgroundColor = [[Color getWhite] colorWithAlphaComponent:0.98];
}

@end
