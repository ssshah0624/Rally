//
//  RallyViewController.h
//  Rally
//
//  Created by Sunny Shah on 11/20/13.
//  Copyright (c) 2013 Sunny Shah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface RallyViewController : UIViewController <FBLoginViewDelegate>
@property (weak, nonatomic) IBOutlet FBProfilePictureView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *labelFirstName;
@property (weak, nonatomic) IBOutlet UIButton *publishButton;

@property IBOutlet UIImageView *rallyBackground;

@end
