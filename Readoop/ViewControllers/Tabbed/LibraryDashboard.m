//
//  LibraryDashboard.m
//  Readoop
//
//  Created by Marin Chitan on 16/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "LibraryDashboard.h"

@interface LibraryDashboard ()

@end

@implementation LibraryDashboard

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI {
    [Navigation hideNavBar:self.navigationController];
}

@end
