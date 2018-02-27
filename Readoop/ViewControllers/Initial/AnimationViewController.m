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
    [self paintLabelsWithColor:[Color getSmokeWhite]];
    
    [Navigation hideStatusBar];
    [Navigation vanishNavBar:self.navigationController];
    
    [self initAnimators];
    [self performAnimationOnLabels];
}

- (void)paintLabelsWithColor:(UIColor*)color {
    self.aLabel.textColor = color;
    self.eLabel.textColor = color;
    self.rLabel.textColor = color;
    self.dLabel.textColor = color;
    self.o1Label.textColor = color;
    self.o2Label.textColor = color;
    self.pLabel.textColor = color;
}

- (void)initAnimators {
    self.rAnimator = [[JHChainableAnimator alloc] initWithView:self.rLabel];
    self.eAnimator = [[JHChainableAnimator alloc] initWithView:self.eLabel];
    self.dAnimator = [[JHChainableAnimator alloc] initWithView:self.dLabel];
    self.o2Animator = [[JHChainableAnimator alloc] initWithView:self.o1Label];
    self.o1Animator = [[JHChainableAnimator alloc] initWithView:self.o2Label];
    self.aAnimator = [[JHChainableAnimator alloc] initWithView:self.aLabel];
    self.pAnimator = [[JHChainableAnimator alloc] initWithView:self.pLabel];
}

- (void)performAnimationOnLabels {
    self.rAnimator.wait(1).moveX(30).animate(1);
    
    self.pAnimator.wait(1).moveX(-30).animate(1);
}

- (void)pushProfileVCWithDelay:(int64_t)transitionDelay {
    ProfileViewController *profileVC = [ViewController getProfileVC];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(transitionDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController pushViewController:profileVC animated:YES];
    });
}

@end
