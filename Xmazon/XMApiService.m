//
//  XMApiService.m
//  Xmazon
//
//  Created by ekino on 27/02/16.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import "XMApiService.h"
@implementation XMApiService
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
    NSDictionary *parameters = @{TYPE_GRANT_TYPE: GRANT_TYPE, TYPE_CLIENT_ID: CLIENT_ID, TYPE_CLIENT_SECRET: CLIENT_SECRET};
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:URL_STRING]];
    [manager POST:@"/oauth/token" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSMutableDictionary* resp = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        [XMSessionDataSingleton sharedSession].currentSession = resp;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Failed to connect API : %@", error);
    }];

    }
@end
