//
//  CJMineViewController.m
//  CJKJ
//
//  Created by cw-006 on 2018/12/29.
//  Copyright © 2018 cw-006. All rights reserved.
//

#import "CJMineViewController.h"
#import "CJLoginController.h"
@interface CJMineViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *catigreView;
@property (nonatomic, strong) UIView *logView;
@property (nonatomic, strong) UIButton *setBtn;

@property (nonatomic, strong) UIView *headView1;
@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UIView *statusView;;

@end
@implementation CJMineViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.delegate=self;
    //设置电池条为白色
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;

}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if([[viewController class]isSubclassOfClass:[CJMineViewController class]]) {
        ///执行刷新操作
        if ([singleten shareUserModel].model) {
            self.headView.hidden=YES;
            
            [self setNewUI];
            [self.view bringSubviewToFront:self.catigreView];
        }
    }
    if(![[viewController class]isSubclassOfClass:[self class]]) {
        
        self.navigationController.delegate=nil;
        
    }
}

    


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;//    自动滚动调整，默认为YES
    NSLog(@"00000000");
    [self setUI];
}

-(void)setUI{
//    self.headView=[[UIView alloc]initWithFrame:CGRectMake(0, (IPHONEX_SET?44:20), WIDTH, 231*HEIGHTsCALE)];
    self.headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 231*HEIGHTsCALE)];

    self.headView.backgroundColor=ZXColor(22, 23, 35);
    
    UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(19*WIDTHsCALE, (162-88)*HEIGHTsCALE, 249*WIDTHsCALE, 32*HEIGHTsCALE)];
    nameLab.text=@"Hi~欢迎来到宠物之家";
    [nameLab setFont:ControlFont(23)];
    nameLab.textColor=[UIColor whiteColor];
    [self.headView addSubview:nameLab];
    
    _setBtn=[[UIButton alloc]initWithFrame:CGRectMake(343*WIDTHsCALE, (146-88)*HEIGHTsCALE, 16, 16)];
    [_setBtn setImage:[UIImage imageNamed:@"设置符号"] forState:UIControlStateNormal];
    [_setBtn addTarget:self action:@selector(clickSet:) forControlEvents:UIControlEventTouchDown];
    [self.headView addSubview:_setBtn];
    
    UIButton *logBtn=[[UIButton alloc]initWithFrame:CGRectMake(30*WIDTHsCALE, (240-88)*HEIGHTsCALE, 149*WIDTHsCALE, 47*HEIGHTsCALE)];
    [logBtn setTitle:@"登录 / 注册" forState:UIControlStateNormal];
    [logBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
     CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 255, 255, 255, 1 });
    [logBtn.layer setBorderColor:colorref];//边框颜色
    logBtn.layer.borderWidth = 1.0f;//设置边框颜色
    [logBtn addTarget:self action:@selector(clickLog:) forControlEvents:UIControlEventTouchDown];
     [self.headView addSubview:logBtn];
    
    
    [self.view addSubview:self.headView];
    
    self.catigreView=[[UIView alloc]initWithFrame:CGRectMake(15*WIDTHsCALE, (308-88)*HEIGHTsCALE, 345*WIDTHsCALE, 92*HEIGHTsCALE)];
    self.catigreView.backgroundColor=[UIColor whiteColor];
    [self addShadowToView:self.catigreView withColor:[UIColor lightGrayColor]];
    
    UIButton *scBtn=[[UIButton alloc]initWithFrame:CGRectMake(15*WIDTHsCALE, 15*HEIGHTsCALE, 40*WIDTHsCALE, 40*WIDTHsCALE)];
//    [scBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [scBtn setImage:[UIImage imageNamed:@"收藏图标"] forState:UIControlStateNormal];
    [self.catigreView addSubview:scBtn];
    
    UIButton *zjBtn=[[UIButton alloc]initWithFrame:CGRectMake(84*WIDTHsCALE, 15*HEIGHTsCALE, 40*WIDTHsCALE, 40*WIDTHsCALE)];
    [zjBtn setTitle:@"足迹" forState:UIControlStateNormal];
    [zjBtn setImage:[UIImage imageNamed:@"足迹图标"] forState:UIControlStateNormal];
    [self.catigreView addSubview:zjBtn];


    UIButton *fbBtn=[[UIButton alloc]initWithFrame:CGRectMake(153*WIDTHsCALE, 15*HEIGHTsCALE, 40*WIDTHsCALE, 40*WIDTHsCALE)];
    [fbBtn setTitle:@"发布" forState:UIControlStateNormal];
    [fbBtn setImage:[UIImage imageNamed:@"发布图标"] forState:UIControlStateNormal];
    [self.catigreView addSubview:fbBtn];


    UIButton *fsBtn=[[UIButton alloc]initWithFrame:CGRectMake(222*WIDTHsCALE, 15*HEIGHTsCALE, 40*WIDTHsCALE, 40*WIDTHsCALE)];
    [fsBtn setTitle:@"粉丝" forState:UIControlStateNormal];
    [fsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fsBtn setImage:[UIImage imageNamed:@"粉丝图标"] forState:UIControlStateNormal];
    [self.catigreView addSubview:fsBtn];


    UIButton *gzBtn=[[UIButton alloc]initWithFrame:CGRectMake(291*WIDTHsCALE, 15*HEIGHTsCALE, 40*WIDTHsCALE, 40*WIDTHsCALE)];
    [gzBtn setTitle:@"关注" forState:UIControlStateNormal];
    [gzBtn setImage:[UIImage imageNamed:@"关注图标"] forState:UIControlStateNormal];
    [self.catigreView addSubview:gzBtn];

    [self.view addSubview:self.catigreView];
    
}

-(void)setNewUI{
    self.headView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 231*HEIGHTsCALE)];
    
    self.headView1.backgroundColor=ZXColor(22, 23, 35);
    
    _headImg=[[UIImageView alloc]initWithFrame:CGRectMake(16*WIDTHsCALE, IPHONEX_SET?(175-88):(175-88-24), 60, 60)];
    _headImg.layer.cornerRadius = 30;
    [_headImg setImage:[UIImage imageNamed:@"timg"]];
    [self.headView1 addSubview:_headImg];
    
    _userName=[[UILabel alloc]initWithFrame:CGRectMake(88*WIDTHsCALE, IPHONEX_SET?(187-88):(187-88-24), 100, 30)];
    _userName.text=[singleten shareUserModel].model.username;
    _userName.textColor = ZXColor(255, 255, 255);
    _userName.font=ControlFont(16);
    [self.headView1 addSubview:_userName];
    
    _setBtn=[[UIButton alloc]initWithFrame:CGRectMake(343*WIDTHsCALE, IPHONEX_SET?(146-88):(146-88-24), 16*WIDTHsCALE, 16*WIDTHsCALE)];
    [_setBtn setImage:[UIImage imageNamed:@"设置符号"] forState:UIControlStateNormal];
    [_setBtn addTarget:self action:@selector(clickSet:) forControlEvents:UIControlEventTouchDown];
    [self.headView1 addSubview:_setBtn];
    
    [self.view addSubview:self.headView1];
    
    _statusView=[[UIView alloc]initWithFrame:CGRectMake(15*WIDTHsCALE, CGRectGetMaxY(_catigreView.frame)+20*HEIGHTsCALE, 345*WIDTHsCALE, 195*HEIGHTsCALE)];
    _statusView.backgroundColor=[UIColor whiteColor];
    [self addShadowToView:self.statusView withColor:[UIColor lightGrayColor]];
    
    UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 15*HEIGHTsCALE, 100, 29*HEIGHTsCALE)];
    titleLab.text=@"登录状态";
    titleLab.font=ControlFont(21);
    titleLab.textColor=ZXColor(2, 18, 43);
    titleLab.textAlignment=NSTextAlignmentRight;
    [self.statusView addSubview:titleLab];
    
    UILabel *logTime=[[UILabel alloc]initWithFrame:CGRectMake(0, 62*HEIGHTsCALE, 100, 20)];
    logTime.text=@"登录时间";
    logTime.font=ControlFont(14);
    logTime.textColor=ZXColor(55, 57, 65);
    logTime.textAlignment=NSTextAlignmentRight;
    [self.statusView addSubview:logTime];
    
    UILabel *lastTime=[[UILabel alloc]initWithFrame:CGRectMake(0, 89*HEIGHTsCALE, 100, 20)];
    lastTime.text=@"最后登录时间";
    lastTime.font=ControlFont(14);
    lastTime.textColor=ZXColor(55, 57, 65);
    lastTime.textAlignment=NSTextAlignmentRight;
    [self.statusView addSubview:lastTime];
    
    UILabel *keepLog=[[UILabel alloc]initWithFrame:CGRectMake(0, 119*HEIGHTsCALE, 100, 20)];
    keepLog.text=@"持续登录";
    keepLog.font=ControlFont(14);
    keepLog.textColor=ZXColor(55, 57, 65);
    keepLog.textAlignment=NSTextAlignmentRight;
    [self.statusView addSubview:keepLog];
    
    UILabel *longKeep=[[UILabel alloc]initWithFrame:CGRectMake(0, 146*HEIGHTsCALE, 100, 20)];
    longKeep.text=@"最长连续登录";
    longKeep.font=ControlFont(14);
    longKeep.textColor=ZXColor(55, 57, 65);
    longKeep.textAlignment=NSTextAlignmentRight;
    [self.statusView addSubview:longKeep];
    
    [self.view addSubview:_statusView];
}

-(void)clickLog:(id)sender{
//    [self presentViewController:[[CJLoginController alloc]init] animated:YES completion:nil];
    CJLoginController *logV=[[CJLoginController alloc]init];
    logV.hidesBottomBarWhenPushed=YES;
    self.navigationController.navigationBar.hidden=NO;
    
    
    [self.navigationController pushViewController:logV animated:YES];
}

-(void)clickSet:(id)sender{
    NSLog(@"设置");
}

/// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 3;
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
