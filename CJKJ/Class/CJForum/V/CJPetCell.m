//
//  CJPetCell.m
//  CJKJ
//
//  Created by cw-006 on 2019/1/9.
//  Copyright © 2019 cw-006. All rights reserved.
//

#import "CJPetCell.h"
@interface CJPetCell ()

@property(nonatomic,weak)UILabel *nameLab;
@property(nonatomic,weak)UIImageView *petImg;
@end
@implementation CJPetCell

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
    
    UIImageView *petImg=[[UIImageView alloc]init];
    [petImg setFrame:CGRectMake(15, 13, 40, 31)];
    petImg.layer.cornerRadius=15.5;
    petImg.image=[UIImage imageNamed:@"Rectangle 15"];
    [self.contentView addSubview:petImg];
    self.petImg=petImg;
    
    UILabel *nameLab=[[UILabel alloc]init];
    [nameLab setFrame:CGRectMake(70, 18, 40, 22)];
    [nameLab setFont:ControlFont(16)];
    nameLab.text=self.title;
    [self.contentView addSubview:nameLab];
    self.nameLab=nameLab;
    
    
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.nameLab.text=title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
