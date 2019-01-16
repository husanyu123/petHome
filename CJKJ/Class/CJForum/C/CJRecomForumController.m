//
//  CJRecomForumController.m
//  CJKJ
//
//  Created by cw-006 on 2019/1/9.
//  Copyright © 2019 cw-006. All rights reserved.
//

#import "CJRecomForumController.h"
#import "CJContentCell.h"

@interface CJRecomForumController ()

@end
static NSString * const contentCell = @"contentDataCell";

@implementation CJRecomForumController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];

}

-(void)setupUI{
    [super setupUI];
    
    [self.tableView registerClass:[CJContentCell class] forCellReuseIdentifier:contentCell];
    
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
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120*HEIGHTsCALE;
   
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        CJContentCell *cell=[tableView dequeueReusableCellWithIdentifier:contentCell];
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
