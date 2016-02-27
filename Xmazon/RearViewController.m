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
        text = @"Test";
    }
    else if (row == 1){
        text = @"Test 2";
    }
    else if (row == 2){
        text = @"test 3";
    }
    else if (row == 3){
        text = @"test 4";
    }
    cell.textLabel.text = (![text isEqual:nil]) ? text : nil;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
