//
//  CJRecommendController.m
//  CJKJ
//
//  Created by cw-006 on 2018/12/29.
//  Copyright © 2018 cw-006. All rights reserved.
//

#import "CJRecommendController.h"
#import "imageNewsCell.h"
#import "CJVideoCell.h"
#import "CJContentCell.h"
@interface CJRecommendController ()

@end
static NSString * const VideoCell = @"gameDataCell";
static NSString * const contentCell = @"contentDataCell";
static NSString * const imgCell = @"imgDataCell";
@implementation CJRecommendController

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
