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

#define AUTH_URL @"https://auth.hoi.io"
#define DATA_URL @"https://data.hoi.io"
#define NOTIFY_URL @"https://notify.hoi.io"
#define FILES_URL @"https://file.hoi.io"

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
    [self.manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [self.manager.requestSerializer setValue:[NSString stringWithFormat:@"Hoist %@", self.appKey] forHTTPHeaderField:@"Authorization"];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"application/octet-stream", @"image/png", nil];
    
}
    
-(void)setUpAppKey:(NSString *)appKey{
    self.appKey = appKey;
    [self setUpOpManager];
}
    

    
#pragma mark -
#pragma mark Membership
    
-(void)signUpWithDetails:(NSDictionary *)details withCallback:(void (^)(id response))callback{
    
    [self.manager POST:[NSString stringWithFormat:@"%@/%@", AUTH_URL, @"user"] parameters:details success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

-(void)loginWithDetails:(NSDictionary *)details withCallback:(void (^)(id response))callback{
    
    [self.manager POST:[NSString stringWithFormat:@"%@/%@", AUTH_URL, @"login"] parameters:details success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
 
    
    [self.manager POST:[NSString stringWithFormat:@"%@/%@", AUTH_URL, @"logout"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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



#pragma mark - Data Methods
-(void)updateEntityWithType:(NSString *)type andId:(NSString *)ID andData:(NSDictionary *)data withCallback:(void (^)(id response))callback{

    NSString *url =[NSString stringWithFormat:@"%@/%@", DATA_URL, type];
    if (ID) {
        url = [url stringByAppendingString:[NSString stringWithFormat:@"/%@", ID]];
    }
    
    [self.manager POST:url parameters:data success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Update data successful: %@", [responseObject description]);
        if (callback) {
            callback(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Update data failed: %@", [error description]);
        if (callback) {
            callback(error);
        }
    }];




}
-(void)retrieveEntityWithType:(NSString *)type andId:(NSString *)ID withCallback:(void (^)(id response))callback{
    
    [self.manager GET:[NSString stringWithFormat:@"%@/%@/%@", DATA_URL, type, ID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Retrive data successful: %@", [responseObject description]);
        if (callback) {
            callback(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Retrive data failed: %@", [error description]);
        if (callback) {
            callback(error);
        }
    }];
}
-(void)retrieveCollectionWithType:(NSString *)type withCallback:(void (^)(id response))callback{
    [self.manager GET:[NSString stringWithFormat:@"%@/%@", DATA_URL, type] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Retrive collection successful: %@", [responseObject description]);
        if (callback) {
            callback(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Retrive collection failed: %@", [error description]);
        if (callback) {
            callback(error);
        }
    }];
}
-(void)deleteEntityWithType:(NSString *)type andId:(NSString *)ID withCallback:(void (^)(id response))callback{

    [self.manager DELETE:[NSString stringWithFormat:@"%@/%@/%@", DATA_URL, type, ID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Delete data successful: %@", [responseObject description]);
        if (callback) {
            callback(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Delete data failed: %@", [error description]);
        if (callback) {
            callback(error);
        }
    }];
    

}

#pragma mark - Notify
-(void)sendNotifcationWithTemplateName:(NSString *)templateName andBody:(NSDictionary *)body withCallback:(void (^)(id response))callback{
    
    [self.manager POST:[NSString stringWithFormat:@"%@/%@/%@", NOTIFY_URL, @"notification", templateName] parameters:body success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Notification sent successful: %@", [responseObject description]);
        if (callback) {
            callback(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Notification failed: %@", [error description]);
        if (callback) {
            callback(error);
        }
    }];
}

#pragma mark - Files
-(void)saveFileWithKey:(NSString *)key andData:(NSData *)data withCallback:(void (^)(id response))callback{
    [self.manager POST:[NSString stringWithFormat:@"%@/%@", FILES_URL, key] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
       // [formData appendPartWithFormData:data name:@"file"];
        [formData appendPartWithFileData:data name:@"file" fileName:key mimeType:@"application/octet-stream"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"File saved successful: %@", [responseObject description]);
        if (callback) {
            callback(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"File save failed: %@", [error description]);
        if (callback) {
            callback(error);
        }
    }];
    
}
-(void)retrieveFileWithKey:(NSString *)key withCallback:(void (^)(id response))callback{
    
    [self.manager GET:[NSString stringWithFormat:@"%@/%@", FILES_URL, key] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"File retrieved successful: %@", [responseObject description]);
        if (callback) {
            callback(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"File retrieve failed: %@", [error description]);
        if (callback) {
            callback(error);
        }
    }];

}


    
@end

