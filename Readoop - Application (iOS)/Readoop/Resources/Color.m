//
//  Color.m
//  Readoop
//
//  Created by Marin Chitan on 20/02/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "Color.h"

@implementation Color

+ (UIColor *)getMainRed {
    return [Color getBariolRed];
}

+ (UIColor *)getMainWhite {
    return [Color getWhite];
}

+ (UIColor *)getMainPassiveGray {
    return [Color getLightGray];
}

+ (UIColor *)getMainAlertYellow {
    return [Color getAlertYellow];
}


+ (UIColor *)getBariolRed {
    return [UIColor colorWithRed:(244/255.0) green:(67/255.0) blue:(54/255.0) alpha:1];
}

+ (UIColor *)getPassiveBariolRed {
    return [UIColor colorWithRed:(244/255.0) green:(67/255.0) blue:(54/255.0) alpha:0.7];
}

+ (UIColor *)getSmokeWhite {
    return [UIColor colorWithRed:(239/255.0) green:(239/255.0) blue:(239/255.0) alpha:1];
}

+ (UIColor *)getWhite {
    return [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1];
}

+ (UIColor *)getBlack {
    return [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
}

+ (UIColor *)getSubTitleGray {
    return [UIColor colorWithRed:(150/255.0) green:(152/255.0) blue:(154/255.0) alpha:1];
}

+ (UIColor *)getSilverGray {
    return [UIColor colorWithRed:(74/255.0) green:(76/255.0) blue:(78/255.0) alpha:1];
}

+ (UIColor *)getAlertYellow {
    return [UIColor colorWithRed:(255/255.0) green:(204/255.0) blue:(0/255.0) alpha:1];
}

+ (UIColor *)getLightGray {
    return [UIColor colorWithRed:(224/255.0) green:(224/255.0) blue:(224/255.0) alpha:1];
}

+ (UIColor *)getTextFieldBorderGray {
    return [UIColor colorWithRed:(80/255.0) green:(80/255.0) blue:(80/255.0) alpha:1];
}

+ (UIColor *)getValidGreen{
    return [UIColor colorWithRed:(78/255.0) green:(186/255.0) blue:(125/255.0) alpha:1];
}

+ (UIColor *)getInvalidRed{
    return [UIColor colorWithRed:(191/255.0) green:(41/255.0) blue:(50/255.0) alpha:1];
}

+ (UIColor *)getPassiveTab {
    return [UIColor colorWithRed:(55/255.0) green:(55/255.0) blue:(55/255.0) alpha:1];
}

+ (UIColor *)getActiveTab {
    return [UIColor whiteColor];
}

+ (UIColor *)getUltraLightGray {
    return [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1];
}

+ (UIColor *)getFeedPostGray {
    //return [UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1];
    return [UIColor colorWithRed:(232/255.0) green:(232/255.0) blue:(232/255.0) alpha:1];
}

+ (UIColor *)getNeutralYellow {
    return [UIColor colorWithRed:(247/255.0) green:(222/255.0) blue:(0/255.0) alpha:1];
}

+ (UIColor *)getBeginnerStatus {
    return [UIColor colorWithRed:(15/255.0) green:(185/255.0) blue:(177/255.0) alpha:1];
}
+ (UIColor *)getAmateurStatus {
    return [UIColor colorWithRed:(32/255.0) green:(191/255.0) blue:(107/255.0) alpha:1];
}
+ (UIColor *)getExperiencedStatus {
    return [UIColor colorWithRed:(250/255.0) green:(130/255.0) blue:(49/255.0) alpha:1];
}
+ (UIColor *)getProffesionalStatus {
    return [UIColor colorWithRed:(235/255.0) green:(59/255.0) blue:(90/255.0) alpha:1];
}

@end
