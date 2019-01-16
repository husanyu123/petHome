//
//  CJInputBar.h
//  CJKJ
//
//  Created by cw-006 on 2019/1/8.
//  Copyright © 2019 cw-006. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJInputBar : UIView


@property(nonatomic,copy)void(^EwenTextViewBlock)(NSString *text);
//-------设置占位符------//
-(void)setPlaceholderText:(NSString*)text;
@property(nonatomic,strong)UITextView *textView;
@end

NS_ASSUME_NONNULL_END
