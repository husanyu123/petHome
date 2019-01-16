//
//  CJSegmentVC.h
//  CJKJ
//
//  Created by cw-006 on 2019/1/9.
//  Copyright © 2019 cw-006. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGSegmentBar.h"
NS_ASSUME_NONNULL_BEGIN

@interface CJSegmentVC : UIViewController
@property (nonatomic, weak) TGSegmentBar *segmentBar;//供外界修改其父view
@property (nonatomic,assign) NSInteger defaultSelectedIndex;
- (void)setupWithItems: (NSArray <NSString *>*)items childVCs: (NSArray <UIViewController *>*)childVCs;
@end

NS_ASSUME_NONNULL_END
