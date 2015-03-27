//
//  AppDelegate.m
//  MyPersonalLibrary
//
//  Created by Mr.OJ on 15/3/25.
//  Copyright (c) 2015年 Mr.OJ. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "YDCrashHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)installYDCrashHandler
{
    InstallCrashExceptionHandler();
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if (bYDInstallCrashHandler)
    {
        [self performSelector:@selector(installYDCrashHandler) withObject:nil afterDelay:0];
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if (![YDConfigurationHelper getBoolValueForConfigurationKey:bYDFirstLaunch])
        [YDConfigurationHelper setApplicationStartupDefaults];
    
    if (bYDActivateGPSOnStartUp)
    {
        //Start your CLLocationManager here if you're application needs the GPS
    }
    
    if (bYDRegistrationRequired && ![YDConfigurationHelper getBoolValueForConfigurationKey:bYDRegistered])
    {
        //Create an instance of your RegistrationViewcontroller
        self.registrationVC =[[YDRegistrationViewController alloc] init];
        //Set the delegate
        self.registrationVC.delegate=self;
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController = _registrationVC;
        self.window.backgroundColor = [UIColor clearColor];
        [self.window makeKeyAndVisible];
        
    }
    else
    {
        // you arrive here if either the registration is not required or yet achieved
        if (bYDLoginRequired)
        {
            self.loginVC= [[YDLoginViewController alloc] init];
            self.loginVC.delegate=self;
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            self.window.rootViewController = _loginVC;
            self.window.backgroundColor = [UIColor clearColor];
            [self.window makeKeyAndVisible];
        }
        else
        {
            self.viewController= [[ViewController alloc] init];
            self.window.rootViewController =self.viewController;
            [self.window makeKeyAndVisible];
        }
    }
    
    return YES;
}

#pragma Registration Delegates
-(void)registeredWithError
{
    //called from RegistrationViewcontroller if registration failed
}
-(void)registeredWithSuccess
{
    //called from RegistrationViewcontroller if the registration with success
    //
    if (bYDShowLoginAfterRegistration)
    {
        self.loginVC = [[YDLoginViewController alloc] init];
        self.loginVC.delegate=self;
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController = self.loginVC;
        self.window.backgroundColor = [UIColor clearColor];
        [self.window makeKeyAndVisible];
    }
    else
    {
        self.viewController= [[ViewController alloc] init];
        self.window.rootViewController =self.viewController;
        [self.window makeKeyAndVisible];
    }
}
-(void)cancelRegistration
{
    //called from RegistrationViewcontroller if cancel is pressed
}
#pragma Login delegates
-(void)loginWithSuccess
{
    //called when login with success
    self.viewController= [[ViewController alloc] init];
    self.window.rootViewController =self.viewController;
    [self.window makeKeyAndVisible];
}
-(void)loginWithError
{
    //called when login with error
}
-(void)loginCancelled
{
    //called when login is cancelled
}

@end
