//
//  ZWUserTool.m
//  ZW微博
//
//  Created by rayootech on 16/1/10.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWUserTool.h"
#import "ZWHttpTool.h"
#import "ZWUserParam.h"
#import "ZWUserResult.h"
#import "ZWAccountTool.h"
#import "MJExtension.h"
#import "ZWUser.h"
@implementation ZWUserTool

+(void)unreadWithSuccess:(void(^)(ZWUserResult *result))success failure:(void(^)(NSError *error))failure
{
 
    //创建参数模型
    ZWUserParam *params=[ZWUserParam param];
    params.uid=[ZWAccountTool account].uid;
    
    [ZWHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params.keyValues success:^(id responseObject) {
        
        ZWUserResult *result=[ZWUserResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


+(void)userInfoWithSuccess:(void(^)(ZWUser *result))success failure:(void(^)(NSError *error))failure
{
    //创建参数模型
    ZWUserParam *params=[ZWUserParam param];
    params.uid=[ZWAccountTool account].uid;
    
    [ZWHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:params.keyValues success:^(id responseObject) {
        
        ZWUser *result=[ZWUser objectWithKeyValues:responseObject];
        
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
