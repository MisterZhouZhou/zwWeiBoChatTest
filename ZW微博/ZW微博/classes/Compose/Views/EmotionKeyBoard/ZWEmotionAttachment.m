//
//  ZWEmotionAttachment.m
//  ZW微博
//
//  Created by rayootech on 16/2/10.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWEmotionAttachment.h"
#import "ZWEmotion.h"
@implementation ZWEmotionAttachment

-(void)setEmotion:(ZWEmotion *)emotion
{
    _emotion=emotion;
    self.image=[UIImage imageNamed:emotion.png];
}

@end
