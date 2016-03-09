//
//  ZWStatus.h
//  ZW微博
//
//  Created by rayootech on 16/1/3.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZWUser.h"
#import "MJExtension.h"

@interface ZWStatus : NSObject<MJKeyValue>

@property(nonatomic,copy)NSString *created_at;//微博创建时间

@property(nonatomic,copy)NSString *idstr;//字符串型的微博ID

@property(nonatomic,copy)NSString *text; //微博信息内容

@property(nonatomic,copy)NSString *source; //	微博来源

@property(nonatomic,strong)ZWUser *user; //	微博作者的用户信息字段 详细

@property(nonatomic,strong)ZWStatus *retweeted_status;//被转发的原微博信息字段，当该微博为转发微博时返回 详细

@property(nonatomic,assign)int reposts_count; //转发数

@property(nonatomic,assign)int comments_count; //评论数

@property(nonatomic,assign)int attitudes_count; //表态数

@property(nonatomic,strong)NSArray* pic_urls;//配图数据

/**
 *  转发微博name
 */
@property(nonatomic,copy)NSString *retweetName;//转发微博的name

@end
