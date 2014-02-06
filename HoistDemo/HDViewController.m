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
#define API_KEY @""

@implementation HDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[Hoist shared] setUpAppKey:API_KEY];
    //[self createUser];
    [self saveData];
}
    
-(void) createUser{
    [[Hoist shared] signUpWithDetails:@{@"email": @"fake+1@fakename.com", @"password":@"123456"} withCallback:^(id response) {
        [self login];
    }];
    
}
-(void) login {
    [[Hoist shared] loginWithDetails:@{@"email": @"fake+1@fakename.com", @"password":@"123456"} withCallback:^(id response) {
        [self logout];
    }];
    
}
-(void)logout{
    [[Hoist shared] logoutWithCallback:nil];
    
}
    
-(void) saveData {
    [[Hoist shared] updateEntityWithType:@"test" andId:nil andData:@{@"name": @"The Doctor", @"generation": @"11th"} withCallback:^(id response) {
        //Update your internal model here of the data. Store the ID on the object.
        [self getDataWithID:[response[0] objectForKey:@"_id"]];
    }];
}

-(void) getDataWithID:(NSString *)ID {
    
    [[Hoist shared] retrieveEntityWithType:@"test" andId:ID withCallback:nil];
    [self getCollection];
    [self deleteEntity:ID];
}

-(void)getCollection{
    [[Hoist shared] retrieveCollectionWithType:@"test" withCallback:nil];
}
-(void)deleteEntity:(NSString *)id{
    [[Hoist shared] deleteEntityWithType:@"test" andId:id withCallback:nil];
}

    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
