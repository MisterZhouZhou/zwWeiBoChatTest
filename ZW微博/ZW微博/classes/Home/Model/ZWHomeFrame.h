//
//  ZWHomeFrame.h
//  ZW微博
//
//  Created by rayootech on 16/1/31.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZWStatus;
@interface ZWHomeFrame : NSObject

@property(nonatomic,strong)ZWStatus *status;

/**
 *原创微博
 */
@property(nonatomic,assign)CGRect originalViewFrame;
//头像
@property(nonatomic,assign) CGRect iconViewFrame;
//昵称
@property(nonatomic,assign) CGRect nameLabelFrame;
//vip
@property(nonatomic,assign) CGRect vipLabelFrame;
//时间
@property(nonatomic,assign) CGRect timeLabelFrame;
//来源
@property(nonatomic,assign) CGRect souceLabelFrame;
//正文
@property(nonatomic,assign) CGRect contentLabelFrame;

//配图
@property(nonatomic,assign) CGRect originPhotoViewFrame;


/**
 *转发微博
 */
@property(nonatomic,assign)CGRect retweetViewFrame;
//昵称
@property(nonatomic,assign) CGRect retnameLabelFrame;
//正文
@property(nonatomic,assign) CGRect retcontentLabelFrame;
//工具条
@property(nonatomic,assign)CGRect statusToolBarViewFrame;
//配图
@property(nonatomic,assign) CGRect retweetPhotoViewFrame;

//cell的高
@property(nonatomic,assign)CGFloat cellHight;

@end


