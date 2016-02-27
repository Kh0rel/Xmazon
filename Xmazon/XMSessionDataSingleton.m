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

static XMSessionDataSingleton *sharedSession = nil; //static instance variable

+(XMSessionDataSingleton *)sharedSession
{
    if(sharedSession == nil)
    {
        sharedSession = [[super allocWithZone:NULL] init];
    }
    return sharedSession;
}
@end
