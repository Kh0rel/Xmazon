//
//  XMSessionDataSingleton.m
//  Xmazon
//
//  Created by ekino on 27/02/16.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import "XMSessionDataSingleton.h"

@implementation XMSessionDataSingleton
@synthesize currentSession = currentSession_;
@synthesize currentUser = currentUser_;
@synthesize userDefault = userDefault_;
@synthesize numberTestRefreshToken = numberTestRefreshToken_;


static XMSessionDataSingleton *sharedSession = nil; //static instance variable

+(XMSessionDataSingleton *)sharedSession
{
    if(sharedSession == nil)
    {
        sharedSession = [[super allocWithZone:NULL] init];
        sharedSession.numberTestRefreshToken = 0;
    }
    return sharedSession;
}

@end
