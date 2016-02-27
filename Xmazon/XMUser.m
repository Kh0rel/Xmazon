//
//  XMUser.m
//  Xmazon
//
//  Created by ekino on 27/02/16.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import "XMUser.h"

@implementation XMUser
@synthesize email = email_;
@synthesize password = password_;
@synthesize firstname = firstname_;
@synthesize lastname = lastname_;
@synthesize birthdate = birthdate_;

+ (NSDictionary *) JSONKeyPathsByPropertyKey
{
    return @{
             @"email" : @"email",
             @"password" : @"password",
             @"firstname" : @"firstname",
             @"lastname" : @"lastname",
             @"birthdate" : @"birthdate"
             };
}

//+ (NSValueTransformer *)birt
@end
