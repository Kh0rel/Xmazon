//
//  ProductListViewController.m
//  Xmazon
//
//  Created by guillaume chieb bouares on 03/02/2016.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import "ProductListViewController.h"

@interface ProductListViewController ()

@end

@implementation ProductListViewController

@synthesize category = category_;
@synthesize store = store_;
@synthesize products = products_;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadProduct];
    self.title = self.category.name;
    
    UIBarButtonItem* cartButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Images/shopping-cart.png"] style:UIBarButtonItemStylePlain target:self action:@selector(openCart)];
    
    self.navigationItem.rightBarButtonItem = cartButton;

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ProductTableViewCell";
    ProductTableViewCell *cell = (ProductTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProductTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    XMProduct* product  = [self.products objectAtIndex:indexPath.row];

    cell.productName.text  = product.name;
    cell.productPrice.text = [NSString stringWithFormat:@"%.02f €",product.price];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)openCart{

    CartViewController* v = [CartViewController new];
    [self.navigationController pushViewController:v animated:YES];
}
-(void)loadProduct{
    XMApiService* apiService = [[XMApiService alloc]init];
    
    [apiService getProductsByCategoryID:self.category.uid withSuccess:^(NSArray *products) {
        self.products = products;
        [self.productTableView reloadData];
    } failure:^{
        //nop
    }];
}

@end
