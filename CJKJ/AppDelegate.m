//
//  AppDelegate.m
//  CJKJ
//
//  Created by cw-006 on 2018/12/29.
//  Copyright © 2018 cw-006. All rights reserved.
//

#import "AppDelegate.h"
#import "CJRootViewController.h"
#import "MSLaunchView.h"
#import "UserInfoModel.h"
@interface AppDelegate ()
@property(nonatomic,strong)  MSLaunchView *launchView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    CJRootViewController *root = [[CJRootViewController alloc] init];
    [root setAppearance];
    
    
    _window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    _vc = [[CJTabBarController alloc] init];
    [_vc addChildViewController];
    _vc.delegate = self;
    _window.rootViewController = _vc;
    
    
//    NSString *path  = [[NSBundle mainBundle]  pathForResource:@"启动页02" ofType:@"jpg"];
    NSArray *imgArr=[NSArray arrayWithObjects:@"启动页02",@"启动页02",nil];
    //    NSURL *url = [NSURL fileURLWithPath:path];
    //    MSLaunchView *launchView = [MSLaunchView launchWithVideo:CGRectMake(0, 0, WIDTH, HEIGHT) videoURL:url];
    //    launchView.videoGravity = AVLayerVideoGravityResize;
    MSLaunchView *launchView=[MSLaunchView launchWithImages:imgArr];
    launchView.nomalColor = [UIColor lightGrayColor];
    launchView.currentColor = [UIColor orangeColor];
    
    
    //    launchView.isHiddenSkipBtn = YES;
    _launchView = launchView;

    
    [self setupUserLogin];
    
    return YES;
}


-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if (![viewController.tabBarItem.title isEqualToString:@"首页"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Minechangetitlecolor" object:nil];
        return YES;
    }
    return YES;
}

//登录
-(void)setupUserLogin
{
    if (CJ_isLogin) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSString *account = CJ_Account;
        NSString *password = CJ_Password;
        params[@"account"] = account;
        params[@"password"] = password;
        
        NSString *url =@"https://www.chongwu001.com/api/user/login";
        
        [PPNetworkHelper POST:url parameters:params success:^(id responseObject) {
            
            [singleten shareUserModel].model = nil;
            
            NSDictionary *dic=responseObject[@"data"][@"userinfo"];
            UserInfoModel *model=[[UserInfoModel alloc]initWithDictionary:dic];
            [singleten shareUserModel].model = model;
            
            
            
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }else{
        
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
