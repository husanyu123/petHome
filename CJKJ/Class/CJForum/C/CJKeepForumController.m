//
//  CJKeepForumController.m
//  CJKJ
//
//  Created by cw-006 on 2019/1/9.
//  Copyright © 2019 cw-006. All rights reserved.
//

#import "CJKeepForumController.h"
#import "CJKeepCell.h"
@interface CJKeepForumController ()

@end
static NSString * const KeepCell = @"keepCell";
@implementation CJKeepForumController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)setupUI{
    [super setupUI];
    [self.tableView.mj_header removeFromSuperview];
    [self.tableView registerClass:[CJKeepCell class] forCellReuseIdentifier:KeepCell];
    
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
    if (section==0) {
        return 5;
    }
    else{
        return 10;

    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    view.backgroundColor=ZXColor(243, 244, 247);
    
    UILabel *nameLab=[[UILabel alloc]initWithFrame:CGRectMake(16, 7, 48, 16)];
    if (section==0) {
        nameLab.text=@"收藏论坛";
    }
    else{
        nameLab.text=@"常去论坛";

    }
    nameLab.textColor=ZXColor(130, 144, 169);
    nameLab.font=ControlFont(11);
    nameLab.textAlignment=NSTextAlignmentRight;
    
    [view addSubview:nameLab];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 56;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CJKeepCell *cell=[tableView dequeueReusableCellWithIdentifier:KeepCell];
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
