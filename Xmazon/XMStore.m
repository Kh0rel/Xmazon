//
//  XMStore.m
//  Xmazon
//
//  Created by ekino on 28/02/16.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import "XMStore.h"

@implementation XMStore
@synthesize name;
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid": @"uid",
             @"name": @"name"
             };
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"Store : %@", name];
}

@end

