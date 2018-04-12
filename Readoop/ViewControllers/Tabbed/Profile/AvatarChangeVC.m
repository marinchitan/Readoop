//
//  AvatarChangeVC.m
//  Readoop
//
//  Created by Marin Chitan on 12/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "AvatarChangeVC.h"
#import "Essentials.h"

@interface AvatarChangeVC ()

@end

@implementation AvatarChangeVC

- (void)viewDidLoad {
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"dismiss clicked");
}


@end
