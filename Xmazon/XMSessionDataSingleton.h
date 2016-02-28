//
//  XMSessionDataSingleton.h
//  Xmazon
//
//  Created by ekino on 27/02/16.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMUser.h"
@interface XMSessionDataSingleton : NSObject
{
    @private
    NSDictionary* currentSession_;
    XMUser* currentUser_;
}

+ (XMSessionDataSingleton *)sharedSession;

@property(strong, nonatomic) NSDictionary *currentSession;
@property(strong, nonatomic) XMUser *currentUser;


@end
