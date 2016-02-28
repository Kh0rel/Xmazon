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
@interface CategoryViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
-(void)openCart;
@end
