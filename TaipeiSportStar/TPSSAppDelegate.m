//
//  TPSSAppDelegate.m
//  TaipeiSportStar
//
//  Created by Jie on 12/5/12.
//  Copyright (c) 2012 Jie. All rights reserved.
//

#import "TPSSAppDelegate.h"

NSString *const FBSessionStateChangedNotification =
@"com.tpss.Login:FBSessionStateChangedNotification";

@implementation TPSSAppDelegate
@synthesize window = _window;


/*
 * If we have a valid session at the time of openURL call, we handle
 * Facebook transitions by passing the url argument to handleOpenURL
 */
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
  // attempt to extract a token from the url
  return [FBSession.activeSession handleOpenURL:url];
}

// FBSample logic
// Whether it is in applicationWillTerminate, in applicationDidEnterBackground, or in some other part
// of your application, it is important that you close an active session when it is no longer useful
// to your application; if a session is not properly closed, a retain cycle may occur between the block
// and an object that holds a reference to the session object; close releases the handler, breaking any
// inadvertant retain cycles
- (void)applicationWillTerminate:(UIApplication *)application {
  // FBSample logic
  // if the app is going away, we close the session if it is open
  // this is a good idea because things may be hanging off the session, that need
  // releasing (completion block, etc.) and other components in the app may be awaiting
  // close notification in order to do cleanup
  [FBSession.activeSession close];
}

// FBSample logic
// It is possible for the user to switch back to your application, from the native Facebook application,
// when the user is part-way through a login; You can check for the FBSessionStateCreatedOpenening
// state in applicationDidBecomeActive, to identify this situation and close the session; a more sophisticated
// application may choose to notify the user that they switched away from the Facebook application without
// completely logging in
- (void)applicationDidBecomeActive:(UIApplication *)application {
  /*
   Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   */
  
  // We need to properly handle activation of the application with regards to Facebook Login
  // (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
  [FBSession.activeSession handleDidBecomeActive];
}

/*
 * Callback for session changes.
 */
- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
  switch (state) {
    case FBSessionStateOpen:
      if (!error) {
        // We have a valid session
        NSLog(@"User session found");
      }
      break;
    case FBSessionStateClosed:
    case FBSessionStateClosedLoginFailed:
      [FBSession.activeSession closeAndClearTokenInformation];
      break;
    default:
      break;
  }
  
  [[NSNotificationCenter defaultCenter]
   postNotificationName:FBSessionStateChangedNotification
   object:session];
  
  if (error) {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Error"
                              message:error.localizedDescription
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    [alertView show];
  }
}

/*
 * Opens a Facebook session and optionally shows the login UX.
 */
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
  NSArray *permissions = [[NSArray alloc] initWithObjects:
                          @"create_event",
                          @"rsvp_event",
                          nil];

  return [FBSession openActiveSessionWithPublishPermissions:permissions
                                            defaultAudience:FBSessionDefaultAudienceEveryone
                                               allowLoginUI:allowLoginUI
                                          completionHandler:^(FBSession *session,
                                                              FBSessionState state,
                                                              NSError *error) {
                                            [self sessionStateChanged:session
                                                                state:state
                                                                error:error];
                                          }];
}

- (void) closeSession {
  [FBSession.activeSession closeAndClearTokenInformation];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  return YES;
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


@end
