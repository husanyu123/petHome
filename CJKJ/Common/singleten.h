//
//  singleten.h
//  CJKJ
//
//  Created by cw-006 on 2019/1/11.
//  Copyright © 2019 cw-006. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface singleten : NSObject
+(singleten *)shareUserModel;

@property (nonatomic,strong) UserInfoModel *model;
@end

NS_ASSUME_NONNULL_END
