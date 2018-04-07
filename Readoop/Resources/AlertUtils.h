//
//  AlertUtils.h
//  Readoop
//
//  Created by Marin Chitan on 10/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AlertUtils : NSObject

+ (void)showAlertModal:(NSString *)message
             withTitle:(NSString *)title
      withCancelButton:(NSString *)buttonLabel
                  onVC:(UIViewController *)vc;

+ (void)showAlertModal:(NSString *)message
             withTitle:(NSString *)title
      withActionButton:(NSString *)actionButtonLabel
      withCancelButton:(NSString *)buttonLabel
            withAction:(void (^)())actionBlock
                  onVC:(UIViewController *)vc;

+ (void)showInformation:(NSString *)message
              withTitle:(NSString *)title
       withCancelButton:(NSString *)buttonLabel
                   onVC:(UIViewController *)vc;

+ (void)showInformation:(NSString *)message
              withTitle:(NSString *)title
       withActionButton:(NSString *)actionButtonLabel
       withCancelButton:(NSString *)buttonLabel
             withAction:(void (^)())actionBlock
                   onVC:(UIViewController *)vc;

+ (void)showSuccess:(NSString *)message
              withTitle:(NSString *)title
       withCancelButton:(NSString *)buttonLabel
                   onVC:(UIViewController *)vc;

+ (void)showSuccess:(NSString *)message
          withTitle:(NSString *)title
   withActionButton:(NSString *)actionButtonLabel
         withAction:(void (^)())actionBlock
               onVC:(UIViewController *)vc;

+ (void)showSuccess:(NSString *)message
              withTitle:(NSString *)title
       withActionButton:(NSString *)actionButtonLabel
       withCancelButton:(NSString *)buttonLabel
             withAction:(void (^)())actionBlock
                   onVC:(UIViewController *)vc;

+ (void)getSuccesToastPanel:(NSString *)title
                withMessage:(NSString *)message;

+ (void)getErrorToastPanel:(NSString *)title
                withMessage:(NSString *)message;

@end
