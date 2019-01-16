//
//  CJTabBarController.h
//  CJKJ
//
//  Created by cw-006 on 2018/12/29.
//  Copyright © 2018 cw-006. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol UITabBarControllerDelegate <NSObject>
//
//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;
//
//@end

NS_ASSUME_NONNULL_BEGIN



@interface CJTabBarController : UITabBarController<UITabBarControllerDelegate>

@property(nonatomic,assign) id<UITabBarControllerDelegate> delegate;

-(void)addChildViewController;

+(CJTabBarController *)shareTabBar;

@end

NS_ASSUME_NONNULL_END
