//
//  ZWAccountTool.h
//  ZW微博
//
//  Created by rayootech on 15/11/2.
//  Copyright © 2015年 rayootech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZWAccount.h"

@interface ZWAccountTool : NSObject

/**
 *  存储账号信息
 *@param account 账号模型
 */
+(void)saveAccount:(ZWAccount *)account;

/**
 *  返回账号信息
 *返回账号模型（如果账号过期，返回nil）
 */
+(ZWAccount*)account;

+(void)accountWithCode:(NSString *)code success:(void(^)())success failure:(void(^)(NSError *error))failure;
@end
