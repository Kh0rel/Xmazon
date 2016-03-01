//
//  XMDataMenu.m
//  Xmazon
//
//  Created by guillaume chieb bouares on 01/03/2016.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import "XMDataMenu.h"

@implementation XMDataMenu

@synthesize name = _name;
@synthesize item = _item;
@synthesize children = _children;

- (id)initWithName:(NSString *)name WithItem:(id)item WithChildren:(NSArray  * _Nullable )children
{
    self = [super init];
    if (self) {
        self.children = [NSArray arrayWithArray:children];
        self.name = name;
    }
    return self;
}

+ (id)dataObjectWithName:(NSString *)name WithItem:(id)item WithChildren:(NSArray  * _Nullable )children
{
    return [[self alloc] initWithName:name WithItem:item WithChildren:children];
}

@end
