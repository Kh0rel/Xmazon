//
//  XMSessionDataSingleton.h
//  Xmazon
//
//  Created by ekino on 27/02/16.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMSessionDataSingleton : NSObject
{
    @private
    NSMutableDictionary* currentSession_;
}

+ (XMSessionDataSingleton *)sharedSession;

@property(strong, nonatomic) NSMutableDictionary *currentSession;

@end
