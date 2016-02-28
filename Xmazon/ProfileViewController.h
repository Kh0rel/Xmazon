//
//  ProfileViewController.h
//  Xmazon
//
//  Created by guillaume chieb bouares on 28/02/2016.
//  Copyright © 2016 com.esgi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SWRevealViewController.h>
#import "CartViewController.h"
@interface ProfileViewController : UIViewController{
    UIDatePicker* _datePicker;
}

@property (strong, nonatomic) IBOutlet UITextField *mailTextField;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *birthDateTextField;
@property (strong, nonatomic) UIDatePicker* datePicker;

-(void)openCart;
-(void)initDatePicker;
-(void)showSelectedDate;
@end
