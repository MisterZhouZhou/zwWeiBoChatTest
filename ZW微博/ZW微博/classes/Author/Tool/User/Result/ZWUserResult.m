//
//  ZWUserResult.m
//  ZW微博
//
//  Created by rayootech on 16/1/10.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWUserResult.h"

@implementation ZWUserResult

-(int)messageCount
{

    return _cmt+_dm+_mention_cmt+_mention_status;
}

-(int)totalCount
{
    return self.messageCount+_status+_follower;
}

@end
