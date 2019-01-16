//
//  singleten.m
//  CJKJ
//
//  Created by cw-006 on 2019/1/11.
//  Copyright © 2019 cw-006. All rights reserved.
//

#import "singleten.h"
@implementation singleten

+(singleten *)shareUserModel{
    
    static singleten *singleten = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleten = [[self alloc] init];
    });
    
    return singleten;
    
}

@end
