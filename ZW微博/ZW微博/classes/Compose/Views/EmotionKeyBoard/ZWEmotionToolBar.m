//
//  ZWEmotionToolBar.m
//  ZW微博
//
//  Created by rayootech on 16/2/9.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWEmotionToolBar.h"
#import "ZWEmotionTBarButton.h"
@interface ZWEmotionToolBar ()

@property(nonatomic,weak)ZWEmotionTBarButton  *selectBtn;
@end

@implementation ZWEmotionToolBar

-(instancetype)initWithFrame:(CGRect)frame
{

    if (self=[super initWithFrame:frame]) {
        [self setUpBtn:@"最近" buttonType:ZWEmotionTBarButtonTypeRecent];
        [self setUpBtn:@"默认" buttonType:ZWEmotionTBarButtonTypeDefault];
        [self setUpBtn:@"Emoji" buttonType:ZWEmotionTBarButtonTypeEmoji];
        [self setUpBtn:@"浪小花" buttonType:ZWEmotionTBarButtonTypeLXH];
    }
    return self;
}

#pragma mark-  创建一个按钮
-(void)setUpBtn:(NSString *)title buttonType:(ZWEmotionTBarButtonType)buttonType
{
    ZWEmotionTBarButton *btn=[[ZWEmotionTBarButton alloc]init];
    
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag=buttonType;
    
    //设置背景图片
    NSString *image=nil;
    NSString *selectimage=nil;
    if (self.subviews.count==1) {
        image=@"compose_emotion_table_left_normal";
        selectimage=@"compose_emotion_table_left_selected";
        
    }
    else if (self.subviews.count==4)
    {
        image=@"compose_emotion_table_right_normal";
        selectimage=@"compose_emotion_table_right_selected";

    }
    else{
        image=@"compose_emotion_table_mid_normal";
        selectimage=@"compose_emotion_table_mid_selected";

    }

    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectimage] forState:UIControlStateDisabled];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    
}

-(void)setDelegate:(id<ZWEmotionToolBarDelegate>)delegate
{
    _delegate=delegate;
    
    [self btnClick:[self viewWithTag:ZWEmotionTBarButtonTypeDefault]];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置按钮的frame
    NSUInteger btnCount=self.subviews.count;
    
    CGFloat btnW=self.width/btnCount;
    
    CGFloat btnH=self.height;
    for (int i=0; i<btnCount; i++) {
        UIButton *btn=self.subviews[i];
        btn.y=0;
        btn.width=btnW;
        btn.x=i*btnW;
        btn.height=btnH;
    }
}


#pragma mark-按钮点击事件
-(void)btnClick:(ZWEmotionTBarButton *)btn
{
    self.selectBtn.enabled=YES;
    btn.enabled=NO;
    self.selectBtn=btn;
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:btn.tag];
    }
}
@end