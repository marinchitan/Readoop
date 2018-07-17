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
#import "UserDefaultsManager.h"
#import "Session.h"
#import "URLSessionManager.h"

@interface AnimationViewController ()

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self setUpLeftConstraint];
    [self pushProfileVCWithDelay:3.0]; //3.0 in prod
    [[URLSessionManager sharedSession] startBookRequests];
    [[URLSessionManager sharedSession] loadRequestsFromMongo];
    [[URLSessionManager sharedSession] loadWritingCommentsFromMongo];
    [[URLSessionManager sharedSession] loadBookRatesFromMongo];
    [[URLSessionManager sharedSession] loadPostsFromMongo];
    [[URLSessionManager sharedSession] loadWritingsFromMongo];
}

- (void)viewWillAppear:(BOOL)animated {
    [Navigation hideNavBar:[self navigationController]];
}

- (void)setUpLeftConstraint {
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat textWidth = self.rLabel.frame.size.width + self.eLabel.frame.size.width + self.aLabel.frame.size.width + self.dLabel.frame.size.width + self.o1Label.frame.size.width + self.o2Label.frame.size.width + self.pLabel.frame.size.width;
    CGFloat leftConstraintConstant = (screenWidth - textWidth)/2;
    self.leftContstraint.constant = leftConstraintConstant > 0 ? leftConstraintConstant + 5 : 0;
}

- (void)setUpUI {
    self.view.backgroundColor = [Color getMainRed];
    [self paintLabelsWithColor:[Color getMainWhite]];
    
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
    self.rAnimator.wait(1.2).moveX(40).thenAfter(0.4).moveX(40).thenAfter(0.4).moveX(40).thenAfter(0.5).makeOpacity(0).animate(0.3);
    self.eAnimator.wait(1.2).moveX(40).thenAfter(0.4).moveX(40).thenAfter(0.4).makeOpacity(0).animate(0.3);
    self.aAnimator.wait(1.2).moveX(40).thenAfter(0.5).makeOpacity(0).animate(0.3);
    self.dAnimator.wait(1.2).makeOpacity(0).animate(0.3);
    self.o2Animator.wait(1.2).moveX(-40).thenAfter(0.4).makeOpacity(0).animate(0.3);
    self.o1Animator.wait(1.2).moveX(-40).thenAfter(0.4).moveX(-40).thenAfter(0.4).makeOpacity(0).animate(0.3);
    self.pAnimator.wait(1.2).moveX(-40).thenAfter(0.4).moveX(-40).thenAfter(0.4).moveX(-40).thenAfter(0.5).makeOpacity(0).animate(0.3);
}

- (void)pushProfileVCWithDelay:(int64_t)transitionDelay {
    ProfileViewController *profileVC = [ViewController getProfileVC];
    DashboardTabbed* dashboard = [ViewController getTabbedDashboard];
    dashboard.seamless = YES;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(transitionDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if([UserDefaultsManager checkCredentialsValability] && [UserDefaultsManager getCurrentUser].shouldBeRemembered){//Seamless login
            Session *appSession = [Session sharedSession];
            appSession.currentUser = [UserDefaultsManager getCurrentUser];
            [self.navigationController pushViewController:dashboard animated:YES];
        } else { //Normal login
            [self.navigationController pushViewController:profileVC animated:YES];
        }
    });
}

@end
