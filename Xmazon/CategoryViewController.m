//
//  CategoryViewController.m
//  Xmazon
//
//  Created by guillaume chieb bouares on 11/02/2016.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Xmazon - Catégorie";
    
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"SimpleTableViewCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    
    return cell;
}
-(void)openCart{
    
    CartViewController* v = [CartViewController new];
    [self.navigationController pushViewController:v animated:YES];
}

@end
