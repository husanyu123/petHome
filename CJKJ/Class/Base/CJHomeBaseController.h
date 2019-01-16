//
//  CJHomeBaseController.h
//  CJKJ
//
//  Created by cw-006 on 2018/12/29.
//  Copyright © 2018 cw-006. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJHomeBaseController : UIViewController

/**NavBar*/
@property (strong, nonatomic) UINavigationBar *navBar;

/**NavItem*/
@property (strong, nonatomic) UINavigationItem *navItem;

/**Tableview*/
@property (strong, nonatomic) UITableView *tableView;

/**提示信息*/
@property (strong, nonatomic) NSString *messageStr;


/**
 布局UI界面
 */
-(void)setupUI;

/**
 下拉刷新，加载最新
 */
-(void)loadNewData;

/**
 上拉加载，加载更多
 */
-(void)loadMoreData;

@end

NS_ASSUME_NONNULL_END
