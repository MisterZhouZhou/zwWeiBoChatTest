//
//  ZWStatusResult.h
//  ZW微博
//
//  Created by rayootech on 16/1/10.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"
@interface ZWStatusResult : NSObject<MJKeyValue>
/**
 *  用户的微博数组
 */
@property(nonatomic,strong)NSArray *statuses;

//用户最新微博总数
@property(nonatomic,assign)int total_number;
@end
