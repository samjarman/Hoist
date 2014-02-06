//
//  Hoist.m
//  HoistDemo
//
//  Created by Sam Jarman on 6/02/14.
//  Copyright (c) 2014 Sam Jarman. All rights reserved.
//

#import "Hoist.h"
#import <AFNetworking/AFNetworking.h>
@interface Hoist ()
    @property (nonatomic, strong) NSString *appKey;
@end

#define AUTH_URL @"https://auth.hoi.io/"

@implementation Hoist
    
#pragma mark -
#pragma mark Initilization
-(id)initWithAppKey:(NSString *)appKey{
    Hoist *h = [[Hoist alloc] init];
    h.appKey = appKey;
    return h;
}
    
#pragma mark -
#pragma mark Membership
    
-(void)signUpWithDetails:(NSDictionary *)details andCallback:(void (^)(id response))callback{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Hoist %@", self.appKey] forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", nil];
    
    [manager POST:[NSString stringWithFormat:@"%@%@", AUTH_URL, @"user"] parameters:details success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"User Created: %@", [responseObject description]);
        if (callback) {
            callback(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"User creation failed: ");
        if (callback) {
            callback(error);
        }
    }];
}

-(void)loginWithDetails:(NSDictionary *)details andCallback:(void (^)(id response))callback{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Hoist %@", self.appKey] forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", nil];
    
    [manager POST:[NSString stringWithFormat:@"%@%@", AUTH_URL, @"login"] parameters:details success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"User Logged in: %@", [responseObject description]);
        if (callback) {
            callback(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"User login failed: ");
        if (callback) {
            callback(error);
        }
    }];

    
}

    
-(void)logoutWithCallback:(void (^)(id response))callback{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Hoist %@", self.appKey] forHTTPHeaderField:@"Authorization"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", nil];
    
    [manager POST:[NSString stringWithFormat:@"%@%@", AUTH_URL, @"logout"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"User logged out: %@", [responseObject description]);
        if (callback) {
            callback(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"User logout failed: ");
        if (callback) {
            callback(error);
        }
    }];
    
}
   

    
@end
