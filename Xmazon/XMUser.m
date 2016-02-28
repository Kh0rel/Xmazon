//
//  XMUser.m
//  Xmazon
//
//  Created by ekino on 27/02/16.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import "XMUser.h"

@implementation XMUser

+ (NSDictionary *) JSONKeyPathsByPropertyKey
{
    return @{
             @"uid" : @"uid",
             @"email" : @"email",
             @"password" : @"password",
             @"firstname" : @"firstname",
             @"lastname" : @"lastname",
             @"birthdate" : @"birthdate"
             };
}
//+ (NSValueTransformer *)birt
@end
