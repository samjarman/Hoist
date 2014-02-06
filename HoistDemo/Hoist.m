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
    @property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
    @property (nonatomic, strong) NSString *appKey;
@end

#define AUTH_URL @"https://auth.hoi.io/"

@implementation Hoist
    
#pragma mark -
#pragma mark Initilization
    
+ (Hoist *)shared
    {
        static Hoist *_sharedSession = nil;
        static dispatch_once_t onceSessionPredicate;
        
        dispatch_once(&onceSessionPredicate, ^{
            
            _sharedSession = [[self alloc] init];
        });

        return _sharedSession;
    }
-(void) setUpOpManager{
    self.manager = [AFHTTPRequestOperationManager manager];
    [self.manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [self.manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [self.manager.requestSerializer setValue:[NSString stringWithFormat:@"Hoist %@", self.appKey] forHTTPHeaderField:@"Authorization"];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", nil];
    
}
    
-(void)setAppKey:(NSString *)appKey{
    self.appKey = appKey;
    [self setUpOpManager];
}
    

    
#pragma mark -
#pragma mark Membership
    
-(void)signUpWithDetails:(NSDictionary *)details andCallback:(void (^)(id response))callback{
    
    [self.manager POST:[NSString stringWithFormat:@"%@%@", AUTH_URL, @"user"] parameters:details success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    
    [self.manager POST:[NSString stringWithFormat:@"%@%@", AUTH_URL, @"login"] parameters:details success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
 
    
    [self.manager POST:[NSString stringWithFormat:@"%@%@", AUTH_URL, @"logout"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
