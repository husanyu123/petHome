//
//  CJCommentCell.m
//  CJKJ
//
//  Created by cw-006 on 2019/1/8.
//  Copyright © 2019 cw-006. All rights reserved.
//

#import "CJCommentCell.h"

@interface CJCommentCell ()

@property(nonatomic,strong)UIButton *logoImg;
@property(nonatomic,strong)UILabel *content;
@property(nonatomic,strong)UILabel *dateLab;
@property(nonatomic,strong)UIButton *supportBtn;
@property(nonatomic,strong)UIButton *sayBtn;

@end

@implementation CJCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



//set方法赋值
- (void)setStrText:(NSString*)strText{
    self.content.text= strText;
    
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configureUI];
        
        
    }
    return self;
}

-(void)configureUI{
    //头像
    _logoImg=[UIButton buttonWithType:UIButtonTypeCustom];
    _logoImg.layer.cornerRadius=12.5;
    [_logoImg setImage:[UIImage imageNamed:@"Mask"] forState:UIControlStateNormal];
    [self.contentView addSubview:_logoImg];
    [_logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.left.equalTo(self.contentView);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    
    
    
    //评论内容
    _content=[[UILabel alloc]init];
    _content.backgroundColor=[UIColor whiteColor];
    _content.font=ControlFont(16);
    _content.numberOfLines=0;
    [self.contentView addSubview:_content];
    [_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(25);
        make.top.equalTo(self.logoImg.mas_bottom).offset(10);
        make.width.mas_equalTo(300);
        make.bottom.equalTo(self.contentView).priorityLow();
    }];
    
    //时间
    _dateLab=[[UILabel alloc]init];
    _dateLab.backgroundColor=[UIColor whiteColor];
    _dateLab.font=ControlFont(11);
    _dateLab.text=@"01-09 12:25";
    _dateLab.textColor=[UIColor lightGrayColor];
    [self.contentView addSubview:_dateLab];
    [_dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(25);
        make.top.equalTo(self.content.mas_bottom).offset(5);
        make.width.mas_equalTo(64);
        make.height.mas_equalTo(16);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    //点赞
    _supportBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_supportBtn setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateNormal];
    [_supportBtn setTitle:@"1" forState:UIControlStateNormal];
    [_supportBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 0)];
    [_supportBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _supportBtn.titleLabel.font=ControlFont(12);
    [self.contentView addSubview:_supportBtn];
    [_supportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(255*WIDTHsCALE);
        make.top.equalTo(self.content.mas_bottom).offset(5);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(25);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    _sayBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_sayBtn setImage:[UIImage imageNamed:@"最新回复回复按钮"] forState:UIControlStateNormal];
    [_sayBtn setTitle:@"回复" forState:UIControlStateNormal];
    [_sayBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 0)];
    [_sayBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    _sayBtn.titleLabel.font=ControlFont(12);
    [self.contentView addSubview:_sayBtn];
    [_sayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(315*WIDTHsCALE);
        make.top.equalTo(self.content.mas_bottom).offset(5);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(25);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
