//
//  CJTinyVideoController.h
//  CJKJ
//
//  Created by cw-006 on 2019/1/3.
//  Copyright © 2019 cw-006. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZFPlayer/ZFPlayerControlView.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJTinyVideoController : UIViewController

- (void)playTheIndex:(NSInteger)index;
@property (nonatomic, strong) ZFPlayerController *player;

@end

NS_ASSUME_NONNULL_END
