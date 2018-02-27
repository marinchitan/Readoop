//
//  Navigation.h
//  Readoop
//
//  Created by Marin Chitan on 26/02/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Navigation : NSObject

+ (void)makeStatusBarLightStyle;
+ (void)makeStatusBarDarkStyle;

+ (void)hideStatusBar;
+ (void)showStatusBar;

+ (void)vanishNavBar:(UINavigationController*)navController;
+ (void)reEnableNavBar:(UINavigationController*)navController;

+ (void)paintStatusBarWithColor:(UIColor*)color;
@end
