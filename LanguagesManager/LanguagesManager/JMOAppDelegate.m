//
//  JMOAppDelegate.m
//  LanguagesManager
//
//  Created by Jerome Morissard on 12/10/13.
//  Copyright (c) 2013 Jerome Morissard. All rights reserved.
//

#import "JMOAppDelegate.h"
#import "JMOViewController.h"
#import "LanguagesManager.h"

@implementation JMOAppDelegate

static dispatch_once_t firstLaunch;

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    dispatch_once(&firstLaunch, ^{
        [self launchApplication];
    });
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    dispatch_once(&firstLaunch, ^{
        [self launchApplication];
    });
    return YES;
}

- (void)launchApplication
{
    [[LanguagesManager sharedInstance] setNotificationEnable:YES];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[[JMOViewController alloc] initWithNibName:nil bundle:nil]];
    navController.navigationBarHidden = YES;
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
}

- (void)switchLanguageReloadingRootVc:(BOOL)reloadRootVc
{
    if([[[LanguagesManager sharedInstance] currentLanguage] isEqualToString:@"fr"]) {
//        [[LanguagesManager sharedInstance] setLanguage:@"en"];
        JMOSetEnglish();
    }
    else {
//        [[LanguagesManager sharedInstance] setLanguage:@"fr"];
        JMOSetFrench();
    }
    
    if (YES == reloadRootVc) {
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[[JMOViewController alloc] initWithNibName:nil bundle:nil]];
        navController.navigationBarHidden = YES;
        self.window.rootViewController = navController;
        
        [UIView transitionWithView:self.window duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        } completion:nil];
    }
}

@end
