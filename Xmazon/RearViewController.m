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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Menu";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSInteger row = indexPath.row;
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    NSString* text = nil;
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
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SWRevealViewController* revealController = self.revealViewController;
    UIViewController* newFrontView = nil;
    
    
    if(indexPath.row == 0){
        newFrontView = [HomeViewController new];
    }
    else if (indexPath.row == 1){
        newFrontView = [ProfileViewController new];
    }
    else if (indexPath.row == 2){
        newFrontView = [CategoryViewController new];
    }
    else if (indexPath.row == 3){
        newFrontView = [OrderHistoryViewController new];
    }

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontView];
    [revealController pushFrontViewController:navigationController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
