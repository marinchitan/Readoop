//
//  AppDelegate.m
//  Readoop
//
//  Created by Adrian Burcin on 20/02/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//
//  Supressed <deprecated> warnings in Target, not a good practice.

#import "AppDelegate.h"
#import "ViewController.h"
#import "RealmConfig.h"
#import "NSString+FontAwesome.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    AnimationViewController* animationVC = [ViewController getAnimationVC];
    self.mainNavController = [[UINavigationController alloc] initWithRootViewController:animationVC];
    self.window.rootViewController = self.mainNavController;
    [self.window makeKeyAndVisible];
    
    //Configure SDKs
    RealmConfig *realmConfig = [RealmConfig new];
    [realmConfig configRealm];
    
    //Configure font for navigation bar items
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:kFontAwesomeFamilyName size:20.0]}
                                                                        forState:UIControlStateNormal];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:kFontAwesomeFamilyName size:20.0]}
                                                                        forState:UIControlStateSelected];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:kFontAwesomeFamilyName size:20.0]}
                                                                        forState:UIControlStateFocused];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:kFontAwesomeFamilyName size:20.0]}
                                                                        forState:UIControlStateHighlighted];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont fontWithName:kFontAwesomeFamilyName size:20.0]}
                                                                           forState:UIControlStateDisabled];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
   
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
   
}


@end
