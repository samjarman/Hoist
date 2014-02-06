//
//  Hoist.h
//  HoistDemo
//
//  Created by Sam Jarman on 6/02/14.
//  Copyright (c) 2014 Sam Jarman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hoist : NSObject

    
    
-(id)initWithAppKey:(NSString *)appKey;
    
    
//Auth Methods.
-(void)signUpWithDetails:(NSDictionary *)details andCallback:(void (^)(id response))callback;
-(void)loginWithDetails:(NSDictionary *)details andCallback:(void (^)(id response))callback;
-(void)logoutWithCallback:(void (^)(id response))callback;
    
//Data Methods
-(void)saveOrUpdateDataWithDetails:(NSDictionary *)details andCallback:(void (^)(id response))callback;
-(void)retrieveEntityWithDetails:(NSDictionary *)details andCallback:(void (^)(id response))callback;
-(void)retrieveCollectionWithDetails:(NSDictionary *)details andCallback:(void (^)(id response))callback;
-(void)deleteEntityWithDetails:(NSDictionary *)details andCallback:(void (^)(id response))callback;

//Notify
-(void)sendNotifcationWithTemplateName:(NSString *)templateName andCallback:(void (^)(id response))callback;
    
//Files
-(void)saveFileWithPath:(NSString *)filePath andKey:(NSString *)key andCallback:(void (^)(id response))callback;
-(void)retrieveFileWithKey:(NSString *)key andCallback:(void (^)(id response))callback;

    
    
@end
