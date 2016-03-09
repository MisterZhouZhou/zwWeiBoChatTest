//
//  ZWStatusTool.h
//  ZW微博
//
//  Created by rayootech on 16/1/10.
//  Copyright © 2016年 rayootech. All rights reserved.
//
//处理微博数据

#import <Foundation/Foundation.h>

@interface ZWStatusTool : NSObject

/**
 *  请求更新的微博数据
 */

+(void)newStatusWithSinceId:(NSString *)sinceId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure;

+(void)newStatusWithMaxId:(NSString *)maxId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure;

@end
