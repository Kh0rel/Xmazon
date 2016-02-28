//
//  OrderHistoryViewController.m
//  Xmazon
//
//  Created by guillaume chieb bouares on 28/02/2016.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import "OrderHistoryViewController.h"

@interface OrderHistoryViewController ()

@end

@implementation OrderHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Accueil";
    SWRevealViewController *revealController = [self revealViewController];
    
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Images/reveal-icon.png"]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    UIBarButtonItem* cartButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Images/shopping-cart.png"] style:UIBarButtonItemStylePlain target:self action:@selector(openCart)];
    
    self.navigationItem.rightBarButtonItem = cartButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)openCart{
    
    CartViewController* v = [CartViewController new];
    [self.navigationController pushViewController:v animated:YES];
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
