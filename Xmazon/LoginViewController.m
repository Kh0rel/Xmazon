//
//  LoginViewController.m
//  Xmazon
//
//  Created by guillaume chieb bouares on 01/02/2016.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import "LoginViewController.h"
static NSString* KEY_ACCESS_TOKEN = @"access_token";
static NSString* USERDEFAULT_KEY_USER = @"user";


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Xmazon";
    self.navigationItem.hidesBackButton = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    NSDictionary* userDefault = [[NSUserDefaults standardUserDefaults] objectForKey:USERDEFAULT_KEY_USER];
    if( userDefault != nil)
    {
        HomeViewController* homeController = [HomeViewController new];
        [self.navigationController pushViewController:homeController animated:NO];
    }
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
    [self.navigationController pushViewController:v animated:YES];
}
- (IBAction)registrationAction:(id)sender {
    RegistrationViewController* v = [RegistrationViewController new];
    [self.navigationController pushViewController:v animated:YES];
}
- (IBAction)loginAction:(id)sender {
    XMApiService* apiService = [XMApiService alloc];
    
    if( [self verifField] )
    {
        [apiService loginWithUsername:[[self tfEmail] text]
                    andPassword:[[self tfPwd] text] success:^(id user) {
                        HomeViewController* v = [HomeViewController new];
        
                        [self.navigationController pushViewController:v animated:YES];
                    } andError:^(void) {
                        [self displayToastWithMessage:@"Bad login"];
                    }];
    }


//    [apiService loginWithUsername:@"totoa@gmail.com"
//                      andPassword:@"toto"
//                          success:^(id user) {
//                              NSLog(@"Login Success : %@", [[[NSUserDefaults standardUserDefaults] valueForKey:@"app"] valueForKey:@"access_token"]);
////                              
////                              [apiService refreshtoken];
////                              [apiService getAllProducts:^(NSArray *products) {
////                                  NSLog(@"GET ALL products : %@", products);
////                              } failure:^{
////                                  NSLog(@"GET ALL products FAILED");
////                              }];
//                              
//                              
//                              
//                              [apiService getStores:^(NSArray *stores) {
//                                  NSLog(@"GET ALL STORE Success : %@", stores);
//                                  for (XMStore* store in stores) {
//                                      [apiService getCategoriesByIDStore:store.uid withSuccess:^(NSArray *categories) {
//                                          NSLog(@"GET ALL Categories by store id Success : %@", categories);
//                                          
//                                          for (XMCategory* cat in categories) {
//                                                       [apiService getProductsByCategoryID:cat.uid withSuccess:^(NSArray *products) {
//                                                           NSLog(@"GET products by cat : %@", products);
//                                                       } failure:^{
//                                                           NSLog(@"GET products by cat FAILED");
//                                                       }];
//                                          }
//                                 
//                                          
//                                      } andFailure:^{
//                                          NSLog(@"GET ALL Categories by store id FAILED");
//                                      }];
//                                  }
//                                  
//                                  
//                              } failure:^{
//                                  NSLog(@"GET ALL STORE FAILED");
//                              }];
//                          } andError:^(void) {
//                              NSLog(@"Login FAILED");
//                              
//                          }];
//    
    

}

-(BOOL) verifField
{
    BOOL isOk = true;
    if([[self tfEmail] text] && [[[self tfEmail] text] length] == 0)
    {
        [self tfEmail].placeholder = @"Champ obligatoire";
        isOk &= FALSE;
    }
    if([[self tfPwd] text] && [[[self tfPwd] text] length] == 0)
    {
        [self tfPwd].placeholder = @"Champ obligatoire";
        isOk &= FALSE;
    }
    return isOk;
}

-(void)displayToastWithMessage:(NSString *)toastMessage
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
        UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
        UILabel *toastView = [[UILabel alloc] init];
        toastView.text = toastMessage;
        toastView.textAlignment = NSTextAlignmentCenter;
        toastView.frame = CGRectMake(0.0, 0.0, keyWindow.frame.size.width/2.0, 100.0);
        toastView.layer.cornerRadius = 10;
        toastView.layer.masksToBounds = YES;
        toastView.center = keyWindow.center;
        
        [keyWindow addSubview:toastView];
        
        [UIView animateWithDuration: 3.0f
                              delay: 0.0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations: ^{
                             toastView.alpha = 0.0;
                         }
                         completion: ^(BOOL finished) {
                             [toastView removeFromSuperview];
                         }
         ];
    }];
}
@end
