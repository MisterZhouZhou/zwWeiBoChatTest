//
//  ZWStatusTool.m
//  ZW微博
//
//  Created by rayootech on 16/1/10.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWStatusTool.h"
#import "ZWHttpTool.h"
#import "ZWAccountTool.h"
#import "ZWStatus.h"
#import "ZWStatusParam.h"
#import "ZWStatusResult.h"
@implementation ZWStatusTool


+(void)newStatusWithSinceId:(NSString *)sinceId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure
{

    ZWStatusParam *params=[[ZWStatusParam alloc]init];
//    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    if (sinceId) {
        params.since_id=sinceId;
    }
    params.access_token=[ZWAccountTool account].access_token;
    
    [ZWHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params.keyValues success:^(id responseObject) {
        
        //请求成功
//        NSArray *dicArr=responseObject[@"statuses"];
//        NSArray *array=(NSMutableArray *)[ZWStatus objectArrayWithKeyValuesArray:dicArr];
       
        ZWStatusResult *result=[ZWStatusResult objectWithKeyValues:responseObject];
        if (success) {
            success(result.statuses);
        }
   
    } failure:^(NSError *error) {
        
        //请求失败
        if (failure) {
            failure(error);
        }
        
    }];
    

}

+(void)newStatusWithMaxId:(NSString *)maxId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure
{
//    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    
    ZWStatusParam *params=[[ZWStatusParam alloc]init];
    
    if (maxId) {//有微博数据，才需要刷新最新的数据

        params.max_id=[NSString stringWithFormat:@"%@",maxId];
    }
    params.access_token=[ZWAccountTool account].access_token;
    
    [ZWHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params.keyValues success:^(id responseObject) {
        
        //请求成功
//        NSArray *dicArr=responseObject[@"statuses"];
//        NSArray *array=(NSMutableArray *)[ZWStatus objectArrayWithKeyValuesArray:dicArr];
        ZWStatusResult *result=[ZWStatusResult objectWithKeyValues:responseObject];
        if (success) {
            success(result.statuses);
        }
        
    } failure:^(NSError *error) {
        //请求失败
//        NSLog(@"%@",error);
        if (failure) {
            failure(error);
        }
    }];
}

@end
