//
//  ZWAccountTool.m
//  ZW微博
//
//  Created by rayootech on 15/11/2.
//  Copyright © 2015年 rayootech. All rights reserved.
//

#import "ZWAccountTool.h"
#import "ZWHttpTool.h"
#import "MJExtension.h"
#import "ZWAccountParam.h"
// 账号的存储路径
#define ZWAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation ZWAccountTool
/**
 *  存储账号信息
 *@param account 账号模型
 */
+(void)saveAccount:(ZWAccount *)account{

    // 自定义对象的存储必须用NSKeyedArchiver，不再有什么writeToFile方法
    [NSKeyedArchiver archiveRootObject:account toFile:ZWAccountPath];
}

/**
 *  返回账号信息
 *返回账号模型（如果账号过期，返回nil）
 */
+(ZWAccount*)account{
   //加载模型
    ZWAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:ZWAccountPath];
    
    //验证账号是否过期
    //过期的秒数
    long long expires_in =[account.expires_in longLongValue];
    //获得过期的时间
     NSDate *expiresTime = [account.create_time dateByAddingTimeInterval:expires_in];
    
    //获得当前时间
    NSDate *now=[NSDate date];
    
    NSComparisonResult result=[expiresTime compare:now];
    if (result!=NSOrderedDescending) {//过期
        return nil;
    }
    return account;
}

+(void)accountWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure
{
    //创建请求管理者
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    
//    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    ZWAccountParam *params=[[ZWAccountParam alloc]init];
    params.client_id=ZWClient_id;
    params.client_secret=ZWClient_secret;
    params.grant_type=@"authorization_code";
    params.code=code;
    params.redirect_uri=ZWRedirect_uri;
    
    //发送请求
    [ZWHttpTool POST:@"https://api.weibo.com/oauth2/access_token" parameters:params.keyValues success:^(id responseObject) {
        //请求成功
        //字典转化
        ZWAccount *account=[ZWAccount accountWithDict:responseObject];
        //保存账号信息
        [ZWAccountTool saveAccount:account];
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];

}
@end
