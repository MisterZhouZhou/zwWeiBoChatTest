//
//  ZWUserParam.h
//  ZW微博
//
//  Created by rayootech on 16/1/10.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZWBaseParam.h"
@interface ZWUserParam : ZWBaseParam

//source 	false 	string 	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
//access_token 	false 	string 	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
//uid 	true 	int64 	需要获取消息未读数的用户UID，必须是当前登录用户。
//callback 	false 	string 	JSONP回调函数，用于前端调用返回JS格式的信息。
//unread_message 	false 	boolean 	未读数版本。0：原版未读数，1：新版未读数。默认为0。

@property(nonatomic,copy)NSString *uid;

@end
