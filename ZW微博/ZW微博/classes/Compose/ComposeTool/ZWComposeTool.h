//
//  ZWComposeTool.h
//  ZW微博
//
//  Created by rayootech on 16/2/11.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZWEmotion.h"
@interface ZWComposeTool : NSObject

/**
 *  存储最近使用过的表情
 *
 */
+(void)saveRecentEmotion:(ZWEmotion*)emotion;

/**
 *  得到最近使用过的表情
 *
 *  @return 表情数组
 */
+(NSArray *)getRecentEmotion;

@end
