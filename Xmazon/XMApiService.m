//
//  XMApiService.m
//  Xmazon
//
//  Created by ekino on 27/02/16.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import "XMApiService.h"
@implementation 	XMApiService
static NSString* TYPE_POST = @"POST";
static NSString* TYPE_GET = @"GET";

static NSString* KEY_REFRESH_TOKEN = @"refresh_token";
static NSString* KEY_TOKEN_TYPE = @"token_type";
static NSString* KEY_ACCESS_TOKEN = @"access_token";
static NSString* KEY_EXPIRES_IN = @"expires_in";

static NSString* REFRESH_TOKEN = nil;
static NSString* GRANT_TYPE = @"client_credentials";
static NSString* CLIENT_ID = @"1221cc11-8701-45ed-8d0f-597a0cfe7931";
static NSString* CLIENT_SECRET = @"49b85211a09373aacb5ad9309d8309da32113cfb";

static NSString* TYPE_GRANT_TYPE = @"grant_type";
static NSString* TYPE_CLIENT_ID = @"client_id";
static NSString* TYPE_CLIENT_SECRET = @"client_secret";

static NSString* URL_STRING = @"http://xmazon.appspaces.fr";
//static NSURL* URL = [NSURL URLWithString:URL_STRING];

-(void) getToken
{
    NSString* post = [NSString stringWithFormat:@"grant_type=%@&client_id=%@&client_secret=%@", GRANT_TYPE, CLIENT_ID, CLIENT_SECRET];
    
    NSString* url = [URL_STRING stringByAppendingString:@"/oauth/token/"];
    NSURLSession* session = [NSURLSession sharedSession];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = TYPE_POST;
    request.HTTPBody = [post dataUsingEncoding:NSUTF8StringEncoding];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error)
        {
            NSLog(@"%@", error);
        }
        else
        {
            NSMutableDictionary* resp = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            [XMSessionDataSingleton sharedSession].currentSession = resp;
            NSLog(@"Response : %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        }
    }] resume];
}


-(void) loginWithUsername:(NSString *)username andPassword:(NSString *)password success:(void (^)(id))successBlock andError:(void (^)(NSArray *))errorBlock
{
    NSDictionary *parameters = @{TYPE_GRANT_TYPE: GRANT_TYPE, TYPE_CLIENT_ID: CLIENT_ID, TYPE_CLIENT_SECRET: CLIENT_SECRET, @"email":username, @"password":password};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:URL_STRING]];
    [[manager POST:@"/oauth/token"
       parameters:parameters
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
              [XMSessionDataSingleton sharedSession].currentSession = responseObject;
              successBlock(responseObject);
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              NSLog(@"Failed to connect API : %@", error);
          }] resume];
}
-(void) subscribe:(XMUser *)user withSuccessBlock:(void (^)(XMUser *))success failure:(void (^)(void))failure
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:URL_STRING]];
    NSString* accessToken = [[XMSessionDataSingleton sharedSession].currentSession valueForKey:KEY_ACCESS_TOKEN];
    [manager.requestSerializer setValue:[@"Bearer " stringByAppendingString:accessToken] forHTTPHeaderField:@"Authorization"];
    
    NSDictionary *parameters = [MTLJSONAdapter JSONDictionaryFromModel:user error:nil];
    [[manager POST:@"/auth/subscribe" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //NSDictionary* kzd = responseObject;
        //NSDictionary* aaz = [responseObject objectForKey:@]
        XMUser* user = [MTLJSONAdapter modelOfClass:[XMUser class] fromJSONDictionary:[responseObject objectForKey:@"result"] error:nil];
        [XMSessionDataSingleton sharedSession].currentUser = user;
        success(user);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
    }]resume];
}

-(void) getUser:(void(^)(void))success failure:(void(^)(void))failure
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:URL_STRING]];
    NSString* accessToken = [[XMSessionDataSingleton sharedSession].currentSession valueForKey:KEY_ACCESS_TOKEN];
    [manager.requestSerializer setValue:[@"Bearer " stringByAppendingString:accessToken] forHTTPHeaderField:@"Authorization"];
    
    [[manager GET:@"/user" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
    }] resume];
}

-(void) getStores:(void (^)(NSArray *))success failure:(void (^)(void))failure
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:URL_STRING]];
    NSString* accessToken = [[XMSessionDataSingleton sharedSession].currentSession valueForKey:KEY_ACCESS_TOKEN];
    [manager.requestSerializer setValue:[@"Bearer " stringByAppendingString:accessToken] forHTTPHeaderField:@"Authorization"];
    
    [[manager GET:@"/store/list" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSArray *result = [[MTLJSONAdapter modelsOfClass:[XMStore class] fromJSONArray:[responseObject objectForKey:@"result"] error:nil] mutableCopy];
        success(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
    }] resume];
}

-(void) getCategoriesByIDStore:(NSString *)uid_store withSuccess:(void (^)(NSArray *))success andFailure:(void (^)(void))failure
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:URL_STRING]];
    NSString* accessToken = [[XMSessionDataSingleton sharedSession].currentSession valueForKey:KEY_ACCESS_TOKEN];
    [manager.requestSerializer setValue:[@"Bearer " stringByAppendingString:accessToken] forHTTPHeaderField:@"Authorization"];
    
    NSDictionary *parameters = @{@"store_uid":uid_store};
    
    [[manager GET:@"/category/list" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSArray *result = [[MTLJSONAdapter modelsOfClass:[XMCategory class] fromJSONArray:[responseObject objectForKey:@"result"] error:nil] mutableCopy];
        success(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
    }] resume];

}

-(void) getAllProducts:(void (^)(NSArray *))success failure:(void (^)(void))failure
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:URL_STRING]];
    NSString* accessToken = [[XMSessionDataSingleton sharedSession].currentSession valueForKey:KEY_ACCESS_TOKEN];
    [manager.requestSerializer setValue:[@"Bearer " stringByAppendingString:accessToken] forHTTPHeaderField:@"Authorization"];
    
    [[manager GET:@"/product/list" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSArray *result = [[MTLJSONAdapter modelsOfClass:[XMCategory class] fromJSONArray:[responseObject objectForKey:@"result"] error:nil] mutableCopy];
        success(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
    }] resume];
}

-(void) getProductsByCategoryID:(NSString *)uid_category withSuccess:(void (^)(NSArray *))success failure:(void (^)(void))failure
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:URL_STRING]];
    NSString* accessToken = [[XMSessionDataSingleton sharedSession].currentSession valueForKey:KEY_ACCESS_TOKEN];
    [manager.requestSerializer setValue:[@"Bearer " stringByAppendingString:accessToken] forHTTPHeaderField:@"Authorization"];
    
    NSDictionary *parameters = @{@"category_uid":uid_category};
    
    [[manager GET:@"/product/list" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSArray *result = [[MTLJSONAdapter modelsOfClass:[XMCategory class] fromJSONArray:[responseObject objectForKey:@"result"] error:nil] mutableCopy];
        success(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure();
    }] resume];
}

@end
