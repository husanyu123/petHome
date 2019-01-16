//
//  UserInfoModel.m
//  CJKJ
//
//  Created by cw-006 on 2019/1/11.
//  Copyright © 2019 cw-006. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

-(id)initWithDictionary:(NSDictionary *)dict{
    if (self=[super init]) {
        self.id_=dict[@"id"];
        self.mobile = dict[@"mobile"];
        self.nickname = dict[@"nickname"];
        self.score = dict[@"score"];
        self.expiretime = dict[@"expiretime"];
        self.username =dict[@"username"];
        self.token = dict[@"token"];
        self.createtime = dict[@"createtime"];
        self.user_id = dict[@"user_id"];
        self.expires_in = dict[@"expires_in"];
        
    }
    return self;
}

@end
