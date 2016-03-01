//
//  CategoryViewController.h
//  Xmazon
//
//  Created by guillaume chieb bouares on 11/02/2016.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SWRevealViewController.h>
#import "CartViewController.h"
#import "XMApiService.h"
#import "XMCategory.h"
@interface CategoryViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    @public
    NSArray* _categories;
    XMStore* _store;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray* categories;
@property (strong,nonatomic) XMStore* store;
-(void)openCart;
-(void)loadCategoryByStoreID;
@end
