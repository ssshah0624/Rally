//
//  ServerCalls.h
//  Rally
//
//  Created by Sunny Shah on 11/20/13.
//  Copyright (c) 2013 Sunny Shah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServerCalls : UIViewController

+ (ServerCalls *)sharedServerCalls;

-(NSDictionary*)postToken:(NSString*)token
                  andDate:(NSDate*)date;

@end
