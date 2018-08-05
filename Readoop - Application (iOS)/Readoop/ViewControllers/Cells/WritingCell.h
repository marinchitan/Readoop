//
//  WritingCell.h
//  Readoop
//
//  Created by Marin Chitan on 13/05/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Writing.h"
#import "LibraryVC.h"

@interface WritingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleContents;
@property (weak, nonatomic) IBOutlet UILabel *authorContents;
@property (weak, nonatomic) IBOutlet UILabel *priceContents;
@property (weak, nonatomic) IBOutlet UIView *separatorView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@property (strong , nonatomic) Writing *currentWriting;

@property (strong, nonatomic) UINavigationController *navController;

@property (strong, nonatomic) id<LibraryTVCDelegate> delegate;

- (void)setupCellWithModel:(Writing*)writing;

@end
