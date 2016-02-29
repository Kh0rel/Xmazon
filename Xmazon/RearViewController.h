//
//  RearViewController.h
//  Xmazon
//
//  Created by guillaume chieb bouares on 25/02/2016.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SWRevealViewController.h>
#import <RATreeView.h>
#import "HomeViewController.h"
#import "CategoryViewController.h"
#import "ProfileViewController.h"
#import "OrderHistoryViewController.h"
#import "RADataObject.h"

@interface RearViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,RATreeViewDelegate, RATreeViewDataSource>{
    NSInteger _presentedRow;
    RATreeView* _treeView;
}
@property (strong, nonatomic) IBOutlet UITableView *rearTableView;
@property (strong,nonatomic) RATreeView* treeView;

@end
