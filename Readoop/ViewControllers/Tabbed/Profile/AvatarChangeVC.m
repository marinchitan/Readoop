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
  self.view.backgroundColor = [UIColor colorWithDisplayP3Red:55/255 green:55/255 blue:55/255 alpha:0.7];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}


- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
