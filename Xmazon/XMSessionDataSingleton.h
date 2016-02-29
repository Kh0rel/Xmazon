//
//  XMSessionDataSingleton.h
//  Xmazon
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
    NSUserDefaults* userDefault_;
    NSDictionary* currentSession_;
    XMUser* currentUser_;
    long numberTestRefreshToken_;
}

+ (XMSessionDataSingleton *)sharedSession;

@property(strong, nonatomic) NSDictionary *currentSession;
@property(strong, nonatomic) XMUser *currentUser;
@property(strong, nonatomic) NSUserDefaults* userDefault;
@property(nonatomic, nonatomic) long numberTestRefreshToken;


@end
