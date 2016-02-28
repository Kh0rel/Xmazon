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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Inscription";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)subscribe:(id)sender {
    XMUser *user = [XMUser alloc];
    //Mettre les param des input
    user.birthdate = @"31/08/93";
    user.email = @"blablaaaaa@gmail.com";
    user.firstname = @"totoa";
    user.lastname = @"tataa";
    user.password = @"tototata";
    
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
