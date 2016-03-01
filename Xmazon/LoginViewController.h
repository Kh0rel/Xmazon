//
//  LoginViewController.h
//  Xmazon
//
//  Created by guillaume chieb bouares on 01/02/2016.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegistrationViewController.h"
#import "PasswordNotFoundViewController.h"
#import "HomeViewController.h"
#import "XMSessionDataSingleton.h"
#import "XMApiService.h"

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPwd;

-(BOOL) verifField;
-(void)displayToastWithMessage:(NSString *)toastMessage;
@end
