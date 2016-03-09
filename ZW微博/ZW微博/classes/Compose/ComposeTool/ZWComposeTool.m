//
//  ZWComposeTool.m
//  ZW微博
//
//  Created by rayootech on 16/2/11.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWComposeTool.h"
// 表情的存储路径
#define ZWRecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archive"]
@implementation ZWComposeTool

static NSMutableArray *_recentEmotions;

+(void)initialize
{
    _recentEmotions= [NSKeyedUnarchiver unarchiveObjectWithFile:ZWRecentEmotionsPath];
    if (_recentEmotions==nil) {
        _recentEmotions=[NSMutableArray array];
    }
}

/**
 *  存储最近使用过的表情
 *
 */
+(void)saveRecentEmotion:(ZWEmotion*)emotion
{
    //删除重复的数据
    [_recentEmotions removeObject:emotion];
    
    //将最新的表情插入到最前
    [_recentEmotions insertObject:emotion atIndex:0];
    
    //将所有的表情存入到沙盒
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:ZWRecentEmotionsPath];
    
}

/**
 *  得到最近使用过的表情
 *
 *  @return 表情数组
 */
+(NSArray *)getRecentEmotion
{
    return _recentEmotions;
}

@end
