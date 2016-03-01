//
//  HomeViewController.h
//  Xmazon
//
//  Created by guillaume chieb bouares on 20/01/2016.
//  Copyright (c) 2016 com.esgi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SWRevealViewController.h>
#import "CartViewController.h"
#import "XMSessionDataSingleton.h"
#import "XMApiService.h"
#import "XMProduct.h"
@interface HomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSArray* _products;
}
@property(strong,nonatomic)NSArray* products;
@property (strong, nonatomic) IBOutlet UITableView *productTableView;

-(void)openCart;
-(void)loadProduct;
@end
