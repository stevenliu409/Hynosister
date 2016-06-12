//
//  AppDelegate.m
//  Hypnosister
//
//  Created by Steven Liu on 2016-05-19.
//  Copyright © 2016 Steven Liu. All rights reserved.
//

#import "AppDelegate.h"
#import "BNRHypnosisView.h"
#import "ViewController.h"

@interface AppDelegate () <UIScrollViewDelegate>
@property (strong, nonatomic) BNRHypnosisView *firstView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ViewController *rootVC = [[ViewController alloc] init];
    [self.window setRootViewController:rootVC];

    // Create CGRect for frames
    
    CGRect screenRect = self.window.bounds;
    CGRect bigRect = screenRect;
    
    // make the scroll content 2x of the screen
    bigRect.size.width *= 2;
//    bigRect.size.height *= 2;
    

    // Create the screen-size scroll view and add it to the window
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
    scrollView.delegate = self;
//    [scrollView setPagingEnabled:YES];
    [rootVC.view addSubview:scrollView]; //need to add subview to rootViewController and not the app delegate window
    
    self.firstView = [[BNRHypnosisView alloc] initWithFrame:screenRect];
    [scrollView addSubview:self.firstView];
    
    // setup zoom
    scrollView.minimumZoomScale = 1.0;
    scrollView.maximumZoomScale = 2.0;
    
    // Add a second screen-sized hypnosis view just off screen to the right
//    screenRect.origin.x += screenRect.size.width; // scroll to the right (1 screen to the right)
//    BNRHypnosisView *anotherView = [[BNRHypnosisView alloc] initWithFrame:screenRect];
//    [scrollView addSubview:anotherView]; // Add the new view
//    
//    scrollView.contentSize = bigRect.size; // Tell the scroll view how big is the content
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.firstView;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
