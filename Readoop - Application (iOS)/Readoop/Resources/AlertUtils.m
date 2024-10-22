//
//  AlertUtils.m
//  Readoop
//
//  Created by Marin Chitan on 10/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "AlertUtils.h"
#import <EHPlainAlert/EHPlainAlert.h>
#import <SCLAlertView-Objective-C/SCLAlertView.h>

@implementation AlertUtils

+ (void)showAlertModal:(NSString *)message
             withTitle:(NSString *)title
      withCancelButton:(NSString *)buttonLabel
                  onVC:(UIViewController *)vc {
    SCLAlertViewBuilder *builder = [SCLAlertViewBuilder new];
    SCLAlertViewShowBuilder *showBuilder = [SCLAlertViewShowBuilder new]
    .style(SCLAlertViewStyleError)
    .title(title)
    .closeButtonTitle(buttonLabel)
    .subTitle(message)
    .duration(0);
    [showBuilder showAlertView:builder.alertView onViewController:vc];
}

+ (void)showAlertModal:(NSString *)message
             withTitle:(NSString *)title
      withActionButton:(NSString *)actionButtonLabel
      withCancelButton:(NSString *)buttonLabel
            withAction:(void (^)())actionBlock
                  onVC:(UIViewController *)vc {
    SCLAlertViewBuilder *builder = [SCLAlertViewBuilder new]
    .addButtonWithActionBlock(actionButtonLabel, actionBlock);
    SCLAlertViewShowBuilder *showBuilder = [SCLAlertViewShowBuilder new]
    .style(SCLAlertViewStyleError)
    .title(title)
    .closeButtonTitle(buttonLabel)
    .subTitle(message)
    .duration(0);
    [showBuilder showAlertView:builder.alertView onViewController:vc];
}

+ (void)showInformation:(NSString *)message
              withTitle:(NSString *)title
       withCancelButton:(NSString *)buttonLabel
                   onVC:(UIViewController *)vc {
    SCLAlertViewBuilder *builder = [SCLAlertViewBuilder new];
    SCLAlertViewShowBuilder *showBuilder = [SCLAlertViewShowBuilder new]
    .style(SCLAlertViewStyleWarning)
    .title(title)
    .closeButtonTitle(buttonLabel)
    .subTitle(message)
    .duration(0);
    [showBuilder showAlertView:builder.alertView onViewController:vc];
}

+ (void)showInformation:(NSString *)message
              withTitle:(NSString *)title
       withActionButton:(NSString *)actionButtonLabel
       withCancelButton:(NSString *)buttonLabel
             withAction:(void (^)())actionBlock
                   onVC:(UIViewController *)vc {
    SCLAlertViewBuilder *builder = [SCLAlertViewBuilder new]
    .addButtonWithActionBlock(actionButtonLabel, actionBlock);
    SCLAlertViewShowBuilder *showBuilder = [SCLAlertViewShowBuilder new]
    .style(SCLAlertViewStyleWarning)
    .title(title)
    .closeButtonTitle(buttonLabel)
    .subTitle(message)
    .duration(0);
    [showBuilder showAlertView:builder.alertView onViewController:vc];
}

+ (void)showSuccess:(NSString *)message
          withTitle:(NSString *)title
   withCancelButton:(NSString *)buttonLabel
               onVC:(UIViewController *)vc {
    SCLAlertViewBuilder *builder = [SCLAlertViewBuilder new];
    SCLAlertViewShowBuilder *showBuilder = [SCLAlertViewShowBuilder new]
    .style(SCLAlertViewStyleSuccess)
    .title(title)
    .closeButtonTitle(buttonLabel)
    .subTitle(message)
    .duration(0);
    [showBuilder showAlertView:builder.alertView onViewController:vc];
}

+ (void)showSuccess:(NSString *)message
          withTitle:(NSString *)title
   withActionButton:(NSString *)actionButtonLabel
         withAction:(void (^)())actionBlock
               onVC:(UIViewController *)vc {
    SCLAlertViewBuilder *builder = [SCLAlertViewBuilder new]
    .addButtonWithActionBlock(actionButtonLabel, actionBlock);
    SCLAlertViewShowBuilder *showBuilder = [SCLAlertViewShowBuilder new]
    .style(SCLAlertViewStyleSuccess)
    .title(title)
    .subTitle(message)
    .duration(0);
    [showBuilder showAlertView:builder.alertView onViewController:vc];
}

+ (void)showSuccess:(NSString *)message
          withTitle:(NSString *)title
   withActionButton:(NSString *)actionButtonLabel
   withCancelButton:(NSString *)buttonLabel
         withAction:(void (^)())actionBlock
               onVC:(UIViewController *)vc {
    SCLAlertViewBuilder *builder = [SCLAlertViewBuilder new]
    .addButtonWithActionBlock(actionButtonLabel, actionBlock);
    SCLAlertViewShowBuilder *showBuilder = [SCLAlertViewShowBuilder new]
    .style(SCLAlertViewStyleSuccess)
    .title(title)
    .closeButtonTitle(buttonLabel)
    .subTitle(message)
    .duration(0);
    [showBuilder showAlertView:builder.alertView onViewController:vc];
}

+ (void)getSuccesToastPanel:(NSString *)title withMessage:(NSString *)message {
    [EHPlainAlert showAlertWithTitle:title message:message type:ViewAlertSuccess];
}

+ (void)getErrorToastPanel:(NSString *)title withMessage:(NSString *)message {
    [EHPlainAlert showAlertWithTitle:title message:message type:ViewAlertPanic];
}

+ (void)getInfoToastPanel:(NSString *)title withMessage:(NSString *)message {
    [EHPlainAlert showAlertWithTitle:title message:message type:ViewAlertError];
}

@end
