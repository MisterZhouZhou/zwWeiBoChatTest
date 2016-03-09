//
//  ZWBaseParam.h
//  ZW微博
//
//  Created by rayootech on 16/1/10.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWBaseParam : NSObject

/**
 *  采用OAuth授权方式为必填参数，访问命令牌
 */
@property(nonatomic,copy)NSString *access_token;

+(instancetype)param;

@end
