//
//  AppDelegate.m
//  PNGDecrypter
//
//  Created by Pacess HO on 23/10/11.
//  Copyright (c) 2011 Pacess HO. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AppDelegate.h"

//=====================================================================================================================
@implementation AppDelegate

//---------------------------------------------------------------------------------------------------------------------
@synthesize window;
@synthesize masterViewController;

//---------------------------------------------------------------------------------------------------------------------
static CGRect applicationFrame;
static AppDelegate *sharedDelegate = nil;

//---------------------------------------------------------------------------------------------------------------------
- (void)dealloc  {
	NSLog(@"[AppDelegate dealloc]");
    self.masterViewController = nil;
    [super dealloc];
}

#pragma mark - System callback functions
//---------------------------------------------------------------------------------------------------------------------
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions  {
	NSLog(@"[AppDelegate didFinishLaunchingWithOptions]");

	//  Init. random seed
	srandom(time(NULL));
	
	//  Rect is 320x480 which is correct for landscape mode, no need to change to 480x320 here
	applicationFrame = [[UIScreen mainScreen] applicationFrame];
	sharedDelegate = self;
	
	CGRect rect = [[UIScreen mainScreen] bounds];
	self.window = [[[UIWindow alloc] initWithFrame:rect] autorelease];
	self.masterViewController = [[[MasterViewController alloc] init] autorelease];
	[window addSubview:masterViewController.view];
	[window setBackgroundColor:[UIColor grayColor]];
	[window setCenter:CGPointMake(rect.size.width/2, rect.size.height/2)];
	[window makeKeyAndVisible];
	
    return YES;
}

//---------------------------------------------------------------------------------------------------------------------
- (void)applicationWillResignActive:(UIApplication *)application  {
	NSLog(@"[AppDelegate applicationWillResignActive]");
    [masterViewController stopApp];
}

//---------------------------------------------------------------------------------------------------------------------
- (void)applicationDidBecomeActive:(UIApplication *)application  {
	NSLog(@"[AppDelegate applicationDidBecomeActive]");
    [masterViewController startApp];
}

//---------------------------------------------------------------------------------------------------------------------
- (void)applicationWillTerminate:(UIApplication *)application  {
	NSLog(@"[AppDelegate applicationWillTerminate]");
	[masterViewController saveData];
    [masterViewController stopApp];
}

#pragma mark - Static functions
//---------------------------------------------------------------------------------------------------------------------
+ (CGRect)getApplicationFrame  {
	return applicationFrame;
}

//---------------------------------------------------------------------------------------------------------------------
+ (UIWindow *)getWindow  {
	return sharedDelegate.window;
}

@end