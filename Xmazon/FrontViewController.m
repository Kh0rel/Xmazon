//
//  FrontViewController.m
//  Xmazon
//
//  Created by guillaume chieb bouares on 25/02/2016.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import "FrontViewController.h"
#import <SWRevealViewController.h>

@implementation FrontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"front";
    SWRevealViewController *revealController = self.revealViewController;
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"] style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
