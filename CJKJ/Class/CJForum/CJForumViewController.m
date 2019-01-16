//
//  CJForumViewController.m
//  CJKJ
//
//  Created by cw-006 on 2018/12/29.
//  Copyright © 2018 cw-006. All rights reserved.
//

#import "CJForumViewController.h"
#import "CJSegmentVC.h"
#import "CJKeepForumController.h"
#import "CJRecomForumController.h"
#import "CJPetForumController.h"
#import "CJAreaForumController.h"
@interface CJForumViewController ()

@property (nonatomic, weak) CJSegmentVC *segmentBarVC;


@end

@implementation CJForumViewController

- (CJSegmentVC *)segmentBarVC {
    if (!_segmentBarVC) {
        CJSegmentVC *vc = [[CJSegmentVC alloc] init];
        [self addChildViewController:vc];//成链
        _segmentBarVC = vc;
    }
    return _segmentBarVC;
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setStatusBarBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0] ];
    
    //设置电池条为白色
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleDefault;
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    // Do any additional setup after loading the view.
    //    self.segmentBarVC.segmentBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    //设置segmentBarVC大小
    //    self.segmentBarVC.view.frame = CGRectMake(0, 0, WIDTH, (IPHONEX_SET?(HEIGHT-83):(HEIGHT-49)));
    self.segmentBarVC.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    
    self.segmentBarVC.view.backgroundColor=[UIColor whiteColor];
    //使用segmentBarVC
    [self.view addSubview:self.segmentBarVC.view];
    NSArray *items = @[@"收藏",@"推荐", @"宠物", @"地区"];
    NSMutableArray* childVCs = [NSMutableArray array];
    [childVCs addObject:[[CJKeepForumController alloc] init]];
    [childVCs addObject:[[CJRecomForumController alloc] init]];
    [childVCs addObject:[[CJPetForumController alloc] init]];
    [childVCs addObject:[[CJAreaForumController alloc] init]];
    
    
    [self.segmentBarVC setupWithItems:items childVCs:childVCs];
    
    
    [self.segmentBarVC.segmentBar updateViewWithConfig:^(TGSegmentConfig *config) {
        config.selectedColor([UIColor blackColor])
        .barBGColor([[UIColor whiteColor] colorWithAlphaComponent:1])
        .normalColor([UIColor lightGrayColor])
        .selectedFont([UIFont systemFontOfSize:15])//选中字体大于其他正常标签的字体的情况下，根据情况稍微调大margin（默认8），以免选中的字体变大后挡住其他正常标签的内容
        .normalFont([UIFont systemFontOfSize:12])
        .indicateExtraW(8)
        .indicateH(2)
        .indicateColor([UIColor blackColor])
        .showMore(NO)//是否显示更多面板
        .circleScroll(YES)//是否循环滚动，第0个再向前，那么到最后一个;最后一个向后，那么到第0个
        .moreCellBGColor([[UIColor grayColor] colorWithAlphaComponent:0.3])
        .moreBGColor([UIColor clearColor])
        .moreCellFont([UIFont systemFontOfSize:13])
        .moreCellMinH(30)
        .showMoreBtnlineView(YES)
        .moreBtnlineViewColor([UIColor lightTextColor])
        .moreBtnTitleFont([UIFont systemFontOfSize:13])
        .moreBtnTitleColor([UIColor lightTextColor])
        .margin(18)
        ;
    }];
    
    
    
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
