//
//  UIView+ZWCommon.h
//  ZW微博
//
//  Created by rayootech on 16/2/6.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EaseBlankPageView;
typedef NS_ENUM(NSInteger,ZWBlankPageType)
{
    ZWBlankPageScoreView=0,
    ZWBlankPageScoreView2=1
};

@interface UIView (ZWCommon)
@property (strong, nonatomic) EaseBlankPageView *blankPageView;
- (void)configBlankPage:(ZWBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
@end

//无数据重新加载页
@interface EaseBlankPageView : UIView
@property (strong, nonatomic) UIImageView *bgiconView;
@property (strong, nonatomic) UILabel *tipLabel;
@property (strong, nonatomic) UIButton *reloadButton;
@property (copy, nonatomic) void(^reloadButtonBlock)(id sender);

- (void)configWithType:(ZWBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
@end