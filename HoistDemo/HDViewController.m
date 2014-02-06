//
//  HDViewController.m
//  HoistDemo
//
//  Created by Sam Jarman on 6/02/14.
//  Copyright (c) 2014 Sam Jarman. All rights reserved.
//

#import "HDViewController.h"
#import "Hoist.h"
@interface HDViewController ()
@end
#define API_KEY @"YOUR KEY HERE"

@implementation HDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[Hoist shared] setAppKey:API_KEY];
    [self createUser];
}
    
-(void) createUser{
    [[Hoist shared] signUpWithDetails:@{@"email": @"fake@fakename.com", @"password":@"123456"} andCallback:^(id response) {
        [self login];
    }];
    
}
-(void) login {
    [[Hoist shared] loginWithDetails:@{@"email": @"fake@fakename.com", @"password":@"123456"} andCallback:^(id response) {
        [self logout];
    }];
    
}
-(void)logout{
    [[Hoist shared] logoutWithCallback:nil];
    
}
    
    
    
    
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
