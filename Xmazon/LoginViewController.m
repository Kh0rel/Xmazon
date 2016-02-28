//
//  LoginViewController.m
//  Xmazon
//
//  Created by guillaume chieb bouares on 01/02/2016.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Xmazon";
        // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)passwordNotFoundAction:(id)sender {
    PasswordNotFoundViewController* v = [PasswordNotFoundViewController new];
    NSLog(@"accept_token : %@", [[XMSessionDataSingleton sharedSession].currentSession objectForKey:@"refresh_token"]);
    [self.navigationController pushViewController:v animated:YES];
}
- (IBAction)registrationAction:(id)sender {
    
    RegistrationViewController* v = [RegistrationViewController new];
    [self.navigationController pushViewController:v animated:YES];
}
- (IBAction)loginAction:(id)sender {
    XMApiService* apiService = [XMApiService alloc];
    
    [apiService loginWithUsername:@"delbut.maxime@gmail.com"
                      andPassword:@"blabla"
                          success:^(id user) {
                              NSLog(@"Login Success : %@", [[XMSessionDataSingleton sharedSession].currentSession valueForKey:@"access_token"]);
                              
                              [apiService getStores:^(NSArray *stores) {
                                  NSLog(@"GET ALL STORE Success : %@", stores);
                                  for (XMStore* store in stores) {
                                      [apiService getCategoriesByIDStore:store.uid withSuccess:^(NSArray *categories) {
                                          NSLog(@"GET ALL Categories by store id Success : %@", categories);
                                      } andFailure:^{
                                          NSLog(@"GET ALL Categories by store id FAILED");
                                      }];
                                  }
                                  
                                  
                              } failure:^{
                                  NSLog(@"GET ALL STORE FAILED");
                              }];
                          } andError:^(NSArray *errors) {
                              NSLog(@"Login FAILED : %@", errors);
                              
                          }];
}

@end
