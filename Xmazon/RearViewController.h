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
#import "XMDataMenu.h"
#import "RATableViewCell.h"
#import "XMSessionDataSingleton.h"
#import "XMApiService.h"
@interface RearViewController : UIViewController <RATreeViewDelegate, RATreeViewDataSource>{
    NSInteger _presentedRow;
    RATreeView* _treeView;
    NSArray* _data;
}
@property (strong, nonatomic) IBOutlet UITableView *rearTableView;
@property (strong,nonatomic) RATreeView* treeView;
@property (strong, nonatomic)NSArray* data;
@end
