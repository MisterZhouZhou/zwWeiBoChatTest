//
//  HWEmotionPopView.h
//  黑马微博2期
//
//  Created by apple on 14-10-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWEmotion;
@class ZWEmotionButton;
@interface ZWEmotionPopView : UIView

+ (instancetype)popView;

//@property (nonatomic, strong) ZWEmotion *emotion;

//弹出放大镜
-(void)showFrom:(ZWEmotionButton*)btn;
@end
