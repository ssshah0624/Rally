//
//  RallyViewController.m
//  Rally
//
//  Created by Sunny Shah on 11/20/13.
//  Copyright (c) 2013 Sunny Shah. All rights reserved.
//

#import "RallyViewController.h"
#import "ServerCalls.h"

@interface RallyViewController ()

@end

@implementation RallyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self loadBackgroundImages];
    [self addFacebookLogin];
    
}

-(void) loadBackgroundImages{
   // self.rallyBackground = [[UIImageView alloc] initWithFrame:CGRectMake(20,100, 280, 240)];
    self.rallyBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.view.layer.frame.size.width, self.view.layer.frame.size.height)];
    self.rallyBackground.image = [UIImage imageNamed:@"abhi.jpg"];
    [self.rallyBackground setAlpha:0.0f];
    CALayer * layer = [self.rallyBackground layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:5.0];
    [self.view addSubview:self.rallyBackground];

    [UIView animateWithDuration:5.0 animations:^{
        self.rallyBackground.alpha = 0.7f;
    }];
}


/*FACEBOOK STUFF */

-(void)addFacebookLogin{
    FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"basic_info"]];
    loginView.delegate = self;
    loginView.frame = CGRectOffset(loginView.frame,
                                   (self.view.center.x - (loginView.frame.size.width / 2)),
                                   ((
                                     self.view.frame.size.height/2)+100));
    [self.view addSubview:loginView];
    [loginView setAlpha:0.0f];
    [UIView animateWithDuration:5.0 animations:^{
        loginView.alpha = 1.0f;
    }];
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.publishButton.hidden = NO;
    
    //time to transition!
    [self performSegueWithIdentifier:@"postLogin" sender:self];
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.profilePic.profileID = nil;
    self.labelFirstName.text = @"";
    self.publishButton.hidden = YES;
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    self.profilePic.profileID = user.id;
    self.labelFirstName.text = [NSString stringWithFormat:
                                @"Welcome, %@", user.first_name];
    
    
    NSLog([[FBSession activeSession] accessToken]);
    NSDictionary* serverResponse = [[ServerCalls sharedServerCalls]postToken:[[FBSession activeSession] accessToken] andDate:[[FBSession activeSession] expirationDate]];
    
    
}

- (void)loginView:(FBLoginView *)loginView
      handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    if (error.fberrorShouldNotifyUser) {
        // If the SDK has a message for the user, surface it. This conveniently
        // handles cases like password change or iOS6 app slider state.
        alertTitle = @"Facebook Error";
        alertMessage = error.fberrorUserMessage;
    } else if (error.fberrorCategory == FBErrorCategoryAuthenticationReopenSession) {
        // It is important to handle session closures since they can happen
        // outside of the app. You can inspect the error for more context
        // but this sample generically notifies the user.
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
    } else if (error.fberrorCategory == FBErrorCategoryUserCancelled) {
        // The user has cancelled a login. You can inspect the error
        // for more context. For this sample, we will simply ignore it.
        NSLog(@"user cancelled login");
    } else {
        // For simplicity, this sample treats other errors blindly.
        alertTitle  = @"Unknown Error";
        alertMessage = @"Error. Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
