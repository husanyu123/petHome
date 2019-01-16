//
//  CJInputBar.m
//  CJKJ
//
//  Created by cw-006 on 2019/1/8.
//  Copyright © 2019 cw-006. All rights reserved.
//

#import "CJInputBar.h"
#import <Masonry.h>
#import <YYModel.h>

@interface CJInputBar()<UITextViewDelegate,UIScrollViewDelegate>
{
    BOOL statusTextView;
    NSString *placeholderText;
}
@property(nonatomic,strong)UIView *backGroundView;
@property(nonatomic,strong)UILabel *placeholderLable;
@property(nonatomic,strong)UIButton *sendBtn;
@property(nonatomic,strong)UIView *lineView;


@end

@implementation CJInputBar

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self creatUI];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    }
    //点击空白处
    UITapGestureRecognizer *centerTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(centerTapClick)];
    [self addGestureRecognizer:centerTap];
    return  self;
    
}

-(void)creatUI{
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.left.mas_equalTo(35);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(WIDTH-100);

    }];
    
    [self.placeholderLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(4);
        make.left.mas_equalTo(50);
        make.height.mas_equalTo(39);
        
    }];
    
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.textView);
        make.right.mas_equalTo(-5);
        make.width.mas_equalTo(50);
        
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40);
        
    }];
}

-(void)setPlaceholderText:(NSString *)text{
    placeholderText=text;
    self.placeholderLable.text=placeholderText;
}

-(void)keyboardShow:(NSNotification*)aNotification{
    
}

//键盘退出时调用
-(void)keyboardHide:(NSNotification*)aNotification{
    NSString *str=self.textView.text;
    //过滤字符串
    NSString *contentStr=[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    contentStr=[contentStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.textView.text=contentStr;
    if (self.textView.text.length==0) {
        self.placeholderLable.text=placeholderText;
        _sendBtn.enabled=NO;
    }
    
    
}


-(void)centerTapClick{
    [self.textView resignFirstResponder];
}

#pragma mark ---UItextViewDelegate

-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length==0) {
        self.placeholderLable.text=placeholderText;
        _sendBtn.enabled=NO;
    }
    else{
        self.placeholderLable.text=placeholderText;
        _sendBtn.enabled=YES;
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
        //限制输入个数
    NSInteger exisLength=textView.text.length;
    NSInteger selectLength=range.length;
    NSInteger replaceLength=text.length;
    if (exisLength-selectLength+replaceLength>140) {
        return NO;
    }
    return YES;
}

#pragma mark --- 发送评论
-(void)sendClick:(UIButton*)sender{
    [self.textView endEditing:YES];
    if (self.EwenTextViewBlock) {
        self.EwenTextViewBlock(self.textView.text);
    }
    //发送成功后清空
    self.textView.text=nil;
    self.placeholderLable.text=placeholderText;
    self.sendBtn.enabled=NO;
    self.backGroundView.frame=CGRectMake(0, 0, WIDTH, 50);
    
}

//***********************************************//
#pragma mark --- 懒加载控件
-(UIView*)backGroundView{
    if (!_backGroundView) {
        _backGroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
        _backGroundView.backgroundColor=[UIColor whiteColor];
        [self addSubview:_backGroundView];
        
        _lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 60, WIDTH, 0.3)];
            [_lineView setBackgroundColor:[UIColor lightGrayColor]];
            // Fallback on earlier versions
        
        [_backGroundView addSubview:_lineView];
        
    }
    return _backGroundView;
}

-(UITextView*)textView{
    if (!_textView) {
        _textView=[[UITextView alloc]init];
        _textView.font=ControlFont(15);
            [_textView setTextColor:[UIColor blackColor]];
       
        _textView.delegate=self;
        _textView.layer.cornerRadius=15;
            _textView.backgroundColor=[UIColor whiteColor];
            // Fallback on earlier versions
        
        _textView.textContainerInset=UIEdgeInsetsMake(8, 10, 4, 10);
        [self.backGroundView addSubview:_textView];
    }
    return _textView;
}

-(UILabel*)placeholderLable{
    if (!_placeholderLable) {
        _placeholderLable=[[UILabel alloc]init];
        _placeholderLable.font=ControlFont(16);
        _placeholderLable.textColor=[UIColor grayColor];
        _placeholderLable.textAlignment=NSTextAlignmentLeft;
        [self.backGroundView addSubview:_placeholderLable];
    }
    return _placeholderLable;
}

-(UIButton*)sendBtn{
    if (!_sendBtn) {
        _sendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sendBtn setTitle:@"发布" forState:UIControlStateNormal];
        [_sendBtn.titleLabel setFont:ControlFont(15)];
        [_sendBtn addTarget:self action:@selector(sendClick:) forControlEvents:UIControlEventTouchUpInside];
        _sendBtn.enabled=NO;
        [self.backGroundView addSubview:_sendBtn];
    }
    return _sendBtn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
