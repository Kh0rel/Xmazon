//
//  RegistrationViewController.h
//  Xmazon
//
//  Created by guillaume chieb bouares on 03/02/2016.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMUser.h"
#import "XMApiService.h"
#import "HomeViewController.h"


@interface RegistrationViewController : UIViewController{
    UIDatePicker* _datePicker;
}
@property (strong, nonatomic) IBOutlet UIButton *RegistrationAction;

@property (weak, nonatomic) IBOutlet UIButton *button_subscribe;
@property (strong, nonatomic) IBOutlet UITextField *dateTextField;
@property(strong,nonatomic)UIDatePicker* datePicker;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPass;
@property (weak, nonatomic) IBOutlet UITextField *tfVerifPass;
@property (weak, nonatomic) IBOutlet UITextField *tfNom;
@property (weak, nonatomic) IBOutlet UITextField *tfLastName;
@property (weak, nonatomic) IBOutlet UITextField *tfBirthday;

-(void)showSelectedDate;
-(void)initDatePicker;
-(XMUser*) createUser;
@end

