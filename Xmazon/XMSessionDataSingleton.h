//
//  XMSessionDataSingleton.h
//  :
//
//  Created by ekino on 27/02/16.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMUser.h"
#import "XMStore.h"

@interface XMSessionDataSingleton : NSObject
{
    @private
//    NSUserDefaults* userDefault_;
//    NSDictionary* currentSession_;
    XMUser* currentUser_;
    long numberTestRefreshToken_;
    int countRequestSend_;
    int countRequestDone_;
    int countRequestFailed_;
    NSArray* products_;
}

+ (XMSessionDataSingleton *)sharedSession;

//@property(strong, nonatomic) NSDictionary *currentSession;
@property(strong, nonatomic) XMUser *currentUser;
//@property(strong, nonatomic) NSUserDefaults* userDefault;
@property(nonatomic, nonatomic) long numberTestRefreshToken;
@property(nonatomic, nonatomic) int countRequestSend;
@property(nonatomic, nonatomic) int countRequestDone;
@property(nonatomic, nonatomic) int countRequestFailed;
@property(nonatomic, nonatomic) NSArray* products;

@end
