//
//  imageNewsCell.m
//  CJKJ
//
//  Created by cw-006 on 2018/12/29.
//  Copyright © 2018 cw-006. All rights reserved.
//

#import "imageNewsCell.h"

@interface imageNewsCell ()

@property(nonatomic,weak)UILabel *titleLab;
@property(nonatomic,weak)UIImageView *NewImage1;
@property(nonatomic,weak)UIImageView *NewImage2;
@property(nonatomic,weak)UIImageView *NewImage3;
@property(nonatomic,weak)UILabel *infoLab;
@property(nonatomic,weak)UILabel *dateLab;
@end

@implementation imageNewsCell

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
    //标题
    UILabel *titleLab=[[UILabel alloc]init];
    [titleLab setFrame:CGRectMake(16*WIDTHsCALE, 15*HEIGHTsCALE, 343*WIDTHsCALE, 20)];
    [titleLab setFont:ControlFont(17)];
    titleLab.text=@"我可能买了条假狗，它解锁了这样的姿势";
    [self.contentView addSubview:titleLab];
    self.titleLab=titleLab;
    //图片
    UIImageView *newsImage1=[[UIImageView alloc]init];
    [newsImage1 setFrame:CGRectMake(16*WIDTHsCALE,44*HEIGHTsCALE, 110*WIDTHsCALE,89*HEIGHTsCALE)];
    newsImage1.backgroundColor=[UIColor lightGrayColor];
    [newsImage1 sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"Photo 2"]];
    
    [self.contentView addSubview:newsImage1];
    self.NewImage1=newsImage1;
    
    UIImageView *newsImage2=[[UIImageView alloc]init];
    [newsImage2 setFrame:CGRectMake(CGRectGetMaxX(newsImage1.frame)+6.5*WIDTHsCALE, 44*HEIGHTsCALE, 110*WIDTHsCALE, 89*HEIGHTsCALE)];
    newsImage2.backgroundColor=[UIColor lightGrayColor];
    [newsImage2 sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"Photo 2"]];

    
    [self.contentView addSubview:newsImage2];
    self.NewImage2=newsImage2;
    
    UIImageView *newsImage3=[[UIImageView alloc]init];
    [newsImage3 setFrame:CGRectMake(CGRectGetMaxX(newsImage2.frame)+6.5*WIDTHsCALE, 44*HEIGHTsCALE, 110*WIDTHsCALE, 89*HEIGHTsCALE)];
    [newsImage3 sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"Photo 2"]];

    
    newsImage3.backgroundColor=[UIColor lightGrayColor];
    
    [self.contentView addSubview:newsImage3];
    self.NewImage3=newsImage3;
    //信息
    UILabel *infoLab=[[UILabel alloc]init];
    [infoLab setFrame:CGRectMake(16*WIDTHsCALE, 146*HEIGHTsCALE, 171*WIDTHsCALE, 17*HEIGHTsCALE)];
    infoLab.text=@"1023人气/250评论/二哈";
    [infoLab setFont:ControlFont(12)];
    [self.contentView addSubview:infoLab];
    self.infoLab=infoLab;
    //日期
    UILabel *dateLab=[[UILabel alloc]init];
    [dateLab setFrame:CGRectMake(304*WIDTHsCALE, 146*HEIGHTsCALE, 56*WIDTHsCALE, 17*HEIGHTsCALE)];
    dateLab.text=@"2018/12/28";
    [dateLab setFont:ControlFont(12)];
    
    [self.contentView addSubview:dateLab];
    self.dateLab=dateLab;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
