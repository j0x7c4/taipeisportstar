/*
 * Copyright 2012 Facebook
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *    http://www.apache.org/licenses/LICENSE-2.0
 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "SLViewController.h"
#import "TPSSAppDelegate.h"
#import "TPSSHomeViewController.h"

@interface SLViewController () 


@property (strong, nonatomic) IBOutlet UIButton *buttonLoginLogout;
- (IBAction)buttonClickHandler:(id)sender;



@end

@implementation SLViewController
@synthesize buttonLoginLogout = _buttonLoginLogout;

- (void)viewDidLoad {    
    [super viewDidLoad];
  
	// Do any additional setup after loading the view, typically from a nib.
  [[NSNotificationCenter defaultCenter]
   addObserver:self
   selector:@selector(sessionStateChanged:)
   name:FBSessionStateChangedNotification
   object:nil];
  
}

// FBSample logic
// handler for button click, logs sessions in or out
- (IBAction)buttonClickHandler:(id)sender {
    // get the app delegate so that we can access the session property
    TPSSAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    // this button's job is to flip-flop the session from open to closed
    if (FBSession.activeSession.isOpen) {
        // if a user logs out explicitly, we delete any cached token information, and next
        // time they run the applicaiton they will be presented with log in UX again; most
        // users will simply close the app or switch away, without logging out; this will
        // cause the implicit cached-token login to occur on next launch of the application
        [appDelegate closeSession];
        
    } else {
      // The user has initiated a login, so call the openSession method
      // and show the login UX if necessary.
      
      [appDelegate openSessionWithAllowLoginUI:YES];
      UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
      TPSSHomeViewController *homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"homeViewController"];
      [self.navigationController pushViewController:homeViewController animated:YES];
      
    }
    
}

#pragma mark Template generated code

- (void)dealloc
{
    self.buttonLoginLogout = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)didReceiveMemoryWarning {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)sessionStateChanged:(NSNotification*)notification {
  //NSLog(@"%@",notification);
  if (FBSession.activeSession.isOpen) {
    [self.buttonLoginLogout setTitle:@"登出" forState:UIControlStateNormal];
  } else {
    [self.buttonLoginLogout setTitle:@"登錄" forState:UIControlStateNormal];
  }
}
#pragma mark -

@end
