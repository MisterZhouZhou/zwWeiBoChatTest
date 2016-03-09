//
//  ZWStatusParam.h
//  ZW微博
//
//  Created by rayootech on 16/1/10.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 since_id 比since_id时间晚的微博数据
 max_id 返回较早的微博数据
 */

@interface ZWStatusParam : NSObject

@property(nonatomic,copy)NSString *access_token;

@property(nonatomic,copy)NSString *since_id;

@property(nonatomic,copy)NSString *max_id;

@end
