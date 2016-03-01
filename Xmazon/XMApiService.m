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

static NSString* GRANT_TYPE_APP = @"client_credentials";
static NSString* GRANT_TYPE_LOGIN = @"password";
static NSString* GRANT_TYPE_REFRESH = @"refresh_token";

static NSString* CLIENT_ID = @"1221cc11-8701-45ed-8d0f-597a0cfe7931";
static NSString* CLIENT_SECRET = @"49b85211a09373aacb5ad9309d8309da32113cfb";

static NSString* TYPE_GRANT_TYPE = @"grant_type";
static NSString* TYPE_CLIENT_ID = @"client_id";
static NSString* TYPE_CLIENT_SECRET = @"client_secret";

static NSString* USERDEFAULT_KEY_USER = @"user";
static NSString* USERDEFAULT_KEY_APP = @"app";

static long MAX_TENTATIVE_REFRESH = 2;

static NSString* URL_STRING = @"http://xmazon.appspaces.fr";

-(void) getToken
{
    NSDictionary *parameters = @{TYPE_GRANT_TYPE: GRANT_TYPE_APP, TYPE_CLIENT_ID: CLIENT_ID, TYPE_CLIENT_SECRET: CLIENT_SECRET};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:URL_STRING]];
    [[manager POST:@"/oauth/token"
        parameters:parameters
           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
               [[NSUserDefaults standardUserDefaults] setObject:responseObject forKey:USERDEFAULT_KEY_APP];
               [[NSUserDefaults standardUserDefaults] synchronize];
               [self refreshtoken:TRUE success:^{
                    NSLog(@"SUCCESS REFRESH");
               } failure:^{
                   NSLog(@"FAILED REFRESH");
               }];
           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
               NSLog(@"Failed to connect API : %@", error);
           }] resume];
}

-(void) refreshtoken:(BOOL) isTokenAppRequired success:(void (^)(void))success failure:(void (^)(void))failure
{
    NSString* refresh_token = isTokenAppRequired  ?  [[[NSUserDefaults standardUserDefaults] valueForKey:USERDEFAULT_KEY_APP] valueForKey:KEY_REFRESH_TOKEN] :[[[NSUserDefaults standardUserDefaults] valueForKey:USERDEFAULT_KEY_USER] valueForKey:KEY_REFRESH_TOKEN];
    
    NSDictionary *parameters = @{TYPE_GRANT_TYPE: GRANT_TYPE_REFRESH, TYPE_CLIENT_ID: CLIENT_ID, TYPE_CLIENT_SECRET: CLIENT_SECRET, KEY_REFRESH_TOKEN: refresh_token};
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:URL_STRING]];
    [[manager POST:@"/oauth/token"
        parameters:parameters
           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
               if ( [NSUserDefaults standardUserDefaults] == nil || isTokenAppRequired)
               {
                   [[NSUserDefaults standardUserDefaults] setObject:responseObject forKey:USERDEFAULT_KEY_APP];
                   [[NSUserDefaults standardUserDefaults] synchronize];
                   NSLog(@"Refresh app token : %@", [responseObject objectForKey:KEY_ACCESS_TOKEN]);
                   success();
               }
               else
               {
                   NSLog(@"Refresh client token : %@", [responseObject objectForKey:KEY_ACCESS_TOKEN]);
                   [[NSUserDefaults standardUserDefaults] setObject:responseObject forKey:USERDEFAULT_KEY_USER];
                   [[NSUserDefaults standardUserDefaults] synchronize];
                   success();
               }
           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
               NSLog(@"Failed to connect API : %@", error);
           }] resume];
}

-(void) loginWithUsername:(NSString *)username andPassword:(NSString *)password success:(void (^)(id))successBlock andError:(void (^)(void))errorBlock
{
    NSDictionary *parameters = @{TYPE_GRANT_TYPE: GRANT_TYPE_LOGIN, TYPE_CLIENT_ID: CLIENT_ID, TYPE_CLIENT_SECRET: CLIENT_SECRET, @"username":username, @"password":password};
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:URL_STRING]];
    [[manager POST:@"/oauth/token"
       parameters:parameters
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
              [XMSessionDataSingleton sharedSession].numberTestRefreshToken = 0;
              //[XMSessionDataSingleton sharedSession].userDefault = responseObject;
              [[NSUserDefaults standardUserDefaults] setObject:responseObject forKey:USERDEFAULT_KEY_USER];
              [[NSUserDefaults standardUserDefaults] synchronize];
              successBlock(responseObject);
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              if ([[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode] == 401 && MAX_TENTATIVE_REFRESH > [XMSessionDataSingleton sharedSession].numberTestRefreshToken)
              {
                  NSLog(@"TENTATIVE REFRESH : %li", [XMSessionDataSingleton sharedSession].numberTestRefreshToken);
                  [XMSessionDataSingleton sharedSession].numberTestRefreshToken++;
                  [self refreshtoken:TRUE success:^{
                      [self getAllProducts:^(NSArray *products) {
                          //noop
                      } failure:^{
                          //noop
                      }];
                  } failure:^{
                      //noop
                  }];
              }
              else
              {
                  NSLog(@"FAILED loginWithUsername %li",  [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode]);
                  [XMSessionDataSingleton sharedSession].numberTestRefreshToken = 0;  // Il y a un autre pb qui n'est pas lié avec le refresh, donc on send message a l'user et on arrete de faire des refresh, reinit token a 0
                  errorBlock();
              }
          }] resume];
}

-(void) subscribe:(XMUser *)user withSuccessBlock:(void (^)(XMUser *))success failure:(void (^)(void))failure
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:URL_STRING]];
    NSString* accessToken = [[[NSUserDefaults standardUserDefaults] valueForKey:USERDEFAULT_KEY_APP] valueForKey:KEY_ACCESS_TOKEN];
    [manager.requestSerializer setValue:[@"Bearer " stringByAppendingString:accessToken] forHTTPHeaderField:@"Authorization"];
    
    NSDictionary *parameters = [MTLJSONAdapter JSONDictionaryFromModel:user error:nil];
    [[manager POST:@"/auth/subscribe" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [XMSessionDataSingleton sharedSession].numberTestRefreshToken = 0;
        XMUser* user = [MTLJSONAdapter modelOfClass:[XMUser class] fromJSONDictionary:[responseObject objectForKey:@"result"] error:nil];
        [XMSessionDataSingleton sharedSession].currentUser = user;
        success(user);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode] == 401 && MAX_TENTATIVE_REFRESH > [XMSessionDataSingleton sharedSession].numberTestRefreshToken)
        {
            NSLog(@"TENTATIVE REFRESH : %li", [XMSessionDataSingleton sharedSession].numberTestRefreshToken);
            [XMSessionDataSingleton sharedSession].numberTestRefreshToken++;
            [self refreshtoken:TRUE success:^{
                [self getAllProducts:^(NSArray *products) {
                    //noop
                } failure:^{
                    //noop
                }];
            } failure:^{
                //noop
            }];
        }
        else
        {
            NSLog(@"FAILED subscribe %li",  [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode]);
            [XMSessionDataSingleton sharedSession].numberTestRefreshToken = 0;  // Il y a un autre pb qui n'est pas lié avec le refresh, donc on send message a l'user et on arrete de faire des refresh, reinit token a 0
            failure();
        }
    }]resume];
}

-(void) getUser:(void(^)(void))success failure:(void(^)(void))failure
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:URL_STRING]];
    NSString* accessToken = [[[NSUserDefaults standardUserDefaults] valueForKey:USERDEFAULT_KEY_APP] valueForKey:KEY_ACCESS_TOKEN];
    [manager.requestSerializer setValue:[@"Bearer " stringByAppendingString:accessToken] forHTTPHeaderField:@"Authorization"];
    
    [[manager GET:@"/user" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [XMSessionDataSingleton sharedSession].numberTestRefreshToken = 0;
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode] == 401 && MAX_TENTATIVE_REFRESH > [XMSessionDataSingleton sharedSession].numberTestRefreshToken)
        {
            NSLog(@"TENTATIVE REFRESH : %li", [XMSessionDataSingleton sharedSession].numberTestRefreshToken);
            [XMSessionDataSingleton sharedSession].numberTestRefreshToken++;
            [self refreshtoken:TRUE success:^{
                [self getAllProducts:^(NSArray *products) {
                    //noop
                } failure:^{
                    //noop
                }];
            } failure:^{
                //noop
            }];
        }
        else
        {
            NSLog(@"FAILED getUser %li",  [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode]);
            [XMSessionDataSingleton sharedSession].numberTestRefreshToken = 0;  // Il y a un autre pb qui n'est pas lié avec le refresh, donc on send message a l'user et on arrete de faire des refresh, reinit token a 0
            failure();
        }
    }] resume];
}

-(void) getStores:(void (^)(NSArray *))success failure:(void (^)(void))failure
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:URL_STRING]];
    NSString* accessToken = [[[NSUserDefaults standardUserDefaults] valueForKey:USERDEFAULT_KEY_APP] valueForKey:KEY_ACCESS_TOKEN];
    [manager.requestSerializer setValue:[@"Bearer " stringByAppendingString:accessToken] forHTTPHeaderField:@"Authorization"];
    
    [[manager GET:@"/store/list" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [XMSessionDataSingleton sharedSession].numberTestRefreshToken = 0;
        NSArray *result = [[MTLJSONAdapter modelsOfClass:[XMStore class] fromJSONArray:[responseObject objectForKey:@"result"] error:nil] mutableCopy];
        success(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode] == 401 && MAX_TENTATIVE_REFRESH > [XMSessionDataSingleton sharedSession].numberTestRefreshToken)
        {
            NSLog(@"TENTATIVE REFRESH : %li", [XMSessionDataSingleton sharedSession].numberTestRefreshToken);
            [XMSessionDataSingleton sharedSession].numberTestRefreshToken++;
            [self refreshtoken:TRUE success:^{
                [self getAllProducts:^(NSArray *products) {
                    //noop
                } failure:^{
                    //noop
                }];
            } failure:^{
                //noop
            }];
        }
        else
        {
            NSLog(@"FAILED getStores %li",  [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode]);
            [XMSessionDataSingleton sharedSession].numberTestRefreshToken = 0;  // Il y a un autre pb qui n'est pas lié avec le refresh, donc on send message a l'user et on arrete de faire des refresh, reinit token a 0
            failure();
        }
    }] resume];
}

-(void) getCategoriesByIDStore:(NSString *)uid_store withSuccess:(void (^)(NSArray *))success andFailure:(void (^)(void))failure
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:URL_STRING]];
    NSString* accessToken = [[[NSUserDefaults standardUserDefaults] valueForKey:USERDEFAULT_KEY_APP] valueForKey:KEY_ACCESS_TOKEN];
    [manager.requestSerializer setValue:[@"Bearer " stringByAppendingString:accessToken] forHTTPHeaderField:@"Authorization"];
    
    NSDictionary *parameters = @{@"store_uid":uid_store};
    
    [[manager GET:@"/category/list" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [XMSessionDataSingleton sharedSession].numberTestRefreshToken = 0;
        NSArray *result = [[MTLJSONAdapter modelsOfClass:[XMCategory class] fromJSONArray:[responseObject objectForKey:@"result"] error:nil] mutableCopy];
        success(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode] == 401 && MAX_TENTATIVE_REFRESH > [XMSessionDataSingleton sharedSession].numberTestRefreshToken)
        {
            NSLog(@"TENTATIVE REFRESH : %li", [XMSessionDataSingleton sharedSession].numberTestRefreshToken);
            [XMSessionDataSingleton sharedSession].numberTestRefreshToken++;
            [self refreshtoken:TRUE success:^{
                [self getAllProducts:^(NSArray *products) {
                    //noop
                } failure:^{
                    //noop
                }];
            } failure:^{
                //noop
            }];
        }
        else
        {
            NSLog(@"FAILED getCategoriesByIDStore %li",  [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode]);
            [XMSessionDataSingleton sharedSession].numberTestRefreshToken = 0;  // Il y a un autre pb qui n'est pas lié avec le refresh, donc on send message a l'user et on arrete de faire des refresh, reinit token a 0
            failure();
        }
    }] resume];

}

-(void) getAllProducts:(void (^)(NSArray *))success failure:(void (^)(void))failure
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:URL_STRING]];
    NSString* accessToken = [[[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULT_KEY_USER] valueForKey:KEY_ACCESS_TOKEN];
    [manager.requestSerializer setValue:[@"Bearer " stringByAppendingString:accessToken] forHTTPHeaderField:@"Authorization"];
    
    [[manager GET:@"/product/list" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [XMSessionDataSingleton sharedSession].numberTestRefreshToken = 0;    // On reinit le nombre d'essaie du refresh token a 0
        NSArray *result = [[MTLJSONAdapter modelsOfClass:[XMCategory class] fromJSONArray:[responseObject objectForKey:@"result"] error:nil] mutableCopy];
        success(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if ([[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode] == 401 && MAX_TENTATIVE_REFRESH > [XMSessionDataSingleton sharedSession].numberTestRefreshToken)
        {
            NSLog(@"TENTATIVE REFRESH : %li", [XMSessionDataSingleton sharedSession].numberTestRefreshToken);
            [XMSessionDataSingleton sharedSession].numberTestRefreshToken++;
            [self refreshtoken:FALSE success:^{
                [self getAllProducts:^(NSArray *products) {
                    //noop
                } failure:^{
                    //noop
                }];
            } failure:^{
                //noop
            }];
        }
        else
        {
            NSLog(@"FAILED GETALLPRODUCT %li",  [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode]);
            [XMSessionDataSingleton sharedSession].numberTestRefreshToken = 0;  // Il y a un autre pb qui n'est pas lié avec le refresh, donc on send message a l'user et on arrete de faire des refresh, reinit token a 0
            failure();
        }
        
    }] resume];
}

-(void) getProductsByCategoryID:(NSString *)uid_category withSuccess:(void (^)(NSArray *))success failure:(void (^)(void))failure
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:URL_STRING]];
    //NSString* accessToken = [[XMSessionDataSingleton sharedSession].userDefault valueForKey:KEY_ACCESS_TOKEN];
    NSString* accessToken = [[[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULT_KEY_USER] valueForKey:KEY_ACCESS_TOKEN];

    [manager.requestSerializer setValue:[@"Bearer " stringByAppendingString:accessToken] forHTTPHeaderField:@"Authorization"];
    NSDictionary *parameters = @{@"category_uid":uid_category};
    [[manager GET:@"/product/list" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [XMSessionDataSingleton sharedSession].numberTestRefreshToken = 0;
        NSArray *result = [[MTLJSONAdapter modelsOfClass:[XMProduct class] fromJSONArray:[responseObject objectForKey:@"result"] error:nil] mutableCopy];
        success(result);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode] == 401 && MAX_TENTATIVE_REFRESH > [XMSessionDataSingleton sharedSession].numberTestRefreshToken)
        {
            NSLog(@"TENTATIVE REFRESH : %li", [XMSessionDataSingleton sharedSession].numberTestRefreshToken);
            [XMSessionDataSingleton sharedSession].numberTestRefreshToken++;
            [self refreshtoken:FALSE success:^{
                [self getAllProducts:^(NSArray *products) {
                    //noop
                } failure:^{
                    //noop
                }];
            } failure:^{
                //noop
            }];
        }
        else
        {
            NSLog(@"FAILED GETPRODUCTBYCAT %li",  [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode]);
            [XMSessionDataSingleton sharedSession].numberTestRefreshToken = 0;  // Il y a un autre pb qui n'est pas lié avec le refresh, donc on send message a l'user et on arrete de faire des refresh, reinit token a 0
            failure();
        }
        }] resume];
}

-(void) cheatGetAllProducts:(void (^)(NSArray *))success failure:(void (^)(void))failure
{
    [XMSessionDataSingleton sharedSession].countRequestSend = 0;
    NSMutableArray *productList = [[NSMutableArray alloc] init];
    [self getStores:^(NSArray *stores) {
                                          NSLog(@"GET ALL STORE Success : %@", stores);
                                          for (XMStore* store in stores) {
                                              [self getCategoriesByIDStore:store.uid withSuccess:^(NSArray *categories) {
                                                  NSLog(@"GET ALL Categories by store id Success : %@", categories);
        
                                                  for (XMCategory* cat in categories) {
                                                      [XMSessionDataSingleton sharedSession].countRequestSend++;
                                                               [self getProductsByCategoryID:cat.uid withSuccess:^(NSArray *products) {
                                                                   [XMSessionDataSingleton sharedSession].countRequestDone++;
                                                                   [productList addObject:products];
                                                                   if([XMSessionDataSingleton sharedSession].countRequestDone == [XMSessionDataSingleton sharedSession].countRequestSend)
                                                                   {
                                                                       success(productList);
                                                                   }
                                                               } failure:^{
                                                                   NSLog(@"GET products by cat FAILED");
                                                               }];
                                                  }
                                              } andFailure:^{
                                                  NSLog(@"GET ALL Categories by store id FAILED");
                                              }];
                                          }
        
        
                                      } failure:^{
                                          NSLog(@"GET ALL STORE FAILED");
                                      }];
}

@end
