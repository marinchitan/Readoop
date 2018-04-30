//
//  FeedPostCell.m
//  Readoop
//
//  Created by Marin Chitan on 30/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "FeedPostCell.h"
#import "Post.h"

@implementation FeedPostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupCellWithModel:(Post*)post {
    self.postContentLabel.text = post.content;
}

@end
