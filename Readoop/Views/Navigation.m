//
//  Navigation.m
//  Readoop
//
//  Created by Marin Chitan on 26/02/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//
// NOTE: Methods on sharedAppliaction are deprecated since iOS 8

#import "Navigation.h"
#import <UIKit/UIKit.h>

@implementation Navigation

+ (void)makeStatusBarLightStyle {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

+ (void)makeStatusBarDarkStyle{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

+ (void)hideStatusBar{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

+ (void)showStatusBar {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

+ (void)vanishNavBar:(UINavigationController*)navController {
    [navController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    navController.navigationBar.shadowImage = [UIImage new];
    navController.navigationBar.translucent = YES;
    navController.view.backgroundColor = [UIColor clearColor];
    navController.navigationBar.backgroundColor = [UIColor clearColor];
}

+ (void)reEnableNavBar:(UINavigationController*)navController {
    [navController.navigationBar setBackgroundImage:nil
                                      forBarMetrics:UIBarMetricsDefault];
}

+ (void)paintStatusBarWithColor:(UIColor *)color{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];

    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

@end
