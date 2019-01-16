//
//  AppDelegate.h
//  CJKJ
//
//  Created by cw-006 on 2018/12/29.
//  Copyright © 2018 cw-006. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJTabBarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(strong,nonatomic)    CJTabBarController * vc;  //tabbarController

@end

