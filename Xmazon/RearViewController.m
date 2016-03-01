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

@synthesize treeView = _treeView;
@synthesize data = _data;
@synthesize rearTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Menu";
    [self loadData];
    
    RATreeView* treeView = [[RATreeView alloc] initWithFrame:self.view.bounds];
    treeView.delegate = self;
    treeView.dataSource = self;
    treeView.treeFooterView = [UIView new];
    treeView.separatorStyle = RATreeViewCellSeparatorStyleSingleLine;
    
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(refreshControlChanged:) forControlEvents:UIControlEventValueChanged];
    [treeView.scrollView addSubview:refreshControl];
    
    [treeView reloadData];
    [treeView setBackgroundColor:[UIColor colorWithWhite:0.97 alpha:1.0]];
    
    self.treeView = treeView;
    self.treeView.frame = self.view.bounds;
    self.treeView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:treeView atIndex:0];
    
    [self.treeView registerNib:[UINib nibWithNibName:NSStringFromClass([RATableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([RATableViewCell class])];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    int systemVersion = [[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."][0] intValue];
    if (systemVersion >= 7 && systemVersion < 8) {
        CGRect statusBarViewRect = [[UIApplication sharedApplication] statusBarFrame];
        float heightPadding = statusBarViewRect.size.height+self.navigationController.navigationBar.frame.size.height;
        self.treeView.scrollView.contentInset = UIEdgeInsetsMake(heightPadding, 0.0, 0.0, 0.0);
        self.treeView.scrollView.contentOffset = CGPointMake(0.0, -heightPadding);
    }
    self.treeView.frame = self.view.bounds;
    
}
- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item
{
    return 44;
}
/*
- (void)treeView:(RATreeView *)treeView didSelectRowForItem:(id)item{
    SWRevealViewController* revealController = self.revealViewController;
    UIViewController* newFrontView = nil;
    
    if([item isKindOfClass:[RADataObject class]]){
        if ( [((RADataObject *)item).name isEqualToString:@"Phones"]){

             newFrontView = [ProfileViewController new];
        }
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontView];
        [revealController pushFrontViewController:navigationController animated:YES];
    }
    
}

- (void)treeView:(RATreeView *)treeView willExpandRowForItem:(id)item
{
    RATableViewCell *cell = (RATableViewCell *)[treeView cellForItem:item];
    [cell setAdditionButtonHidden:NO animated:YES];
}

- (void)treeView:(RATreeView *)treeView willCollapseRowForItem:(id)item
{
    RATableViewCell *cell = (RATableViewCell *)[treeView cellForItem:item];
    [cell setAdditionButtonHidden:YES animated:YES];
}

/*
- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item
{
   /* RADataObject *dataObject = item;
    
    NSInteger level = [self.treeView levelForCellForItem:item];
    NSInteger numberOfChildren = [dataObject.children count];
    NSString *detailText = [NSString localizedStringWithFormat:@"Number of children %@", [@(numberOfChildren) stringValue]];
    BOOL expanded = [self.treeView isCellForItemExpanded:item];
    
    RATableViewCell *cell = [self.treeView dequeueReusableCellWithIdentifier:NSStringFromClass([RATableViewCell class])];
    [cell setupWithTitle:dataObject.name detailText:detailText level:level additionButtonHidden:!expanded];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    __weak typeof(self) weakSelf = self;
    cell.additionButtonTapAction = ^(id sender){
        if (![weakSelf.treeView isCellForItemExpanded:dataObject] || weakSelf.treeView.isEditing) {
            return;
        }
        RADataObject *newDataObject = [[RADataObject alloc] initWithName:@"Added value" children:@[]];
        [dataObject addChild:newDataObject];
        [weakSelf.treeView insertItemsAtIndexes:[NSIndexSet indexSetWithIndex:0] inParent:dataObject withAnimation:RATreeViewRowAnimationLeft];
        [weakSelf.treeView reloadRowsForItems:@[dataObject] withRowAnimation:RATreeViewRowAnimationNone];
    };
 
    return cell;
}

- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item
{
    if (item == nil) {
        return [self.data count];
    }
    
    RADataObject *data = item;
    return [data.children count];
}

- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item
{
    RADataObject *data = item;
    if (item == nil) {
        return [self.data objectAtIndex:index];
    }
    
    return data.children[index];
}
 */



/*
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
- (void)loadStore{
        XMApiService* apiService = [XMApiService alloc];
    [apiService getStores:^(NSArray *stores) {
        NSLog(@"GET ALL STORE Success : %@", stores);
        for (XMStore* store in stores) {
            /*
            [apiService getCategoriesByIDStore:store.uid withSuccess:^(NSArray *categories) {
                NSLog(@"GET ALL Categories by store id Success : %@", categories);
                
                for (XMCategory* cat in categories) {
                    [apiService getProductsByCategoryID:cat.uid withSuccess:^(NSArray *products) {
                        NSLog(@"GET products by cat : %@", products);
                    } failure:^{
                        NSLog(@"GET products by cat FAILED");
                    }];
                }
                
                
            } andFailure:^{
                NSLog(@"GET ALL Categories by store id FAILED");
            }];
        }
        
        
    } failure:^{
        NSLog(@"GET ALL STORE FAILED");
    }];

}
*/

- (void)loadData {
   /* RADataObject *phone1 = [RADataObject dataObjectWithName:@"Phone 1" children:nil];
    RADataObject *phone2 = [RADataObject dataObjectWithName:@"Phone 2" children:nil];
    RADataObject *phone3 = [RADataObject dataObjectWithName:@"Phone 3" children:nil];
    RADataObject *phone4 = [RADataObject dataObjectWithName:@"Phone 4" children:nil];
    
    RADataObject *phone = [RADataObject dataObjectWithName:@"Phones"
                                                  children:[NSArray arrayWithObjects:phone1, phone2, phone3, phone4, nil]];
    
    RADataObject *notebook1 = [RADataObject dataObjectWithName:@"Notebook 1" children:nil];
    RADataObject *notebook2 = [RADataObject dataObjectWithName:@"Notebook 2" children:nil];
    
    RADataObject *computer1 = [RADataObject dataObjectWithName:@"Computer 1"
                                                      children:[NSArray arrayWithObjects:notebook1, notebook2, nil]];
    RADataObject *computer2 = [RADataObject dataObjectWithName:@"Computer 2" children:nil];
    RADataObject *computer3 = [RADataObject dataObjectWithName:@"Computer 3" children:nil];
    
    RADataObject *computer = [RADataObject dataObjectWithName:@"Computers"
                                                     children:[NSArray arrayWithObjects:computer1, computer2, computer3, nil]];
    RADataObject *car = [RADataObject dataObjectWithName:@"Cars" children:nil];
    RADataObject *bike = [RADataObject dataObjectWithName:@"Bikes" children:nil];
    RADataObject *house = [RADataObject dataObjectWithName:@"Houses" children:nil];*/
    
    //self.data = [NSArray arrayWithObjects:phone,computer, car, bike, house, nil];
    
}
- (void)refreshControlChanged:(UIRefreshControl *)refreshControl
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [refreshControl endRefreshing];
    });
}

@end
