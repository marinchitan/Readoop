//
//  DashboardTabbed.m
//  Readoop
//
//  Created by Marin Chitan on 16/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "DashboardTabbed.h"
#import "Color.h"
#import "AppLabels.h"
#import "ViewController.h"
#import "Font.h"
#import "UIImage+FontAwesome.h"
#import "Navigation.h"

@interface DashboardTabbed ()

@end

@implementation DashboardTabbed

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    
    if(self.seamless) {
        [self insertLoginVCBack];
    }
}

- (void)insertLoginVCBack {
    [Navigation showStatusBar];
    [Navigation makeStatusBarLightStyle];

    NSMutableArray *viewControllers = [[self.navigationController viewControllers] mutableCopy];
    ProfileViewController *loginVC = [ViewController getProfileVC];
    
    [viewControllers insertObject:loginVC atIndex:viewControllers.count - 1];
    [self.navigationController setViewControllers:viewControllers];
}

- (void)setUpUI{
    self.tabBar.barTintColor = [Color getBariolRed];
    self.tabBar.translucent = NO;
    
    UITabBarItem *profileItem = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *feedItem = [self.tabBar.items objectAtIndex:1];
    UITabBarItem *libraryItem = [self.tabBar.items objectAtIndex:2];
    UITabBarItem *configurationItem = [self.tabBar.items objectAtIndex:3];
 
    profileItem.image = [[UIImage imageWithIcon:@"fa-user" backgroundColor:[UIColor clearColor] iconColor:[Color getPassiveTab] fontSize:22] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    profileItem.selectedImage = [[UIImage imageWithIcon:@"fa-user" backgroundColor:[UIColor clearColor] iconColor:[Color getActiveTab] fontSize:26] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    feedItem.image = [[UIImage imageWithIcon:@"fa-bars" backgroundColor:[UIColor clearColor] iconColor:[Color getPassiveTab] fontSize:22]
                      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    feedItem.selectedImage = [[UIImage imageWithIcon:@"fa-bars" backgroundColor:[UIColor clearColor] iconColor:[Color getActiveTab] fontSize:26] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    libraryItem.image = [[UIImage imageWithIcon:@"fa-book" backgroundColor:[UIColor clearColor] iconColor:[Color getPassiveTab] fontSize:22] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    libraryItem.selectedImage = [[UIImage imageWithIcon:@"fa-book" backgroundColor:[UIColor clearColor] iconColor:[Color getActiveTab] fontSize:26] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    configurationItem.image = [[UIImage imageWithIcon:@"fa-cog" backgroundColor:[UIColor clearColor] iconColor:[Color getPassiveTab] fontSize:22] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    configurationItem.selectedImage = [[UIImage imageWithIcon:@"fa-cog" backgroundColor:[UIColor clearColor] iconColor:[Color getActiveTab] fontSize:26] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    profileItem.title = @"Profile";
    feedItem.title = @"Feed";
    libraryItem.title = @"Library";
    configurationItem.title = @"Settings";
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [Font getBariolwithSize:15.0f],
                                                        NSForegroundColorAttributeName : [Color getPassiveTab]
                                                       } forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [Font getBariolwithSize:15.0f],
                                                        NSForegroundColorAttributeName : [Color getActiveTab]
                                                    } forState:UIControlStateSelected];
}

@end
