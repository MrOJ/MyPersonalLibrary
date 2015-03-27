//
//  AppDelegate.h
//  MyPersonalLibrary
//
//  Created by Mr.OJ on 15/3/25.
//  Copyright (c) 2015年 Mr.OJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDRegistrationViewController.h"
#import "YDLoginViewController.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,YDLoginViewControllerDelegate,YDRegistrationViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) YDLoginViewController *loginVC;
@property (strong, nonatomic) YDRegistrationViewController *registrationVC;

@end

