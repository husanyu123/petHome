//
//  CJVideoCell.m
//  CJKJ
//
//  Created by cw-006 on 2018/12/29.
//  Copyright © 2018 cw-006. All rights reserved.
//

#import "CJVideoCell.h"

@interface CJVideoCell ()

@property(nonatomic,weak)UILabel *titleLab;
@property(nonatomic,weak)UIImageView *NewImage;
@property(nonatomic,weak)UILabel *infoLab;
@property(nonatomic,weak)UILabel *dateLab;
@end

@implementation CJVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
    UILabel *titleLab=[[UILabel alloc]init];
    [titleLab setFrame:CGRectMake(16*WIDTHsCALE, 19*HEIGHTsCALE, 343*WIDTHsCALE, 20*HEIGHTsCALE)];
    [titleLab setFont:ControlFont(17)];
    titleLab.text=@"我可能买了条假狗，它解锁了这样的姿势";
    [self.contentView addSubview:titleLab];
    self.titleLab=titleLab;
    
    
    UIImageView *imgView=[[UIImageView alloc]init];
    [imgView setFrame:CGRectMake(16*WIDTHsCALE, 50*HEIGHTsCALE, 345*WIDTHsCALE, 195*HEIGHTsCALE)];
    imgView.backgroundColor=[UIColor lightGrayColor];
    [imgView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"Shape"]];
    
    UIButton *playBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [playBtn setImage:[UIImage imageNamed:@"播放图标"] forState:UIControlStateNormal];
    [imgView addSubview:playBtn];
    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(imgView);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    [self.contentView addSubview:imgView];
    self.NewImage=imgView;
    
    UILabel *infoLab=[[UILabel alloc]init];
    [infoLab setFrame:CGRectMake(16*WIDTHsCALE, 257*HEIGHTsCALE, 190*WIDTHsCALE, 17*HEIGHTsCALE)];
    infoLab.text=@"1023人气/250评论/二哈";
    
    [infoLab setFont:ControlFont(12)];
    [self.contentView addSubview:infoLab];
    self.infoLab=infoLab;
    
    UILabel *dateLab=[[UILabel alloc]init];
    [dateLab setFrame:CGRectMake(304*WIDTHsCALE, 257*HEIGHTsCALE, 56*WIDTHsCALE, 17*HEIGHTsCALE)];
    dateLab.text=@"2018/12/27";
    
    [dateLab setFont:ControlFont(10)];
    [self.contentView addSubview:dateLab];
    self.dateLab=dateLab;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
