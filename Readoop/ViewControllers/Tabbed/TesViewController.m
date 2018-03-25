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
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.appSession = [Session sharedSession];
    }

- (void)viewDidAppear:(BOOL)animated{
    [self initialGreet];
}

- (void)initialGreet {
    if(self.appSession.wayOfArrival == register_path){
        [AlertUtils getSuccesToastPanel:@"Welcome!" withMessage:@"Succcessfully registered."];
        self.appSession.wayOfArrival = others_path;
    } else if(self.appSession.wayOfArrival == login_path){
        [AlertUtils getSuccesToastPanel:@"Success!" withMessage:@"Succcessfully logged in."];
        self.appSession.wayOfArrival = others_path;
    }
    
    self.testLabel.text = self.appSession.currentUser.username;
}


@end
