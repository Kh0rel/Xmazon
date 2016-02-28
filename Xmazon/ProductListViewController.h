//
//  ProductListViewController.h
//  Xmazon
//
//  Created by guillaume chieb bouares on 03/02/2016.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SWRevealViewController.h>
#import "ProductTableViewCell.h"
#import "CartViewController.h"
@interface ProductListViewController : UIViewController <UITableViewDelegate, UITableViewDelegate>
{
    @private
    NSMutableArray* name_;
    NSMutableArray* price_;
}

@property(nonatomic,strong)NSMutableArray* name;
@property(nonatomic,strong)NSMutableArray* price;
-(void)openCart;
@end
