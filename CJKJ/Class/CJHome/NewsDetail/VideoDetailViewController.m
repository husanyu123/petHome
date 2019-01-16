//
//  VideoDetailViewController.m
//  CJKJ
//
//  Created by cw-006 on 2019/1/3.
//  Copyright © 2019 cw-006. All rights reserved.
//

#import "VideoDetailViewController.h"
#import <ZFPlayer/ZFPlayer.h>
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import "UIImageView+ZFCache.h"
#import "ZFUtilities.h"
#import "CJCommentCell.h"
#import "CJInputBar.h"
#import <MJRefresh.h>

static NSString *kVideoCover = @"https://upload-images.jianshu.io/upload_images/635942-14593722fe3f0695.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";
static NSString * const commentCell = @"commentCell";


@interface VideoDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) UIImageView *containerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (nonatomic, strong) UIButton *playBtn;

@property (nonatomic, strong) NSString *assetURLs;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIButton *signBtn;
@property (nonatomic, strong) UIButton *headImgBtn;
@property (nonatomic, strong) UILabel *countLab;
@property (nonatomic, strong) UIButton *foucsBtn;
@property (nonatomic, strong) UIView *lineV;

@property(nonatomic,strong)UIButton *maskView;
@property(nonatomic,strong)UIView *baView;

@property (nonatomic,strong) NSMutableArray *datas;//底部tableview的数据
@property(nonatomic,strong)CJInputBar *conmentView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation VideoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:self.containerView];
    
    [self.containerView addSubview:self.playBtn];
//    [self.controlView addSubview:self.backBtn];
    
    
    if (!_maskView) {
        _maskView=[UIButton buttonWithType:UIButtonTypeCustom];
        _maskView.frame=self.view.frame;
        [_maskView setHidden:YES];
        [_maskView addTarget:self action:@selector(hidenKeyboard) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_maskView];
    }
    
    if (!_baView) {
        _baView=[[UIView alloc]initWithFrame:CGRectMake(0, IPHONEX_SET?(HEIGHT-50):(HEIGHT-50), WIDTH, 50)];
        [_baView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:_baView];
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 0.5)];
        [lineView setBackgroundColor:[UIColor lightGrayColor]];
        [_baView addSubview:lineView];
        
        UIButton *inptuBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 10, 227, 30)];
        [inptuBtn setBackgroundColor:[UIColor whiteColor]];
        [inptuBtn setImage:[UIImage imageNamed:@"qianbi"] forState:UIControlStateNormal];
        [inptuBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];

        [inptuBtn setTitle:@"发表回帖..." forState:UIControlStateNormal];
        [inptuBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
        inptuBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 228/255, 228/255, 231/255, 0.5 });
        [inptuBtn.layer setBorderColor:colorref];//边框颜色
        inptuBtn.layer.borderWidth = 0.5f;
        [inptuBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [inptuBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_baView addSubview:inptuBtn];
        
        UIButton *commentBtn=[[UIButton alloc]initWithFrame:CGRectMake(254, 10, 21, 21)];
        [commentBtn setImage:[UIImage imageNamed:@"论坛-帖子内容页底部回帖评论"] forState:UIControlStateNormal];
        [commentBtn addTarget:self action:@selector(commentClick:) forControlEvents:UIControlEventTouchUpInside];
        [_baView addSubview:commentBtn];
        
        UIButton *shoucangBtn=[[UIButton alloc]initWithFrame:CGRectMake(299, 10, 21, 21)];
        [shoucangBtn setImage:[UIImage imageNamed:@"论坛-帖子内容页底部回帖收藏按钮"] forState:UIControlStateNormal];
        [_baView addSubview:shoucangBtn];
        
        UIButton *shareBtn=[[UIButton alloc]initWithFrame:CGRectMake(339, 10, 21, 21)];
        [shareBtn setImage:[UIImage imageNamed:@"论坛-帖子内容页底部回帖转发"] forState:UIControlStateNormal];
        [_baView addSubview:shareBtn];
    }
    
    
    
    
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.nameLab];
    [self.view addSubview:self.headImgBtn];
    [self.view addSubview:self.signBtn];
    [self.view addSubview:self.foucsBtn];
    [self.view addSubview:self.lineV];
    [self.view addSubview:self.tableView];

    
    
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    //    KSMediaPlayerManager *playerManager = [[KSMediaPlayerManager alloc] init];
    //    ZFIJKPlayerManager *playerManager = [[ZFIJKPlayerManager alloc] init];
    /// 播放器相关
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.containerView];
    self.player.controlView = self.controlView;
    /// 设置退到后台继续播放
    self.player.pauseWhenAppResignActive = NO;
    @weakify(self)
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        @strongify(self)
        [self setNeedsStatusBarAppearanceUpdate];
    };
    
    /// 播放完成
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        [self.player.currentPlayerManager replay];
        //        [self.player playTheNext];
        //        if (!self.player.isLastAssetURL) {
        //            NSString *title = [NSString stringWithFormat:@"视频标题%zd",self.player.currentPlayIndex];
        //            [self.controlView showTitle:title coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeLandscape];
        //        } else {
        //            [self.player stop];
        //        }
        //        [self.player stop];
    };
    
    self.player.playerReadyToPlay = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, NSURL * _Nonnull assetURL) {
        NSLog(@"======开始播放了");
    };
    
    self.assetURLs = @"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4";
    NSURL *url=[NSURL URLWithString:self.assetURLs];
    
    self.player.assetURL = url;
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
}


//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;//    自动滚动调整，默认为YES
    [self setStatusBarBackgroundColor:[UIColor blackColor]];
    self.player.viewControllerDisappear = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.player.viewControllerDisappear = YES;
}



- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat x = 0;
//    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat y = CGRectGetMaxY([[UIApplication sharedApplication] statusBarFrame]);
    CGFloat w = WIDTH;
    CGFloat h = w*9/16;
    self.containerView.frame = CGRectMake(x, y, w, h);
    
    w = 44;
    h = w;
    x = (CGRectGetWidth(self.containerView.frame)-w)/2;
    y = (CGRectGetHeight(self.containerView.frame)-h)/2;
    self.playBtn.frame = CGRectMake(x, y, w, h);
    
    
    
    w = 25;
    h = 25;
    x = 12;
    y = 15+(IPHONEX_SET?44:20);
    self.backBtn.frame = CGRectMake(x, y, w, h);
    
    w = 285*WIDTHsCALE;
    h = 25;
    x = 15;
    y = (CGRectGetMaxY(self.containerView.frame)+15);
    self.nameLab.frame = CGRectMake(x, y, w, h);
    
    w = 41;
    h = 18;
    x = 15;
    y = (CGRectGetMaxY(self.nameLab.frame)+15);
    self.signBtn.frame = CGRectMake(x, y, w, h);
    
    w = 34;
    h = 34;
    x = 15;
    y = (CGRectGetMaxY(self.signBtn.frame)+15);
    self.headImgBtn.frame=CGRectMake(x, y, w, h);
    
    w = 74;
    h = 32;
    x = 286*WIDTHsCALE;
    y = (CGRectGetMaxY(self.signBtn.frame)+15);
    self.foucsBtn.frame=CGRectMake(x, y, w, h);
    
    w = WIDTH;
    h = 5;
    x = 0;
    y = CGRectGetMaxY(self.headImgBtn.frame)+15;
    self.lineV.frame=CGRectMake(x, y, w, h);
    
    w = WIDTH;
    h = (HEIGHT-CGRectGetMaxY(self.lineV.frame)-50);
    x = 0;
    y = CGRectGetMaxY(self.lineV.frame);
    self.tableView.frame=CGRectMake(x, y, w, h);
    
    
    
}


//加载更多数据
-(void)loadMoreData
{
    //延迟模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i=0; i<20; i++) {
            [self.datas addObject:@"1220202020202012312312314654651423156121561212312312310231"];
        }
        if (self.datas.count>=60) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView reloadData];
    });
}

//点击事件----通知
-(void)btnAction:(UIButton*)sender{
    self.conmentView.hidden=!self.conmentView.hidden;
    [self.conmentView.textView becomeFirstResponder];
}

-(void)keyboardShow:(NSNotification*)aNotification{
    NSDictionary *userInfo=[aNotification userInfo];
    NSValue *aValue=[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect=[aValue CGRectValue];
    int height=keyboardRect.size.height;
    CGFloat duration=[[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        [self.maskView setHidden:NO];
        [self.maskView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3]];
        [self.conmentView setFrame:CGRectMake(0, IPHONEX_SET?(HEIGHT-50-height):(HEIGHT-50-height), WIDTH, 50)];
    }];
}

-(void)keyboardHide:(NSNotification*)aNotification{
    NSDictionary *userInfo=[aNotification userInfo];
    CGFloat duration=[[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        [self.maskView setBackgroundColor:[UIColor clearColor]];
        [self.conmentView setFrame:CGRectMake(0, HEIGHT-50-50, WIDTH, 50)];
        self.conmentView.hidden=YES;
    } completion:^(BOOL finished) {
        [self.maskView setHidden:YES];
    }];
    _conmentView.hidden=YES;
    [self hidenKeyboard];
}

-(void)hidenKeyboard{
    [self.conmentView.textView resignFirstResponder];
}

- (void)commentClick:(id)sender {
    NSIndexPath * dayOne = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView scrollToRowAtIndexPath:dayOne atScrollPosition:UITableViewScrollPositionTop animated:YES];}



- (void)playClick:(UIButton *)sender {
    [self.player playTheIndex:0];
    [self.controlView showTitle:nil coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeLandscape];
}

- (void)backClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (UIStatusBarStyle)preferredStatusBarStyle {
    
        return UIStatusBarStyleLightContent;

}

- (BOOL)prefersStatusBarHidden {
    /// 如果只是支持iOS9+ 那直接return NO即可，这里为了适配iOS8
    return self.player.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (BOOL)shouldAutorotate {
    return self.player.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.player.isFullScreen) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    //    self.player.currentPlayerManager.muted = !self.player.currentPlayerManager.muted;
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.fastViewAnimated = YES;
//        _controlView.autoHiddenTimeInterval = 5;
//        _controlView.autoFadeTimeInterval = 0.5;
    }
    return _controlView;
}

- (UIImageView *)containerView {
    if (!_containerView) {
        _containerView = [UIImageView new];
        [_containerView setImageWithURLString:kVideoCover placeholder:[ZFUtilities imageWithColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] size:CGSizeMake(1, 1)]];
    }
    return _containerView;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"new_allPlay_44x44_"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}



- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"叉25*21白"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [UILabel new];
        _nameLab.text=@"找回青春时的感觉 小猫咪重生记";
        _nameLab.font=ControlFont(18);
    }
    return _nameLab;
}

-(UIButton *)signBtn{
    if (!_signBtn) {
        _signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_signBtn setTitle:@"喵咪" forState:UIControlStateNormal];
        _signBtn.titleLabel.font=ControlFont(11);
        [_signBtn setBackgroundColor:ZXColor(96, 146, 200)];
    }
    return _signBtn;
}

-(UIButton *)headImgBtn{
    if (!_headImgBtn) {
        _headImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_headImgBtn setImage:[UIImage imageNamed:@"广告图大小"] forState:UIControlStateNormal];
        _headImgBtn.imageView.layer.cornerRadius=17;
        
    }
    return _headImgBtn;
}

-(UIButton *)foucsBtn{
    if (!_foucsBtn) {
        _foucsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _foucsBtn.imageView.layer.cornerRadius = 5;
        [_foucsBtn setImage:[UIImage imageNamed:@"+关注按钮"] forState:UIControlStateNormal];
        
    }
    return _foucsBtn;
}

-(UIView*)lineV{
    if (!_lineV) {
        _lineV=[[UIView alloc]init];
        _lineV.backgroundColor=[UIColor lightGrayColor];
    }
    return _lineV;
}

-(UITableView*)tableView{
    if (!_tableView) {

        
        self.tableView=[[UITableView alloc]init];
        
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        self.tableView.mj_footer.automaticallyChangeAlpha=YES;
        self.tableView.dataSource=self;
        self.tableView.delegate=self;
        self.tableView.tableFooterView=[UIView new];
        [self.tableView registerClass:[CJCommentCell class] forCellReuseIdentifier:commentCell];
        self.tableView.estimatedRowHeight=100;
        
        self.datas=[NSMutableArray array];
        //一般新闻评论每页数据都是20条
        for (int i=0; i<20; i++) {
            [self.datas addObject:[NSString stringWithFormat:@"%d哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈张哈圣诞节奥斯卡了飞机撒浪费撒娇；房间爱上咖啡机奥斯卡了房间爱上开了房间爱上空间",i]];
        }
        [self.tableView reloadData];
    }
    

    
    return _tableView;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    view.backgroundColor=[UIColor whiteColor];
    
    UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    nameLab.text=@"最新回复";
    nameLab.font=ControlFont(16);
    nameLab.textAlignment=NSTextAlignmentLeft;
    
    [view addSubview:nameLab];
    
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CJCommentCell *cell=[tableView dequeueReusableCellWithIdentifier:commentCell];
    //    cell.textLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row];
    cell.strText=self.datas[indexPath.row];
    return cell;
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
