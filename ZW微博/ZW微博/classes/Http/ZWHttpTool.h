//
//  ZWHttpTool.h
//  ZW微博
//
//  Created by rayootech on 16/1/3.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWHttpTool : NSObject


//get 请求
/**
 *  //不需要返回,有延迟，并不会马上返回
 *
 */
+(void)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(id responseObject))success
                        failure:(void (^)(NSError *error))failure;

+(void)POST:(NSString *)URLString
parameters:(id)parameters
   success:(void (^)(id responseObject))success
   failure:(void (^)(NSError *error))failure;
@end
