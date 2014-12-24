//
//  AppDelegate.m
//  FunctionManager
//
//  Created by Tops on 12/23/14.
//  Copyright (c) 2014 Tops Technology Pvt.Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "FunctionManager.h"
#import "ViewController.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //self.window.backgroundColor = [UIColor whiteColor];
     ViewController *viewObj =[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    
    UINavigationController *navObj =[[UINavigationController alloc] initWithRootViewController:viewObj];
    
   
    self.window.rootViewController=navObj;
    [self.window makeKeyAndVisible];
    
    NSString *strTemp =@"          ABCd         ";
    //NSLog(@"Before trimWhiteSpace=%@",strTemp);
    //NSLog(@"After trimWhiteSpace=%@",[FunctionManager trimWhiteSpace:strTemp]);
    
    strTemp=[FunctionManager trimWhiteSpace:strTemp];
    if ([FunctionManager stringIsBlankOrNot:strTemp]) {
        NSLog(@"Yes Blank");
    }
    else {
        NSLog(@"NO not blank");
        NSLog(@"Before trimWhiteSpace=%@",strTemp);
    }
    
    
    //Code for below IOS 8 versions not for IOS8
    
    //[FunctionManager showMessage:@"GymPal" withMessage:@"Good" withDelegage:nil];
    //[FunctionManager showMessageWithConfirm:@"GymPal" withMessage:@"Are you sure?" withTag:1 withDelegage:self];
    //[FunctionManager showMessageWithButtons:@"GymPal" withMessage:@"Select Options" withOtherButtons:@"1,2,3,4,5,6" withTag:1 withDelegage:self];
    
    
    //UIImageView *imgV=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
   // UIImage *newImage =[FunctionManager imageScaleAndCropToMaxSize:imgV.image withSize:CGSizeMake(20, 20)];
    
    return YES;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag==1) {
        if (buttonIndex==0) {
            NSLog(@"0");
        }
        else if (buttonIndex==1){
            NSLog(@"1");
        }
        else{
            NSLog(@"buttnonIndex=%ld",(long)buttonIndex);
        }
    }
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
