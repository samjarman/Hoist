//
//  Hoist.h
//  HoistDemo
//
//  Created by Sam Jarman on 6/02/14.
//  Copyright (c) 2014 Sam Jarman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hoist : NSObject

+ (Hoist *)shared;
    
/**
 *  Sets the app key for the Hoist Api Handler.
 * This should match your app key at https://go.hoistapps.com/
 *  @param appKey a string of the app key
 */
-(void)setAppKey:(NSString *)appKey;


#pragma mark - Auth Methods
/**
 *  Signs a user up with the given details
 *
 *  @param details  Details should be a dictionary with two keys, @"email" and @"password" and respective values.
 *  @param callback Method is called with a response. Response will be a NSDictionary or a NSError instance. May be nil.
 */
-(void)signUpWithDetails:(NSDictionary *)details andCallback:(void (^)(id response))callback;

/**
 *  Signs a user in with the given details
 *
 *  @param details  Details should be a dictionary with two keys, @"email" and @"password" and respective values.
 *  @param callback Method is called with a response. Response will be a NSDictionary or a NSError instance. May be nil.
 */
-(void)loginWithDetails:(NSDictionary *)details andCallback:(void (^)(id response))callback;

/**
 *  Logs out the user
 *
 *  @param callback A 200 OK should be received.
 */
-(void)logoutWithCallback:(void (^)(id response))callback;
    
#pragma mark - Data Methods
-(void)saveOrUpdateDataWithDetails:(NSDictionary *)details andCallback:(void (^)(id response))callback;
-(void)retrieveEntityWithDetails:(NSDictionary *)details andCallback:(void (^)(id response))callback;
-(void)retrieveCollectionWithDetails:(NSDictionary *)details andCallback:(void (^)(id response))callback;
-(void)deleteEntityWithDetails:(NSDictionary *)details andCallback:(void (^)(id response))callback;

#pragma mark - Notify
-(void)sendNotifcationWithTemplateName:(NSString *)templateName andCallback:(void (^)(id response))callback;
    
#pragma mark - Files
-(void)saveFileWithPath:(NSString *)filePath andKey:(NSString *)key andCallback:(void (^)(id response))callback;
-(void)retrieveFileWithKey:(NSString *)key andCallback:(void (^)(id response))callback;

    
    
@end
