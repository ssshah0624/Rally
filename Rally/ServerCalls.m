//
//  ServerCalls.m
//  Rally
//
//  Created by Sunny Shah on 11/20/13.
//  Copyright (c) 2013 Sunny Shah. All rights reserved.
//

#import "ServerCalls.h"

@interface ServerCalls ()

@end

@implementation ServerCalls

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
 Initialize this class to serve as a shared repo for server call functions
 */
static ServerCalls * _sharedInstance = nil;
+ (ServerCalls *)sharedServerCalls
{
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
