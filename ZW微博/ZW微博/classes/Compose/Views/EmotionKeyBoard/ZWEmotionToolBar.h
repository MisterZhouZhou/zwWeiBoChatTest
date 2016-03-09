//
//  ZWEmotionToolBar.h
//  ZW微博
//
//  Created by rayootech on 16/2/9.
//  Copyright © 2016年 rayootech. All rights reserved.
//   表情键盘底部表情工具条

#import <UIKit/UIKit.h>

typedef enum:NSInteger
{
    ZWEmotionTBarButtonTypeRecent,//最近
    ZWEmotionTBarButtonTypeDefault,//默认
    ZWEmotionTBarButtonTypeEmoji,//表情
    ZWEmotionTBarButtonTypeLXH//浪小花
    
}ZWEmotionTBarButtonType;

@class ZWEmotionToolBar;

@protocol ZWEmotionToolBarDelegate <NSObject>

@optional
-(void)emotionTabBar:(ZWEmotionToolBar *)tabBar didSelectButton:(ZWEmotionTBarButtonType)buttonType;

@end

@interface ZWEmotionToolBar : UIView

@property(nonatomic,weak)id <ZWEmotionToolBarDelegate>delegate;

@end
