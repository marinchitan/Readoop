//
//  ContainerViewController.m
//  Readoop
//
//  Created by Marin Chitan on 26/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "ContainerViewController.h"
#import "Essentials.h"

@interface ContainerViewController ()

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.navigationController) { //If it is in a navigation stack
        [self setupNavigationBar];  //Setup navBar
    }
    self.initialCornerRadius = 5.0f;
    self.appSession = [Session sharedSession];
}

- (void)setupNavigationBar {
    [Navigation paintNavigationBarWithColor:[Color getBariolRed] for:self.navigationController];

    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Something" style:UIBarButtonItemStylePlain target:self action:@selector(backItemAction:)];
    backItem.title = [NSString stringWithFormat:@" %@",[NSString fontAwesomeIconStringForEnum:FAChevronLeft]];
    backItem.tintColor = [Color getWhite];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIBarButtonItem *logOutItem = [[UIBarButtonItem alloc] initWithTitle:@"Something" style:UIBarButtonItemStylePlain target:self action:@selector(logOutItemAction:)];
    logOutItem.title = [NSString stringWithFormat:@"%@ ",[NSString fontAwesomeIconStringForEnum:FASignOut]];
    logOutItem.tintColor = [Color getWhite];
    
    self.navigationItem.rightBarButtonItem = logOutItem;
    
    self.navigationItem.leftBarButtonItem.enabled = self.backButtonEnabled;
}

- (IBAction)backItemAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)logOutItemAction:(id)sender {
    [AlertUtils showInformation:@"Do you want to sign out?"
                      withTitle:@"Sign Out"
               withActionButton:@"Yes"
               withCancelButton:@"No"
                     withAction:^{[self.tabBarController.navigationController popViewControllerAnimated:self.tabBarController];}
                           onVC:self];
}

@end
