//
//  RearViewController.m
//  Xmazon
//
//  Created by guillaume chieb bouares on 25/02/2016.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import "RearViewController.h"

@interface RearViewController ()

@end

@implementation RearViewController


@synthesize rearTableView;
@synthesize stores = _stores;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadStore];
    self.title = @"Menu";
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0)
        return 4;
    else
        return [self.stores count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0)
        return @"";
    else
        return @"Boutique";
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = indexPath.row;
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    NSString* text = nil;
    if (indexPath.section==0) {
        
        if (row == 0) {
            text = @"Accueil";
        }
        else if (row == 1){
            text = @"Profil";
        }
        else if (row == 2){
            text = @"Catégorie";
        }
        else if (row == 3){
            text = @"Historique des commandes";
        }
        
        cell.textLabel.text = (![text isEqual:nil]) ? text : nil;
    } else {
        XMStore* store = [self.stores objectAtIndex:indexPath.row];
        cell.textLabel.text = store.name;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SWRevealViewController* revealController = self.revealViewController;
    
    
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            HomeViewController* newFrontView = [HomeViewController new];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontView];
            [revealController pushFrontViewController:navigationController animated:YES];
        }
        else if (indexPath.row == 1){
            ProfileViewController* newFrontView = [ProfileViewController new];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontView];
            [revealController pushFrontViewController:navigationController animated:YES];
        }
        else if (indexPath.row == 2){
            CategoryViewController* newFrontView = [CategoryViewController new];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontView];
            [revealController pushFrontViewController:navigationController animated:YES];
        }
        else if (indexPath.row == 3){
            OrderHistoryViewController* newFrontView = [OrderHistoryViewController new];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontView];
            [revealController pushFrontViewController:navigationController animated:YES];
        }
    }
    else if(indexPath.section == 1){
        CategoryViewController* newFrontView = [CategoryViewController new];
        XMStore *store = [self.stores objectAtIndex:indexPath.row];
        newFrontView.store = store;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontView];
        [revealController pushFrontViewController:navigationController animated:YES];
    }
    
    
}

-(void)loadStore{
    XMApiService* apiService = [[XMApiService alloc]init];
    [apiService getStores:^(NSArray *storeList) {
        self.stores = [storeList copy];
        [self.rearTableView reloadData];
    } failure:^{
        NSLog(@"GET ALL STORE FAILED");
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
