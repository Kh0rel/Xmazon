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

@interface RegistrationViewController : UIViewController{
    UIDatePicker* _datePicker;
}
@property (strong, nonatomic) IBOutlet UIButton *RegistrationAction;

@property (weak, nonatomic) IBOutlet UIButton *button_subscribe;
@property (strong, nonatomic) IBOutlet UITextField *dateTextField;
@property(strong,nonatomic)UIDatePicker* datePicker;

-(void)showSelectedDate;
-(void)initDatePicker;
@end

