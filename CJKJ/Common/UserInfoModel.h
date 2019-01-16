//
//  UserInfoModel.h
//  CJKJ
//
//  Created by cw-006 on 2019/1/11.
//  Copyright © 2019 cw-006. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : NSObject
//赛事信息
@property(nonatomic,retain) NSString *mobile;
@property(nonatomic,retain) NSString *id_;
@property(nonatomic,retain) NSString *avatar;
@property(nonatomic,retain) NSString *score;
@property(nonatomic,retain) NSString *nickname;
@property(nonatomic,retain) NSString *expiretime;
@property(nonatomic,retain) NSString *username;
@property(nonatomic,retain) NSString * token;
@property(nonatomic,retain) NSString * user_id;  
@property(nonatomic,retain) NSString *createtime;
@property(nonatomic,assign) NSString *expires_in;


-(id)initWithDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
