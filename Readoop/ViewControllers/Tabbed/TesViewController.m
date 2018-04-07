//
//  TesViewController.m
//  Readoop
//
//  Created by Marin Chitan on 18/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "TesViewController.h"
#import "Essentials.h"

@interface TesViewController ()
@property (nonatomic, strong) Session* appSession;
@end

@implementation TesViewController

- (void)viewDidLoad {
    self.backButtonEnabled = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.appSession = [Session sharedSession];
}

- (void)viewDidAppear:(BOOL)animated{
    [self initialGreet];
}

- (void)initialGreet {
    self.testLabel.text = self.appSession.currentUser.username;
}


@end
