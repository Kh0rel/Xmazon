//
//  XMDataMenu.h
//  Xmazon
//
//  Created by guillaume chieb bouares on 01/03/2016.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMDataMenu : NSObject{
    NSString* _name;
    id _item;
    NSArray *_children;
}
@property (strong,nonatomic)NSString* name;
@property (strong, nonatomic)id item;
@property (strong, nonatomic)NSArray *children;

- (id)initWithName:(NSString *)name WithItem:(id)item WithChildren:(NSArray  * _Nullable )children;
+ (id)dataObjectWithName:(NSString *)name WithItem:(id)item WithChildren:(NSArray  * _Nullable )children;
@end
