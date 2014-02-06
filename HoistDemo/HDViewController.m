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
    @property (nonatomic, strong) Hoist *hoistAPI;
@end
#define API_KEY @"YOUR KEY HERE"

@implementation HDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.hoistAPI = [[Hoist alloc] initWithAppKey:API_KEY];
    [self createUser];
}
    
-(void) createUser{
    [self.hoistAPI signUpWithDetails:@{@"email": @"fake@fakename.com", @"password":@"123456"} andCallback:^(id response) {
        [self login];
    }];
    
}
-(void) login {
    [self.hoistAPI loginWithDetails:@{@"email": @"fake@fakename.com", @"password":@"123456"} andCallback:^(id response) {
        [self logout];
    }];
    
}
-(void)logout{
    [self.hoistAPI logoutWithCallback:nil];
    
}
    
    
    
    
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
