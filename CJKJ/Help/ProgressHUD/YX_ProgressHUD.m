//
//  YX_ProgressHUD.m
//  YXECG
//
//  Created by wang on 2016/11/17.
//  Copyright © 2016年 WangGX. All rights reserved.
//

#import "YX_ProgressHUD.h"
#import <MBProgressHUD.h>

@interface YX_ProgressHUD()


@end

@implementation YX_ProgressHUD

static MBProgressHUD *_hud;

//提示信息
+(void)showHUDAddedTo:(UIView *)view animated:(BOOL)animated progressType:(YXProgressHUD)progressType text:(NSString *)text
{
    [self showHUDAddedTo:view animated:animated progressType:progressType text:text hiddenWith:3.f];
}

//提示信息加显示时间
+(void)showHUDAddedTo:(UIView *)view animated:(BOOL)animated progressType:(YXProgressHUD)progressType text:(NSString *)text hiddenWith:(NSTimeInterval)time
{
    [_hud hideAnimated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:animated];
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.margin = 10;
    hud.offset = CGPointMake(0.f, HEIGHT * 0.5 - 44 - 40);
    hud.square = NO;

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

    switch (progressType) {
        case YXProgressHUDSUCCESS://成功
            [btn setImage:[UIImage imageNamed:@"成功"] forState:UIControlStateNormal];
            break;
        case YXProgressHUDERROR://错误
            [btn setImage:[UIImage imageNamed:@"失败"] forState:UIControlStateNormal];
            break;
        case YXProgressHUDINFO://提示
            [btn setImage:[UIImage imageNamed:@"注意"] forState:UIControlStateNormal];
            break;

        default:
            break;
    }
    [btn setTitle:[NSString stringWithFormat:@"  %@", text] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    hud.customView = btn;

    [hud hideAnimated:YES afterDelay:time];
}

//小菊花
+(void)showHUDAddedTo:(UIView *)view animated:(BOOL)animated
{
    _hud = [MBProgressHUD showHUDAddedTo:view animated:animated];
    _hud.contentColor = [UIColor whiteColor];
    _hud.bezelView.backgroundColor = [UIColor blackColor];
    _hud.margin = 10;
}

//隐藏
+(void)hideAnimated:(BOOL)animated
{
    [_hud hideAnimated:animated];
}





@end
