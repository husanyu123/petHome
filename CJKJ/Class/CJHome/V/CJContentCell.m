//
//  CJContentCell.m
//  CJKJ
//
//  Created by cw-006 on 2018/12/29.
//  Copyright © 2018 cw-006. All rights reserved.
//

#import "CJContentCell.h"

@interface CJContentCell ()

@property(nonatomic,weak)UILabel *titleLab;
@property(nonatomic,weak)UIImageView *NewImage;
@property(nonatomic,weak)UILabel *infoLab;
@property(nonatomic,weak)UILabel *dateLab;
@end

@implementation CJContentCell

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
    [titleLab setFrame:CGRectMake(16*WIDTHsCALE, 16*HEIGHTsCALE, 218*WIDTHsCALE, 44*HEIGHTsCALE)];
    [titleLab setFont:ControlFont(16)];
    titleLab.text=@"我可能买了条假狗，它解锁了这样的姿势";
    [self.contentView addSubview:titleLab];
    self.titleLab=titleLab;
    
    UILabel *infoLab=[[UILabel alloc]init];
    [infoLab setFrame:CGRectMake(16*WIDTHsCALE, 88*HEIGHTsCALE, 190*WIDTHsCALE, 17*HEIGHTsCALE)];
    infoLab.text=@"1023人气/250评论/二哈";
    [infoLab setFont:ControlFont(12)];
    [self.contentView addSubview:infoLab];
    self.infoLab=infoLab;
    
    UIImageView *imgView=[[UIImageView alloc]init];
    [imgView setFrame:CGRectMake(247*WIDTHsCALE, 19*HEIGHTsCALE, 113*WIDTHsCALE, 86)];
    imgView.backgroundColor=[UIColor lightGrayColor];
    [imgView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"广告图大小"]];
    [self.contentView addSubview:imgView];
    self.NewImage=imgView;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
