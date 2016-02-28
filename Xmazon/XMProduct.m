//
//  XMProduct.m
//  Xmazon
//
//  Created by ekino on 28/02/16.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import "XMProduct.h"

@implementation XMProduct

@synthesize name;
@synthesize price;
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid": @"uid",
             @"name": @"name",
             @"price": @"price",
             @"available": @"available"
             };
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"Product : %@, %f", name, price];
}
@end
