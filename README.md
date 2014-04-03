Hoist
=====

Hoist client library for iOS. Allows for interactions for all API from [Hoist](http://www.hoistapps.com). It relies on the amazing [AFNetworking](https://github.com/AFNetworking/AFNetworking)
<hr>

####To set up:
*  Drag `Hoist.h` and `Hoist.m` into your project.
*  Include `Hoist.h`
*  Start an instance by calling `[Hoist shared] setUpAppKey:@"Your app key here"];` ** This is important! ** 

#####Users
There are threee methods you can use for signing up users, loggin them in, and logging them out.

`-(void)signUpWithDetails:(NSDictionary *)details withCallback:(void (^)(id response))callback;`

`-(void)loginWithDetails:(NSDictionary *)details withCallback:(void (^)(id response))callback;`

`-(void)logoutWithCallback:(void (^)(id response))callback;`

#####Entities
There are four methods for entities. These deal with saving/updating, retrieval, collection retrieval and deletion.

`-(void)updateEntityWithType:(NSString *)type andId:(NSString *)ID andData:(NSDictionary *)data withCallback:(void (^)(id response))callback;`

`-(void)retrieveEntityWithType:(NSString *)type andId:(NSString *)ID withCallback:(void (^)(id response))callback;`

`-(void)retrieveCollectionWithType:(NSString *)type withCallback:(void (^)(id response))callback;`
`-(void)deleteEntityWithType:(NSString *)type andId:(NSString *)ID withCallback:(void (^)(id response))callback;`

#####Notifications
Sending a notification is simple. Simply set up your notification and then send this method with the name.
`-(void)sendNotifcationWithTemplateName:(NSString *)templateName andBody:(NSDictionary *)body withCallback:(void (^)(id response))callback;`


#####Files
Files can be sent and retrieved from Hoist.

`-(void)saveFileWithKey:(NSString *)key andData:(NSData *)data withCallback:(void (^)(id response))callback;`

`-(void)retrieveFileWithKey:(NSString *)key withCallback:(void (^)(id response))callback;`

####NOTE: File retrieval is still a work in progress. There's something wierd with the MIME Types that I'd like to sort out. 
<hr>   
For more doucmentation, see `Hoist.h`. Happy to hear about any issues and/or pull requests.


###Cocoapods though? 
Soon! Want to fix everything first. 
