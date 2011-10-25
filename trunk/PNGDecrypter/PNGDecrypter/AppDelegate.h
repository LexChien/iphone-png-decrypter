//
//  AppDelegate.h
//  PNGDecrypter
//
//  Created by Pacess HO on 23/10/11.
//  Copyright (c) 2011 Pacess HO. All rights reserved.
//

#import <UIKit/UIKit.h>

//---------------------------------------------------------------------------------------------------------------------
@class MasterViewController;

//=====================================================================================================================
@interface AppDelegate : NSObject <UIApplicationDelegate>  {
    UIWindow *window;
	MasterViewController *masterViewController;
}

//---------------------------------------------------------------------------------------------------------------------
@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) MasterViewController *masterViewController;

//---------------------------------------------------------------------------------------------------------------------
- (void)dealloc;

//  System callback functions
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)applicationWillResignActive:(UIApplication *)application;
- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillTerminate:(UIApplication *)application;

//  Static functions
+ (CGRect)getApplicationFrame;
+ (UIWindow *)getWindow;

@end