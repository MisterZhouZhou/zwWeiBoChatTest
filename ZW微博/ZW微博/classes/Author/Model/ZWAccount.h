//
//  ZWAccount.h
//  ZW微博
//
//  Created by rayootech on 15/11/2.
//  Copyright © 2015年 rayootech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWAccount : NSObject<NSCoding>

//用于调用access_token,接口获取授权后的access_token
@property(nonatomic,copy)NSString *access_token;

//access_token的生命周期，单位是秒
@property(nonatomic,copy)NSNumber *expires_in;

//当前授权用户的UDID
@property(nonatomic,copy)NSString *uid;

//access_token的创建时间
@property(nonatomic,strong)NSDate *create_time;

//用户昵称
@property(nonatomic,copy)NSString *name;

+(instancetype)accountWithDict:(NSDictionary *)dict;
@end
