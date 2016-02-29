//
//  RegistrationViewController.m
//  Xmazon
//
//  Created by guillaume chieb bouares on 03/02/2016.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController
@synthesize datePicker = _datePicker;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Inscription";
    
    [self initDatePicker];

}
-(void)initDatePicker{
    self.datePicker = [[UIDatePicker alloc]init];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self.dateTextField setInputView:self.datePicker];
    
    UIToolbar* toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolbar setTintColor:[UIColor grayColor]];
    UIBarButtonItem* doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"done" style:UIBarButtonItemStylePlain target:self action:@selector(showSelectedDate)];
    UIBarButtonItem* space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [self.dateTextField setInputAccessoryView:toolbar];
}
-(void)showSelectedDate
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/YYYY"];
    self.dateTextField.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:self.datePicker.date]];
    [self.dateTextField resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)subscribe:(id)sender {
    XMUser *user = [XMUser alloc];
    //Mettre les param des input
    user.birthdate = @"31/08/93";
    user.email = @"totoa@gmail.com";
    user.firstname = @"toto";
    user.lastname = @"tata";
    user.password = @"toto";
    
    XMApiService* apiService = [XMApiService alloc];
    [apiService subscribe:user withSuccessBlock:^(XMUser *user) {
        NSLog(@"Subscribe Success : %@", user);
    } failure:^{
        NSLog(@"Subscribe FAILED !");
    }];
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
