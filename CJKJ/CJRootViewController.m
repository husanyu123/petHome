//
//  CJRootViewController.m
//  CJKJ
//
//  Created by cw-006 on 2018/12/29.
//  Copyright © 2018 cw-006. All rights reserved.
//

#import "CJRootViewController.h"

@interface CJRootViewController ()<UIAlertViewDelegate>

@end

@implementation CJRootViewController
{
    NSString *trackViewUrl;
    NSString *shouStr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setAppearance{
    
    //    [self onCheckVersion];
    
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    
    //push 之后隐藏文字（全局方法）
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    [[UITabBar appearance] setBarTintColor:ZXColor(26, 27, 31)];
    //主题的颜色为白色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UINavigationBar appearance] setHidden:YES];
    
    //返回的箭头为白色
    //    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    
    /*
     确保App启动的屏幕方向
     */
    [[UIApplication sharedApplication] setStatusBarOrientation:(UIInterfaceOrientationPortrait) animated:NO];
    
    
    
    /*
     请求(GET)Url: http://live.coop.gslb.letv.com/live/rtmp/201606123000000pa13?ch=bcloud_835115&custid=835115&expect=3&ext=m3u8&format=1&liveid=201606123000000pa&lsbv=mQ&lsdg=EGWGp492R3vAf0TgTHw7sQhjc8h&lsst=0&lssv=3hzg2N_T0_SHQ_VdLC_P_I0_MciKbTd2&lstm=LygHa16AHYF&p1=3&p2=32&p3=321&platid=10&scheme=hls&splatid=1080&stream_id=201606123000000pa13&tag=live&uuid=69CD699300B941C7BF2238F9B6C3C2651465705952_0&p=100&customerId=(null)
     */
    
    
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
