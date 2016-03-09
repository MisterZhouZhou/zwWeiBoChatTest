//
//  ZWStatus.m
//  ZW微博
//
//  Created by rayootech on 16/1/3.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWStatus.h"
#import "ZWPhoto.h"
#import "NSDate+ZWDate.h"
@implementation ZWStatus

//实现这个方法，就会自动吧数组中的字典转化成对应的模型
- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[ZWPhoto class]};
}

-(NSString *)created_at
{
    NSDateFormatter *fmt=[[NSDateFormatter alloc]init];
    fmt.dateFormat=@"EEE MMM d HH:mm:ss Z yyyy";
    NSDate *created_at=[fmt dateFromString:_created_at];
    
    if ([created_at isThisYear]) {//是今年
        
        if ([created_at isToday]) {//今天
          //计算跟当前时间的差距
           NSDateComponents *cmps= [created_at deltaWithNow];
            if (cmps.hour>=1) {
                return [NSString stringWithFormat:@"%ld小时之前",cmps.hour];
            }
            else if (cmps.minute>1)
            {
                return [NSString stringWithFormat:@"%ld分钟之前",cmps.minute];
            }else
            {
                return [NSString stringWithFormat:@"刚刚"];
            }

        }else if ([created_at isYesterday])//昨天
        {
           fmt.dateFormat=@"昨天 HH:mm";
           return [fmt stringFromDate:created_at];
            
        }else{//前天
            
            fmt.dateFormat=@"MM-dd HH:mm";
            return [fmt stringFromDate:created_at];

        }
        
    }else //不是今年
    {
       fmt.dateFormat=@"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:created_at];
    }
    
    return _created_at;
}


-(void)setSource:(NSString *)source
{
    if (source.length) {
        NSRange range=[source rangeOfString:@">"];
        source=[source substringFromIndex:range.location+range.length];
        range=[source rangeOfString:@"<"];
        source=[source substringToIndex:range.location];
        source=[NSString stringWithFormat:@"来自%@",source];
    }
   
    _source=source;
}

-(void)setRetweeted_status:(ZWStatus *)retweeted_status
{

    _retweeted_status=retweeted_status;
    
    _retweetName=[NSString stringWithFormat:@"@%@",retweeted_status.user.name];
    
}
@end
