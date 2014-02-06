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
-(void)setUpAppKey:(NSString *)appKey;


#pragma mark - Auth Methods
/**
 *  Signs a user up with the given details
 *
 *  @param details  Details should be a dictionary with two keys, @"email" and @"password" and respective values.
 *  @param callback Method is called with a response. Response will be a NSDictionary or a NSError instance. May be nil.
 */
-(void)signUpWithDetails:(NSDictionary *)details withCallback:(void (^)(id response))callback;

/**
 *  Signs a user in with the given details
 *
 *  @param details  Details should be a dictionary with two keys, @"email" and @"password" and respective values.
 *  @param callback Method is called with a response. Response will be a NSDictionary or a NSError instance. May be nil.
 */
-(void)loginWithDetails:(NSDictionary *)details withCallback:(void (^)(id response))callback;

/**
 *  Logs out the user
 *
 *  @param callback A 200 OK should be received.
 */
-(void)logoutWithCallback:(void (^)(id response))callback;
    
#pragma mark - Data Methods
/**
 *  Saves or updates entities.
 *
 *  @param type     The type of entity
 *  @param ID       The ID of the entity. Should be nil when saving.
 *  @param data     A dictionary containing information you want to store.
 *  @param callback A block that will be called when the server returns.
 */
-(void)updateEntityWithType:(NSString *)type andId:(NSString *)ID andData:(NSDictionary *)data withCallback:(void (^)(id response))callback;

/**
 *  Retrieves the entity of type and ID.
 *
 *  @param type     The type of the entity
 *  @param ID       The required id of the entity
 *  @param callback A block that will be called when the server returns
 */
-(void)retrieveEntityWithType:(NSString *)type andId:(NSString *)ID withCallback:(void (^)(id response))callback;

/**
 *  Retrieves a collection of entities with the same type.
 *
 *  @param type     The type of entity
 *  @param callback A block that will be called when the server returns
 */
-(void)retrieveCollectionWithType:(NSString *)type withCallback:(void (^)(id response))callback;

/**
 *   Retrieves an entity of type and ID.
 *
 *  @param type     The type of the entity
 *  @param ID       The ID of the entity
 *  @param callback A block that will be called when the server returns
 */
-(void)deleteEntityWithType:(NSString *)type andId:(NSString *)ID withCallback:(void (^)(id response))callback;

#pragma mark - Notify
-(void)sendNotifcationWithTemplateName:(NSString *)templateName withCallback:(void (^)(id response))callback;
    
#pragma mark - Files
-(void)saveFileWithPath:(NSString *)filePath andKey:(NSString *)key withCallback:(void (^)(id response))callback;
-(void)retrieveFileWithKey:(NSString *)key withCallback:(void (^)(id response))callback;

    
    
@end
