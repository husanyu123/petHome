//
//  CJVideoController.m
//  CJKJ
//
//  Created by cw-006 on 2018/12/29.
//  Copyright © 2018 cw-006. All rights reserved.
//

#import "CJVideoController.h"
#import "CJVideoCell.h"

@interface CJVideoController ()

@end
static NSString * const VideoCell = @"gameDataCell";

@implementation CJVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];

}

-(void)setupUI{
    [super setupUI];
    
    [self.tableView registerClass:[CJVideoCell class] forCellReuseIdentifier:VideoCell];
    
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
    
        return 290*HEIGHTsCALE;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        CJVideoCell *cell=[tableView dequeueReusableCellWithIdentifier:VideoCell];
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
