//
//  CJFocusController.m
//  CJKJ
//
//  Created by cw-006 on 2018/12/29.
//  Copyright © 2018 cw-006. All rights reserved.
//

#import "CJFocusController.h"
#import "imageNewsCell.h"
#import "CJVideoCell.h"
#import "CJContentCell.h"
#import "VideoDetailViewController.h"
#import "WebViewController.h"
@interface CJFocusController ()

@end
static NSString * const VideoCell = @"gameDataCell";
static NSString * const contentCell = @"contentDataCell";
static NSString * const imgCell = @"imgDataCell";
@implementation CJFocusController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)setupUI{
    [super setupUI];
    
    [self.tableView registerClass:[CJVideoCell class] forCellReuseIdentifier:VideoCell];
    [self.tableView registerClass:[CJContentCell class] forCellReuseIdentifier:contentCell];
    [self.tableView registerClass:[imageNewsCell class] forCellReuseIdentifier:imgCell];
    
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
    if (indexPath.row==0||indexPath.row==4||indexPath.row==7) {
        return 290*HEIGHTsCALE;
    }
    else if (indexPath.row==1||indexPath.row==3||indexPath.row==8||indexPath.row==9){
        return 120*HEIGHTsCALE;
    }
    else if (indexPath.row==2||indexPath.row==5||indexPath.row==6){
        return 180*HEIGHTsCALE;
    }
    else{
        return 290*HEIGHTsCALE;
    }}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0||indexPath.row==4||indexPath.row==7) {
        CJVideoCell *cell=[tableView dequeueReusableCellWithIdentifier:VideoCell];
        return cell;
    }
    else if (indexPath.row==1||indexPath.row==3||indexPath.row==8||indexPath.row==9){
        CJContentCell *cell=[tableView dequeueReusableCellWithIdentifier:contentCell];
        return cell;
    }
    else if (indexPath.row==2||indexPath.row==5||indexPath.row==6){
        imageNewsCell *cell=[tableView dequeueReusableCellWithIdentifier:imgCell];
        return cell;
    }
    else{

        return nil;
    }
  
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0||indexPath.row==4||indexPath.row==7) {
        VideoDetailViewController *videoDetail=[[VideoDetailViewController alloc]init];
//        [self.navigationController pushViewController:videoDetail animated:YES];
        [self presentViewController:videoDetail animated:YES completion:nil];
    }
    else if (indexPath.row==1||indexPath.row==3||indexPath.row==8||indexPath.row==9){
        WebViewController *webV=[[WebViewController alloc]init];
        
//        [self presentViewController:webV animated:YES completion:nil];
         webV.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:webV animated:YES];
        [self.navigationController setNavigationBarHidden:NO];
        
    }
    
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
