//
//  ZWUser.h
//  ZW微博
//
//  Created by rayootech on 16/1/3.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  NS_ENUM(NSInteger,ZWUserVerified_type)
{
    ZWUserVerifiedTypeNone=-1,//没有任何认证
    
    ZWUserVerifiedPersonal=0,//个人认证

    ZWUserVerifiedOrgEnterprice=2,//企业官方：CSDN，EOE，搜狐新闻客户端
    
    ZWUserVerifiedOrgEMedia=3,//媒体官方：程序员杂志，苹果汇
    
    ZWUserVerifiedOrgWebsite=5,//网站官方：猫扑
    
    ZWUserVerifiedDaren=220  //微博达人
};

@interface ZWUser : NSObject

@property(nonatomic,copy)NSString *name;//微博昵称

@property(nonatomic,copy)NSURL *profile_image_url;//微博头像

@property(nonatomic,assign)int mbtype;//会员等级 会员类型>2代表会员

@property(nonatomic,assign)int mbrank;//会员等级

@property(nonatomic,assign,getter=isVip)BOOL vip;//是否是vip

@property(nonatomic,assign)ZWUserVerified_type verified_type;//认证类型

@end
