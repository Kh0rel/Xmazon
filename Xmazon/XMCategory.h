//
//  XMCategory.h
//  Xmazon
//
//  Created by ekino on 28/02/16.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface XMCategory : MTLModel<MTLJSONSerializing>

+ (NSDictionary *) JSONKeyPathsByPropertyKey;
- (NSString *) description;

@property (strong, nonatomic) NSString* uid;
@property (strong, nonatomic) NSString* name;

@end
