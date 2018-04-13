//
//  ProfileCell.h
//  Readoop
//
//  Created by Marin Chitan on 26/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileDashboard.h"

@interface ProfileCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *separatorView;
@property (weak, nonatomic) IBOutlet UILabel *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *chevron;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@property (strong, nonatomic) NSString *action;
@property (strong, nonatomic) UINavigationController *currentNav;
@property (strong, nonatomic) ProfileDashboard *currentVC;
@property (strong, nonatomic) UITabBarController *currentTab;


- (void)setUpCellIconIndex:(int)value;
- (void)setActionForCell:(NSString*)selectorString onVC:(UIViewController*)vc;

@end
