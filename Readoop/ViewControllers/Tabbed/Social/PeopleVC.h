//
//  PeopleVC.h
//  Readoop
//
//  Created by Marin Chitan on 20/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerViewController.h"

@interface PeopleVC : ContainerViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *buttonsView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UIButton *myFriendsButton;
@property (weak, nonatomic) IBOutlet UIButton *allPeopleButton;
@property (weak, nonatomic) IBOutlet UITextField *searchViewButton;

@property (nonatomic, assign) BOOL isMyFriendsEnabled;
@property (nonatomic, assign) BOOL isAllPeopleEnabled;

@property (weak, nonatomic) IBOutlet UITableView *tableVIew;
@end
