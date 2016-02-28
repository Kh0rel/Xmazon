//
//  XMUser.h
//  Xmazon
//
//  Created by ekino on 27/02/16.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>

@interface XMUser : MTLModel<MTLJSONSerializing>

+ (NSDictionary *) JSONKeyPathsByPropertyKey;
- (NSString *) description;

@property (strong, nonatomic) NSString* uid;
@property (strong, nonatomic) NSString* email;
@property (strong, nonatomic) NSString* password;
@property (strong, nonatomic) NSString* firstname;
@property (strong, nonatomic) NSString* lastname;
@property (strong, nonatomic) NSString* birthdate;
@end
