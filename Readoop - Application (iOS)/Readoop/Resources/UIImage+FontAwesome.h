//
//  UIImage+FontAwesome.h
//  Readoop
//
//  Created by Marin Chitan on 16/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIImage (FontAwesome)
/**
 *    This method generates an UIImage with a given FontAwesomeIcon and format parameters
 *
 *    @param    identifier    NSString that identifies the icon
 *    @param    bgColor     UIColor for background image Color
 *    @param    iconColor   UIColor for icon color
 *    @param    scale       Scale factor between the image size and the icon size
 *    @param    size        Size of the image to be generated
 *
 *    @return    Image to be used wherever you want
 */
+(UIImage*)imageWithIcon:(NSString*)identifier backgroundColor:(UIColor*)bgColor iconColor:(UIColor*)iconColor andSize:(CGSize)size;
/**
 *    This method generates an UIImage with a given FontAwesomeIcon and format parameters
 *
 *    @param    identifier    NSString that identifies the icon
 *    @param    bgColor     UIColor for background image Color
 *    @param    iconColor    UIColor for icon color
 *    @param    scale       Scale factor between the image size and the icon size
 *    @param    fontSize    Font size used to be generate the image
 *
 *    @return    Image to be used wherever you want
 */
+(UIImage*)imageWithIcon:(NSString*)identifier backgroundColor:(UIColor*)bgColor iconColor:(UIColor*)iconColor fontSize:(int)fontSize;
@end
