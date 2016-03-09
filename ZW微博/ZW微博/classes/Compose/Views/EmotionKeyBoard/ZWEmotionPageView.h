//
//  ZWEmotionPageView.h
//  ZW微博
//
//  Created by rayootech on 16/2/10.
//  Copyright © 2016年 rayootech. All rights reserved.
//   用来表示一页的表情（1-20个表情）

#import <UIKit/UIKit.h>


//一行最多是7列  共三行
#define ZWEmotionMaxCols 7
#define ZWEmotionMaxRows 3

//每页的个数
#define ZWEmotionPageSize ((ZWEmotionMaxCols*ZWEmotionMaxRows)-1)

@interface ZWEmotionPageView : UIView

@property(nonatomic,strong)NSArray *emotions;//表情模型

@end
