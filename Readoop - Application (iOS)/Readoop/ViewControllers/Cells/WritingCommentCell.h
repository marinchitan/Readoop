//
//  WritingCommentCell.h
//  Readoop
//
//  Created by Marin Chitan on 04/07/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WritingComment.h"

@interface WritingCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *postContentLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *byUserLabel;
@property (weak, nonatomic) IBOutlet UILabel *datePostedLabel;
@property (weak, nonatomic) IBOutlet UIButton *upButton;
@property (weak, nonatomic) IBOutlet UIButton *downButton;
@property (weak, nonatomic) IBOutlet UILabel *averageRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *upLabel;
@property (weak, nonatomic) IBOutlet UILabel *downLabel;

@property (assign, nonatomic) BOOL isUpActive;
@property (assign, nonatomic) BOOL isDownActive;

@property (strong, nonatomic) WritingComment *currentWritingComment;

- (void)setupCellWithModel:(WritingComment *)writingComment;
- (void)statusCheck;

@end
