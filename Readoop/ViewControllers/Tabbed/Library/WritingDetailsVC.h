//
//  WritingDetailsVC.h
//  Readoop
//
//  Created by Marin Chitan on 19/05/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerViewController.h"

@interface WritingDetailsVC : ContainerViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleContents;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorContents;
@property (weak, nonatomic) IBOutlet UILabel *authorUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorUsernameContents;
@property (weak, nonatomic) IBOutlet UILabel *shortDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *shortDescriptionContents;

@property (weak, nonatomic) IBOutlet UILabel *addedDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceContents;


@property (weak, nonatomic) IBOutlet UIImageView *coverImage;

@end
