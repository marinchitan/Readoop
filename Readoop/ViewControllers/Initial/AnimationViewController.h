//
//  AnimationViewController.h
//  Readoop
//
//  Created by Adrian Burcin on 20/02/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JHChainableAnimations/JHChainableAnimations.h>

@interface AnimationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *rLabel;
@property (weak, nonatomic) IBOutlet UILabel *eLabel;
@property (weak, nonatomic) IBOutlet UILabel *aLabel;
@property (weak, nonatomic) IBOutlet UILabel *dLabel;
@property (weak, nonatomic) IBOutlet UILabel *o1Label;
@property (weak, nonatomic) IBOutlet UILabel *o2Label;
@property (weak, nonatomic) IBOutlet UILabel *pLabel;

@property (strong, nonatomic) JHChainableAnimator* rAnimator;
@property (strong, nonatomic) JHChainableAnimator* eAnimator;
@property (strong, nonatomic) JHChainableAnimator* aAnimator;
@property (strong, nonatomic) JHChainableAnimator* dAnimator;
@property (strong, nonatomic) JHChainableAnimator* o1Animator;
@property (strong, nonatomic) JHChainableAnimator* o2Animator;
@property (strong, nonatomic) JHChainableAnimator* pAnimator;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftContstraint;

@end
