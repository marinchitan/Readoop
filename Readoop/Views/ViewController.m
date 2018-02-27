//
//  ViewController.m
//  Readoop
//
//  Created by Adrian Burcin on 20/02/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

+ (AnimationViewController*)getAnimationVC {
    return [[UIStoryboard storyboardWithName:@"Initial" bundle:nil]
            instantiateViewControllerWithIdentifier:@"animationViewController"];
}

+ (ProfileViewController*)getProfileVC {
    return [[UIStoryboard storyboardWithName:@"Profile" bundle:nil]
            instantiateViewControllerWithIdentifier:@"profileViewController"];
}


@end
