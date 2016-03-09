//
//  ZWUserTool.h
//  ZW微博
//
//  Created by rayootech on 16/1/10.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZWUserResult;
@class ZWUser;
@interface ZWUserTool : NSObject


/**
 *  请求用户未读数
 *
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */
+(void)unreadWithSuccess:(void(^)(ZWUserResult *result))success failure:(void(^)(NSError *error))failure;

/**
 *  请求用户信息
 *
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */
+(void)userInfoWithSuccess:(void(^)(ZWUser *result))success failure:(void(^)(NSError *error))failure;

@end
