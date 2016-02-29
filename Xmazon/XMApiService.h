//
//  XMApiService.h
//  Xmazon
//
//  Created by ekino on 27/02/16.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <Mantle/MTLJSONAdapter.h>
#import "XMSessionDataSingleton.h"
#import "XMUser.h"
#import "XMStore.h"
#import "XMCategory.h"
#import "XMProduct.h"

@interface XMApiService : NSObject

//+(XMApiService*)sharedInstance;
-(void)loginWithUsername:(NSString *) username andPassword: (NSString *)password success:(void(^)(id user))successBlock andError:(void(^)(NSArray *errors))errorBlock;

-(void) getToken;

-(void)subscribe:(XMUser *) user withSuccessBlock:(void(^)(XMUser *user))success failure:(void(^)(void))failure;

-(void)getUser:(void(^)(void))success failure:(void(^)(void))failure;

-(void)getStores:(void(^)(NSArray *stores))success failure:(void(^)(void))failure;

-(void)getCategoriesByIDStore:(NSString *) uid_store withSuccess:(void(^)(NSArray *categories))success andFailure:(void(^)(void))failure;

-(void)getAllProducts:(void(^)(NSArray *products))success failure:(void(^)(void))failure;

-(void)getProductsByCategoryID:(NSString *) uid_category withSuccess:(void(^)(NSArray *products))success failure:(void(^)(void))failure;

-(void) refreshtoken:(BOOL) isTokenAppRequired success:(void(^)(void))success failure:(void(^)(void))failure;

@end
