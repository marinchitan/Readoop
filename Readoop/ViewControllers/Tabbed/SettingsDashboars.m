//
//  SettingsDashboars.m
//  Readoop
//
//  Created by Marin Chitan on 16/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "SettingsDashboars.h"

@interface SettingsDashboars ()

@end

@implementation SettingsDashboars

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI {
    [Navigation hideNavBar:self.navigationController];
}

@end
