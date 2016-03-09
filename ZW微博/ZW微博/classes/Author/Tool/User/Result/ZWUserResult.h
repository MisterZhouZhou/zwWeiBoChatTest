//
//  ZWUserResult.h
//  ZW微博
//
//  Created by rayootech on 16/1/10.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWUserResult : NSObject

//status 	int 	新微博未读数
//follower 	int 	新粉丝数
//cmt 	int 	新评论数
//dm 	int 	新私信数
//mention_status 	int 	新提及我的微博数
//mention_cmt 	int 	新提及我的评论数

@property(nonatomic,assign)int status; //新微博未读数
@property(nonatomic,assign)int follower; //新粉丝数
@property(nonatomic,assign)int cmt;  //新评论数
@property(nonatomic,assign)int dm;  //新私信数
@property(nonatomic,assign)int mention_status; //新提及我的微博数
@property(nonatomic,assign)int mention_cmt; //新提及我的评论数
/**
 *  消息总数
 *
 */
-(int)messageCount;

/**
 *  未读消息的总和，为应用程序设置未读数
 */
-(int)totalCount;

@end
