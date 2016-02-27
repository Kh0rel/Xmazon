//
//  XMApiService.h
//  Xmazon
//
//  Created by ekino on 27/02/16.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "XMSessionDataSingleton.h"

@interface XMApiService : NSObject

//+(XMApiService*)sharedInstance;
-(void)loginWithUsername:(NSString *) username andPassword: (NSString *)password success:(void(^)(id user))successBlock andError:(void(^)(NSArray *errors))errorBlock;

-(void) getToken;
-(void) logout;
-(void) refreshToken;

@end
