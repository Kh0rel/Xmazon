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
#import "XMCategory.h"
#import "XMStore.h"
#import "XMProduct.h"
#import "XMApiService.h"
@interface ProductListViewController : UIViewController <UITableViewDelegate, UITableViewDelegate>
{
    @private
    XMCategory* category_;
    XMStore* store_;
    NSArray* products_;
    
}

@property (strong, nonatomic) IBOutlet UITableView *productTableView;
@property(nonatomic,strong)XMCategory* category;
@property(nonatomic,strong)XMStore* store;
@property(nonatomic,strong)NSArray* products;
-(void)openCart;
-(void)loadProduct;
@end
