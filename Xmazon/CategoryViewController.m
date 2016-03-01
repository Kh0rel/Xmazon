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
@synthesize store = store_;
@synthesize categories = categories_;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.store.name;
    [self loadCategoryByStoreID];
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
    
    
    return [self.categories count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductListViewController* productView = [[ProductListViewController alloc]init];
    productView.store = self.store;
    productView.category = [self.categories objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:productView animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"SimpleTableViewCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    XMCategory* category = [self.categories objectAtIndex:indexPath.row];
    cell.textLabel.text = category.name;
    return cell;
}
-(void)openCart{
    
    CartViewController* v = [CartViewController new];
    [self.navigationController pushViewController:v animated:YES];
}

-(void)loadCategoryByStoreID{
    XMApiService* apiService = [[XMApiService alloc]init];
    [apiService getCategoriesByIDStore:self.store.uid withSuccess:^(NSArray *categories) {
        self.categories = categories;
        if([self.categories count] == 0)
            [self noElementFound];
        [self.tableView reloadData];
    } andFailure:^{
        
    }];
    
}
-(void)noElementFound{
    
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Erreur" message:@"Pas de catégorie dans cette boutique" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}
@end
