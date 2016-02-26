//
//  AppDelegate.h
//  Xmazon
//
//  Created by guillaume chieb bouares on 20/01/2016.
//  Copyright (c) 2016 com.esgi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SWRevealViewController.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,SWRevealViewControllerDelegate>{
    @private
    UIWindow* _window;
    SWRevealViewController* _revealViewController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SWRevealViewController *revealViewController;


@end

