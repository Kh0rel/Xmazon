//
//  ProfileViewController.m
//  Xmazon
//
//  Created by guillaume chieb bouares on 28/02/2016.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize datePicker = _datePicker;
static NSString* USERDEFAULT_KEY_USER = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Profil";
    SWRevealViewController *revealController = [self revealViewController];

    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Images/reveal-icon.png"]
                                                                         style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    
    self.navigationItem.leftBarButtonItem = revealButtonItem;
    
    UIBarButtonItem* cartButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Images/shopping-cart.png"] style:UIBarButtonItemStylePlain target:self action:@selector(openCart)];
    
    self.navigationItem.rightBarButtonItem = cartButton;
    [self initDatePicker];
    XMApiService* apiService = [XMApiService new];
    [apiService getUser:^{
        //
    } failure:^{
        //
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initDatePicker{
    
    
    self.datePicker = [[UIDatePicker alloc]init];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self.birthDateTextField setInputView:self.datePicker];
    
    UIToolbar* toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolbar setTintColor:[UIColor grayColor]];
    UIBarButtonItem* doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"done" style:UIBarButtonItemStylePlain target:self action:@selector(showSelectedDate)];
    UIBarButtonItem* space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [self.birthDateTextField setInputAccessoryView:toolbar];
}

-(void)showSelectedDate
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/YYYY"];
    self.birthDateTextField.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:self.datePicker.date]];
    [self.birthDateTextField resignFirstResponder];
}
-(void)openCart{
    
    CartViewController* v = [CartViewController new];
    [self.navigationController pushViewController:v animated:YES];
}
- (IBAction)modifyProfileAction:(id)sender {
    //TODO
}
- (IBAction)deconnectAction:(id)sender {
   // NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:USERDEFAULT_KEY_USER];
//    UIViewController *prevVC = [self.navigationController.viewControllers objectAtIndex:1];
//
    LoginViewController* loginController = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginController animated:YES];
//    [self.navigationController popToViewController:prevVC animated:YES];
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
