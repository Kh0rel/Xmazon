//
//  RearViewController.h
//  Xmazon
//
//  Created by guillaume chieb bouares on 25/02/2016.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RearViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *rearTableView;

@end
