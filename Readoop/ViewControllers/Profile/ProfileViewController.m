//
//  ProfileViewController.m
//  Readoop
//
//  Created by Marin Chitan on 20/02/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "ProfileViewController.h"
#import "Color.h"
#import "Navigation.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI {
    [Navigation showStatusBar];
    [Navigation makeStatusBarLightStyle];
    [Navigation vanishNavBar:self.navigationController];
    [Navigation paintStatusBarWithColor:[Color getMainRed]];    
}

@end
