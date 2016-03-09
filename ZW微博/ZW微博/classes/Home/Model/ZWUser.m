//
//  ZWUser.m
//  ZW微博
//
//  Created by rayootech on 16/1/3.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWUser.h"

@implementation ZWUser

-(void)setMbtype:(int)mbtype
{
    _mbtype=mbtype;
    _vip=mbtype > 2;
}

@end
