//
//  ZWAccountParam.h
//  ZW微博
//
//  Created by rayootech on 16/1/10.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWAccountParam : NSObject

@property(nonatomic,copy)NSString *client_id;

@property(nonatomic,copy)NSString *client_secret;

@property(nonatomic,copy)NSString *grant_type;

@property(nonatomic,copy)NSString *code;

@property(nonatomic,copy)NSString *redirect_uri;

@end
