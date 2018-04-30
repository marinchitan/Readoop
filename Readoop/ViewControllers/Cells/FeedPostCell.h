//
//  FeedPostCell.h
//  Readoop
//
//  Created by Marin Chitan on 30/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface FeedPostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *postContentLabel;

- (void)setupCellWithModel:(Post*)post;

@end
