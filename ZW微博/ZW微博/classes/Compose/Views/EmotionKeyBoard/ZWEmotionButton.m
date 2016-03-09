//
//  ZWEmotionButton.m
//  ZW微博
//
//  Created by rayootech on 16/2/10.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWEmotionButton.h"
#import "ZWEmotion.h"

@implementation ZWEmotionButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setUp];
    }
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{

    if (self=[super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}


-(void)setUp
{
  self.titleLabel.font=[UIFont systemFontOfSize:32.0];
  //图片高亮时不去调整图片
  self.adjustsImageWhenHighlighted=NO;
}

-(void)setEmotion:(ZWEmotion *)emotion
{
 
    _emotion=emotion;
    
    [self setTitle:nil forState:UIControlStateNormal];
    [self setImage:nil forState:UIControlStateNormal];
    
    //设置背景图片
    if (emotion.png) {//有图片
       
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
        return;
    }
    else if (emotion.code)//有系统表情
    {
       
        //将emotion.code :十六进制转换为Emoji字符
        NSString *emoji=[emotion.code emoji];
        
        [self setTitle:emoji forState:UIControlStateNormal];
        
        self.titleLabel.font=[UIFont systemFontOfSize:32];
    }
    
    
}

@end
