//
//  CJKeepCell.m
//  CJKJ
//
//  Created by cw-006 on 2019/1/9.
//  Copyright © 2019 cw-006. All rights reserved.
//

#import "CJKeepCell.h"

@interface CJKeepCell ()

@property(nonatomic,weak)UILabel *nameLab;

@end

@implementation CJKeepCell

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
    UILabel *nameLab=[[UILabel alloc]init];
    [nameLab setFrame:CGRectMake(17, 17, 86, 22)];
    [nameLab setFont:ControlFont(16)];
    nameLab.text=@"铲屎官论坛";
    [self.contentView addSubview:nameLab];
    self.nameLab=nameLab;
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
