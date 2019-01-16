//
//  CJHomeBaseController.m
//  CJKJ
//
//  Created by cw-006 on 2018/12/29.
//  Copyright © 2018 cw-006. All rights reserved.
//

#import "CJHomeBaseController.h"
#import <AFNetworking/AFNetworking.h>
@interface CJHomeBaseController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CJHomeBaseController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //设置电池条为白色
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

/**初始化界面*/
-(void)setupUI {
    
    //背景色
    self.view.backgroundColor = ZXColor(247, 247, 247);
    
    
    //初始化NavBar
    //    [self setupNavBar];
    
    //初始化tableView
    [self setupTableView];
    
}

/**初始化NavBar*/
//-(void)setupNavBar
//{
//    self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, WIDTH, TopBarHeight)];
//
//    //修改Bar颜色
//    //    self.navBar.barTintColor = [UIColor cz_colorWithHex:0x232b36];
//
//
//    //设置背景图片
//    [self.navBar setBackgroundImage:[UIImage imageNamed:@"navBarImage"] forBarMetrics:UIBarMetricsDefault];
//
//    self.navBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:18]};
//
//    [self.view addSubview:self.navBar];
//
//    //判断是否创建navItem
//    if (!self.navItem) {
//        self.navItem = [[UINavigationItem alloc] initWithTitle:self.title];
//
//    }
//
//    self.navBar.items = @[self.navItem];
//}

/**初始化TableView*/
-(void)setupTableView
{
    
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (IPHONEX_SET?44:20), WIDTH, (IPHONEX_SET?(HEIGHT-73):(HEIGHT-49))) style:UITableViewStylePlain];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (IPHONEX_SET?79:55), WIDTH, (IPHONEX_SET?(HEIGHT-83-44-35):(HEIGHT-55-49))) style:UITableViewStylePlain];

    self.tableView.backgroundColor = ZXColor(247, 247, 247);
    
    self.tableView.separatorStyle=YES;
    self.tableView.separatorInset=UIEdgeInsetsZero;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    //    self.tableView.contentInset = UIEdgeInsetsMake(10*HEIGHTsCALE, 0, TabbarHeight, 0);
    //
    //    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //添加刷新控件
    NSMutableArray *imgArr=[NSMutableArray new];
    UIImage *img=[UIImage imageNamed:@"liveroom_rotate_55x55_"];
    [imgArr addObject:img];
    NSMutableArray *pullImg=[NSMutableArray new];
    [pullImg addObject:img];
    
    MJRefreshGifHeader *header=[MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [header setImages:imgArr forState:MJRefreshStateIdle];
    [header setImages:pullImg forState:MJRefreshStateRefreshing];
    self.tableView.mj_header=header;
    header.lastUpdatedTimeLabel.hidden=YES;
    //    header.stateLabel.hidden=YES;
    //    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    //添加脚部视图
    self.tableView.tableFooterView = [UIView new];
}


//加载最新
-(void)loadNewData
{
    
        if ([PPNetworkHelper currentNetworkStatus]) {
    
        }else{//没网
            //无网络提示
            [YX_ProgressHUD showHUDAddedTo:self.view animated:YES progressType:YXProgressHUDINFO text:@"请检查网络!"];
        }
    
}

//加载更多
-(void)loadMoreData
{
        if ([PPNetworkHelper currentNetworkStatus]) {
    
        }else{//没网
            //无网络提示
            [YX_ProgressHUD showHUDAddedTo:self.view animated:YES progressType:YXProgressHUDINFO text:@"请检查网络!"];
            [self.tableView.mj_footer endRefreshing];
        }
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc] init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
