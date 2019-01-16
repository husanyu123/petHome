//
//  CJPetForumController.m
//  CJKJ
//
//  Created by cw-006 on 2019/1/9.
//  Copyright © 2019 cw-006. All rights reserved.
//

#import "CJPetForumController.h"
#import "CJPetCell.h"
#import "IndexView.h"
#import "NSString+PinYin.h"
@interface CJPetForumController ()<IndexViewDelegate,IndexViewDataSource>
@property(nonatomic,strong) IndexView *indexView;
@property(nonatomic,strong) NSArray *dataArr;
@property (nonatomic, strong) NSMutableArray *brandArray;                       /**< 品牌名数组 */

@end

static NSString * const petCell = @"petCell";

@implementation CJPetForumController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //解析数据
    NSMutableArray *tempBrandArray = [NSMutableArray array];
    for (NSString *brandName in self.dataArr) {
        [tempBrandArray addObject:brandName];
    }
    //获取拼音首字母
    NSArray *indexArray= [tempBrandArray arrayWithPinYinFirstLetterFormat];
    self.brandArray = [NSMutableArray arrayWithArray:indexArray];
    
    
    
    //添加视图
    [self.view addSubview:self.indexView];
    //默认设置第一组
    [self.indexView setSelectionIndex:0];
    
}

-(void)setupUI{
    [super setupUI];
    [self.tableView.mj_header removeFromSuperview];
    [self.tableView registerClass:[CJPetCell class] forCellReuseIdentifier:petCell];
    
}

-(void)loadNewData{
    [super loadNewData];
    [self refreshData];
}

-(void)loadMoreData{
    [super loadMoreData];
    [self loadMore];
}

-(void)refreshData{
    __weak typeof(self)myself=self;
    [myself.tableView.mj_header endRefreshing];
    NSLog(@"aaaaa");
}


-(void)loadMore{
    __weak typeof(self)myself=self;
    [myself.tableView.mj_footer endRefreshing];
    NSLog(@"aaaaa");
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dict = self.brandArray[section];
    NSMutableArray *array = dict[@"content"];
    return [array count];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.brandArray count];

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    view.backgroundColor=ZXColor(243, 244, 247);
    
    UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(16, 7, 48, 16)];
    nameLab.text=self.brandArray[section][@"firstLetter"];
    nameLab.textColor=ZXColor(130, 144, 169);
    nameLab.font=ControlFont(11);
    
    [view addSubview:nameLab];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 56;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CJPetCell *cell=[tableView dequeueReusableCellWithIdentifier:petCell];
    NSDictionary *dict = self.brandArray[indexPath.section];
    NSMutableArray *array = dict[@"content"];
    NSLog(@"===============%@",array);
    //品牌
    NSString *brandInfo = array[indexPath.row];
    cell.title=brandInfo;
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (NSArray<NSString *> *)sectionIndexTitles {
    //搜索符号  [NSMutableArray arrayWithObject:UITableViewIndexSearch]; [NSMutableArray array];
    NSMutableArray *resultArray = [NSMutableArray arrayWithObject:UITableViewIndexSearch];
    for (NSDictionary *dict in self.brandArray) {
        NSString *title = dict[@"firstLetter"];
        if (title) {
            [resultArray addObject:title];
        }
    }
    return resultArray;
}

//当前选中组
- (void)selectedSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index-1] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (IndexView *)indexView {
    if (!_indexView) {
        _indexView = [[IndexView alloc] initWithFrame:CGRectMake(WIDTH - 30, 64, 30, HEIGHT - 64)];
        _indexView.delegate = self;
        _indexView.dataSource = self;
    }
    return _indexView;
}

-(NSArray*)dataArr{
    if (!_dataArr) {
        _dataArr = @[@"二哈",@"喵咪",@"铲屎官",@"汪星人",@"大象",@"鳄鱼",@"老鼠",@"黑猩猩",@"长颈鹿",@"跳蚤",@"狮子",@"老虎",@"豹子",@"河马",@"蛇",@"猴子",@"海豹",@"金鱼"];
    }
    return _dataArr;
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
