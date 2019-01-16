//
//  ZMCusCommentView.m
//  ZMZX
//
//  Created by Kennith.Zeng on 2018/8/29.
//  Copyright © 2018年 齐家网. All rights reserved.
//

#import "ZMCusCommentView.h"
#import "ZMCusCommentListView.h"
#import "ZMCusCommentToolView.h"
#import "UIView+Frame.h"
#import "AppDelegate.h"
@interface ZMCusCommentView()
@property (nonatomic, strong) UIControl *maskView;
@property (nonatomic, strong) ZMCusCommentListView *commentListView;
@property (nonatomic, strong) ZMCusCommentToolView *toolView;
@property (nonatomic, strong) UIControl *topMaskView;
@property (nonatomic, strong) NSString *historyText;
@property (nonatomic, assign) CGRect historyFrame;
@property (nonatomic, assign) BOOL isShowKeyboard;
@end

@implementation ZMCusCommentView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        self.backgroundColor = RGBHexColor(0x000000, 0.5);
        [self addSubview:self.toolView];
        [self layoutUI];
        
    }
    return self;
}
- (void)layoutUI{
    if (!_maskView) {
        _maskView = [[UIControl alloc] initWithFrame:self.frame];
        _maskView.backgroundColor = [UIColor clearColor];
        [_maskView addTarget:self action:@selector(maskViewClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_maskView];
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
            
        }];
    }
    if (!_commentListView) {
        _commentListView = [[ZMCusCommentListView alloc] initWithFrame:CGRectMake(0, HEIGHT, WIDTH, 0)];
        @weakify(self)
        _commentListView.closeBtnBlock = ^{
            @strongify(self)
            [self hideView];
        };
        _commentListView.tapBtnBlock = ^{
            @strongify(self)
            if (!self.isShowKeyboard) {
                [self showCommentToolView];
            }
     
            
        };
        [self addSubview:_commentListView];
    }
    if (!_topMaskView) {
        _topMaskView = [[UIControl alloc] initWithFrame:self.frame];
        _topMaskView.backgroundColor = [UIColor clearColor];
        _topMaskView.hidden = YES;
        [_topMaskView addTarget:self action:@selector(topMaskViewClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_topMaskView];
        [_topMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
            
        }];
    }


}
- (ZMCusCommentToolView *)toolView{
    
    if (!_toolView) {
        self.historyFrame = CGRectMake(0, 0, WIDTH, 47);
        _toolView = [[ZMCusCommentToolView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 47)];
        _toolView.hidden = YES;
        @weakify(self)
        _toolView.sendBtnBlock = ^{
            @strongify(self)
            [self hideCommentToolView];
        };
        _toolView.changeTextBlock = ^(NSString *text, CGRect frame) {
            @strongify(self)
            self.historyText = text;
            self.historyFrame = frame;
        };
    }
    return _toolView;
}
- (void)showCommentToolView{
    self.topMaskView.hidden = NO;
    self.toolView.hidden = NO;
    self.toolView.textView.inputAccessoryView = self.toolView;

    [self.toolView showTextView];
    if (self.historyFrame.size.height !=47) {
        self.toolView.frame = self.historyFrame;
    }
    if (self.toolView.textView.text.length<=0) {
        self.historyFrame = CGRectMake(0, 0, WIDTH, 47);
        [self.toolView resetView];
        self.toolView.frame = self.historyFrame;
    }
    self.isShowKeyboard = YES;
}
- (void)hideCommentToolView{
    self.topMaskView.hidden = YES;
    self.toolView.hidden = YES;
    self.isShowKeyboard = NO;
    [self.toolView hideTextView];
    [self addSubview:self.toolView];
}

- (void)maskViewClick{
    [self hideView];
}
- (void)topMaskViewClick{
    [self hideCommentToolView];
}
- (void)hideView{
    [self hideCommentToolView];
    [UIView animateWithDuration:0.2 animations:^{
        self.commentListView.frame = CGRectMake(0, HEIGHT, WIDTH, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
- (void)showView{
    [UIView animateWithDuration:0.2 animations:^{
        self.commentListView.frame = CGRectMake(0, ZMCusCommentViewTopHeight+100, WIDTH, HEIGHT-100);
    } completion:^(BOOL finished) {
        
    }];
}

@end

@implementation ZMCusCommentManager
+(instancetype)shareManager{
    static ZMCusCommentManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[ZMCusCommentManager alloc] init];
    });
    return instance;
}
- (void)showCommentWithSourceId:(NSString *)sourceId{
    
    ZMCusCommentView *view = [[ZMCusCommentView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:view];
    [view showView];
}
@end
