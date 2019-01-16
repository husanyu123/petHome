//
//  YX_ProgressHUD.h
//  YXECG
//
//  Created by wang on 2016/11/17.
//  Copyright © 2016年 WangGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, YXProgressHUD) {
    /** 成功*/
    YXProgressHUDSUCCESS,
    /** 失败*/
    YXProgressHUDERROR,
    /** 提示*/
    YXProgressHUDINFO,
};

typedef void(^Completion)();

@interface YX_ProgressHUD : NSObject
/**提示信息*/
+ (void)showHUDAddedTo:(UIView *)view animated:(BOOL)animated progressType:(YXProgressHUD)progressType text:(NSString *)text;
/**显示小菊花*/
+(void)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;
/**隐藏小菊花*/
+(void)hideAnimated:(BOOL)animated;
/**提示信息加显示时间*/
+ (void)showHUDAddedTo:(UIView *)view animated:(BOOL)animated progressType:(YXProgressHUD)progressType text:(NSString *)text hiddenWith:(NSTimeInterval)time;

@end
