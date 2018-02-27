//
//  AnimationViewController.m
//  Readoop
//
//  Created by Adrian Burcin on 20/02/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "AnimationViewController.h"
#import "Color.h"
#import "ViewController.h"
#import "Navigation.h"

@interface AnimationViewController ()

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self pushProfileVCWithDelay:5.0];
}

- (void)setUpUI {
    self.view.backgroundColor = [Color getMainRed];
    [Navigation hideStatusBar];
    [Navigation vanishNavBar:self.navigationController];
}

- (void)pushProfileVCWithDelay:(int64_t)transitionDelay {
    ProfileViewController *profileVC = [ViewController getProfileVC];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(transitionDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:profileVC animated:YES];
    });
}

@end
