//
//  ZWStatusResult.m
//  ZW微博
//
//  Created by rayootech on 16/1/10.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWStatusResult.h"
#import "ZWStatus.h"
@implementation ZWStatusResult

//实现这个方法，就会自动吧数组中的字典转化成对应的模型
- (NSDictionary *)objectClassInArray
{
    return @{@"statuses":[ZWStatus class]};
}

@end
