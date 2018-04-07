//
//  ContainerViewController.h
//  Readoop
//
//  Created by Marin Chitan on 26/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Session.h"

@interface ContainerViewController : UIViewController
@property (nonatomic, assign) BOOL backButtonEnabled;
@property (assign, nonatomic) CGFloat initialCornerRadius;
@property (nonatomic, strong) Session* appSession;
@end
