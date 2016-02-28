//
//  RearViewController.h
//  Xmazon
//
//  Created by guillaume chieb bouares on 25/02/2016.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SWRevealViewController.h>
#import "HomeViewController.h"
#import "CategoryViewController.h"
#import "ProfileViewController.h"
#import "OrderHistoryViewController.h"

@interface RearViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    NSInteger _presentedRow;
}
@property (strong, nonatomic) IBOutlet UITableView *rearTableView;

@end
