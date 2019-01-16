//
//  CJTabBarController.m
//  CJKJ
//
//  Created by cw-006 on 2018/12/29.
//  Copyright © 2018 cw-006. All rights reserved.
//

#import "CJTabBarController.h"
#import "CJKuViewController.h"
#import "CJPetViewController.h"
#import "CJForumViewController.h"
#import "CJHomePageVC.h"
#import "CJMineViewController.h"
@interface CJTabBarController ()

@end

@implementation CJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor clearColor];
    
    //    [self.tabBar setBarTintColor:[UIColor blackColor]];
    
    //    [self.tabBar setBarTintColor:[UIColor colorWithRed:26.0f/255.0f green:27.0f/255.0f blue:31.0f/255.0f alpha:1.0]];
    
    [UIView animateWithDuration:3 animations:^{
        
        self.view.transform = CGAffineTransformIdentity;
        
        
    } completion:^(BOOL finished) {
        
    }];
}

+(CJTabBarController *)shareTabBar{
    static CJTabBarController *view =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [[self alloc] init];
    });
    
    return view;
    
}

-(BOOL)shouldAutorotate{
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
    
}

-(void)addChildViewController{
    CJHomePageVC *homeView=[[CJHomePageVC alloc]init];
    //    CJHomeViewController *homeView=[[CJHomeViewController alloc]init];
    
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:homeView];
    homeView.title=@"首页";
    //    homeView.title
    //    homeView.tabBarItem.image=[[UIImage imageNamed:@"比赛--默认"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    homeView.tabBarItem.selectedImage=[[UIImage imageNamed:@"比赛-选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [homeView.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [self addChildViewController:nav];
    
    CJForumViewController *forumV=[[CJForumViewController alloc]init];
    UINavigationController *nav2=[[UINavigationController alloc]initWithRootViewController:forumV];
    forumV.title=@"论坛";
    //    forumV.tabBarItem.image=[[UIImage imageNamed:@"直播白"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    forumV.tabBarItem.selectedImage=[[UIImage imageNamed:@"直播-红"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [forumV.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [self addChildViewController:nav2];
    
    CJKuViewController *kuV=[[CJKuViewController alloc]init];
    UINavigationController *nav3=[[UINavigationController alloc]initWithRootViewController:kuV];
    kuV.title=@"库";
    //    kuV.tabBarItem.image=[[UIImage imageNamed:@"商城"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    kuV.tabBarItem.selectedImage=[[UIImage imageNamed:@"商城-选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [kuV.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [self addChildViewController:nav3];
    
    
    CJPetViewController *petV = [[CJPetViewController alloc] init];
    UINavigationController *nav4=[[UINavigationController alloc]initWithRootViewController:petV];
    petV.title=@"爱宠";
    //    petV.tabBarItem.image=[[UIImage imageNamed:@"我的--默认"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    petV.tabBarItem.selectedImage=[[UIImage imageNamed:@"我的--选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [petV.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    [self addChildViewController:nav4];
    
    CJMineViewController *mineV=[[CJMineViewController alloc]init];
    UINavigationController *nav5=[[UINavigationController alloc]initWithRootViewController:mineV];
    mineV.title=@"我";
    [mineV.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [self addChildViewController:nav5];

    
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
