//
//  ZWEmotionTBarButton.m
//  ZW微博
//
//  Created by rayootech on 16/2/9.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWEmotionTBarButton.h"

@implementation ZWEmotionTBarButton
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        
        //设置字体
        self.titleLabel.font=[UIFont systemFontOfSize:13.0];
    }
    return self;
}



@end
