//
//  ZWBaseParam.m
//  ZW微博
//
//  Created by rayootech on 16/1/10.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWBaseParam.h"
#import "ZWAccountTool.h"

@implementation ZWBaseParam

+(instancetype)param
{
    ZWBaseParam *param=[[self alloc]init];
    
    param.access_token=[ZWAccountTool account].access_token;
    
    return param;
}

@end
