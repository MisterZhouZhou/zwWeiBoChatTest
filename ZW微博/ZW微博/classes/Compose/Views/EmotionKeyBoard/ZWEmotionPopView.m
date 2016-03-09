//
//  HWEmotionPopView.m
//  黑马微博2期
//
//  Created by apple on 14-10-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "ZWEmotionPopView.h"
#import "ZWEmotion.h"
#import "ZWEmotionButton.h"

@interface ZWEmotionPopView()
@property (weak, nonatomic) IBOutlet ZWEmotionButton *emotionButton;
@end

@implementation ZWEmotionPopView

+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZWEmotionPopView" owner:nil options:nil] lastObject];
}

//- (void)setEmotion:(ZWEmotion *)emotion
//{
//    _emotion = emotion;
//    
//    self.emotionButton.emotion = emotion;
//}


-(void)showFrom:(ZWEmotionButton *)btn
{    
    
    self.emotionButton.emotion=btn.emotion;
    
    //取得UIScreen最上面的window
    UIWindow *window=[[UIApplication sharedApplication].windows lastObject];
    
    [window  addSubview:self];
    
    //计算被点击按钮的frame
    CGRect btnFrame=[btn convertRect:btn.bounds toView:nil];
    self.y=CGRectGetMidY(btnFrame)-self.height;
    self.centerX=CGRectGetMidX(btnFrame);
}
@end
