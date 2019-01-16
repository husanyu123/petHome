//
//  WebViewController.m
//  CJKJ
//
//  Created by cw-006 on 2018/12/29.
//  Copyright © 2018 cw-006. All rights reserved.
//

#import "WebViewController.h"
#import "CJNewsDetailView.h"
#import <MJRefresh.h>
#import <Masonry.h>
#import "CJInputBar.h"
#import "CJCommentCell.h"
@interface WebViewController ()<UITableViewDelegate,UITableViewDataSource,WKNavigationDelegate>

@property (nonatomic,strong) NSMutableArray *datas;//底部tableview的数据
@property (nonatomic,weak) CJNewsDetailView *detailWebContainer;
@property(nonatomic,strong)UIButton *maskView;
@property(nonatomic,strong)UIView *baView;
@property(nonatomic,strong)CJInputBar *conmentView;
@end
static NSString * const commentCell = @"commentCell";

@implementation WebViewController

-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
//    self.edgesForExtendedLayout=UIRectEdgeTop;
    UIBarButtonItem *leftBaritem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"9*14箭头纯黑"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem=leftBaritem;
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    self.navigationController.navigationBar.translucent=NO;
    
    [self setupViews];
    
    if (!_maskView) {
        _maskView=[UIButton buttonWithType:UIButtonTypeCustom];
        _maskView.frame=self.view.frame;
        [_maskView setHidden:YES];
        [_maskView addTarget:self action:@selector(hidenKeyboard) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_maskView];
    }
    
    if (!_baView) {
        _baView=[[UIView alloc]initWithFrame:CGRectMake(0, IPHONEX_SET?(HEIGHT-88-50):(HEIGHT-64-50), WIDTH, 50)];
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
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];

    
    
}

//使用自己创建的WKWebview和UITableview
-(void)setupViews
{
   
    
    CJNewsDetailView *container=[[CJNewsDetailView alloc]init];
    WKWebView *webview=[[WKWebView alloc]init];
    webview.backgroundColor=[UIColor whiteColor];
    
    UITableView *tableview=[[UITableView alloc]init];
    [container configueWebview:webview tableview:tableview];
    
    container.URLString=@"https://www.chongwu001.com/article/3740.html";
    container.tableview.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    container.tableview.mj_footer.automaticallyChangeAlpha=YES;
    container.tableview.dataSource=self;
    container.tableview.delegate=self;
    container.tableview.tableFooterView=[UIView new];
    container.webview.navigationDelegate=self;
    [container.tableview registerClass:[CJCommentCell class] forCellReuseIdentifier:commentCell];
    container.tableview.estimatedRowHeight=100;
    self.detailWebContainer=container;
    [self.view addSubview:container];
    container.frame=CGRectMake(0, 0, self.view.frame.size.width, IPHONEX_SET?(HEIGHT-88-50):(HEIGHT-64-50));
//    [self loadClick:nil];
    [self loadData];
    
    
}

-(void)loadData{
    [self.detailWebContainer loadRequest];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    self.datas=[NSMutableArray array];
    //一般新闻评论每页数据都是20条
    for (int i=0; i<20; i++) {
        [self.datas addObject:[NSString stringWithFormat:@"%d哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈张哈圣诞节奥斯卡了飞机撒浪费撒娇；房间爱上咖啡机奥斯卡了房间爱上开了房间爱上空间",i]];
    }
    [self.detailWebContainer.tableview reloadData];
}

-(void)loadMoreData
{
    //延迟模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i=0; i<20; i++) {
            [self.datas addObject:@"1220202020202012312312314654651423156121561212312312310231"];
        }
        if (self.datas.count>=60) {
            [self.detailWebContainer.tableview.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.detailWebContainer.tableview.mj_footer endRefreshing];
        }
        [self.detailWebContainer.tableview reloadData];
    });
}


-(void)btnAction:(UIButton*)sender{
    self.conmentView.hidden=!self.conmentView.hidden;
    [self.conmentView.textView becomeFirstResponder];
}

-(CJInputBar*)conmentView{
    __weak typeof(self)myself=self;

    if (!_conmentView) {
        _conmentView=[[CJInputBar alloc]initWithFrame:CGRectMake(0, HEIGHT-50-50, WIDTH, 50)];
        _conmentView.EwenTextViewBlock=^(NSString *str){
            NSLog(@"==========%@",str);
            [myself.datas insertObject:str atIndex:0];
            [myself.detailWebContainer.tableview reloadData];
        };
        NSLog(@"156210000000000000000==");
        _conmentView.hidden=YES;
        [self.view addSubview:self.conmentView];
    }
    return _conmentView;
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
        [self.conmentView setFrame:CGRectMake(0, IPHONEX_SET?(HEIGHT-50-height-88):(HEIGHT-50-height-64), WIDTH, 50)];
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
    [self.detailWebContainer scrollToWebviewOrTableView];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
