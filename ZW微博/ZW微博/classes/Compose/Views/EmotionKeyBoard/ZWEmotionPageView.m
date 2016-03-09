//
//  ZWEmotionPageView.m
//  ZW微博
//
//  Created by rayootech on 16/2/10.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWEmotionPageView.h"
#import "ZWEmotion.h"
//#import "ZWEmotionPopView.h"
#import "ZWEmotionPopView.h"
#import "ZWEmotionButton.h"
#import "ZWComposeTool.h"
@interface ZWEmotionPageView ()
//点击表情后放大镜
@property(nonatomic,strong)ZWEmotionPopView *popview;

/**
 *  删除按钮
 */
@property(nonatomic,weak)UIButton *deleteButton;

@end

@implementation ZWEmotionPageView

#pragma mark-懒加载
-(ZWEmotionPopView *)popview
{
    if (!_popview) {
        
        _popview=[ZWEmotionPopView popView];
        
    }
    return _popview;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
     
     //添加删除按钮
        UIButton *deleteButton=[[UIButton alloc]init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        //添加事件
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:deleteButton];
        
        self.deleteButton=deleteButton;

        
        //添加长按
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressPageView:)]];
        
    }
    
    return self;
}

#pragma mark-查找点击位置对应的按钮
-(ZWEmotionButton*)emotionButtonWithLocation:(CGPoint )location
{
    NSUInteger count=self.emotions.count;
    for ( int i=0; i<count; i++) {
        ZWEmotionButton *btn=self.subviews[i+1];//此处为i+1,为表情按钮的范围
        if (CGRectContainsPoint(btn.frame, location)) {
            
            return  btn;
        }
    }
    return nil;
}

#pragma mark-长按手势
-(void)longPressPageView:(UILongPressGestureRecognizer *)recognizer
{
    CGPoint location=[recognizer locationInView:recognizer.view];
    
    ZWEmotionButton *btn=[self emotionButtonWithLocation:location];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            //手指已经不再触摸pageview
            [self.popview removeFromSuperview];
            
            //如果手指还在表情按钮上
            if (btn) {
                
                //存数据,发通知
                [self selectEmotion:btn.emotion];
                
            }
            break;
        }
        case UIGestureRecognizerStateBegan://手指开始
        case UIGestureRecognizerStateChanged://手势改变
        {
            //找到表情按钮
            [self.popview showFrom:btn];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark-Delete按钮事件
-(void)deleteClick
{
    //发通知
    [ZWNotificationCenter postNotificationName:ZWEmotionDidDeleteNotification object:nil userInfo:nil];
    
}


-(void)setEmotions:(NSArray *)emotions
{
    _emotions=emotions;
    
    NSUInteger count=emotions.count;
    for (int i=0; i<count; i++) {
        ZWEmotion *emotionModel=emotions[i];
        ZWEmotionButton *btn=[[ZWEmotionButton alloc]init];
        btn.emotion=emotionModel;
        //按钮监听事件
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
    }
}

-(void)layoutSubviews{

    [super layoutSubviews];
    
    //内边距
    CGFloat inset=10;
    NSUInteger count=self.emotions.count;
    CGFloat btnW=(self.width-2*inset)/ZWEmotionMaxCols;
    CGFloat btnH=(self.height-inset)/ZWEmotionMaxRows;
    for (int i=0; i<count; i++) {
        UIButton *btn=self.subviews[i+1];
        btn.width=btnW;
        btn.height=btnH;
        btn.x=inset+(i%ZWEmotionMaxCols)*btnW;
        btn.y=inset+(i/ZWEmotionMaxCols)*btnH;
        
    }
    //删除按钮
    self.deleteButton.width=btnW;
    self.deleteButton.height=btnH;
    self.deleteButton.x=self.width-inset-btnW;
    self.deleteButton.y=self.height-btnH;

}

#pragma mark-btnClick 事件
-(void)btnClick:(ZWEmotionButton *)btn
{
    //显示放大镜
    [self.popview showFrom:btn];

    //移除popView
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popview removeFromSuperview];
    });

    //存数据,发通知
    [self selectEmotion:btn.emotion];
}


#pragma mark-选中某个表情，发通知，存储表情到沙盒
-(void)selectEmotion:(ZWEmotion *)emotion
{
    //存储表情到沙盒
    [ZWComposeTool saveRecentEmotion:emotion];
    
    //发通知
    NSMutableDictionary *userInfo=[NSMutableDictionary dictionary];
    userInfo[ZWSelectedEmotionKey]=emotion;
    [ZWNotificationCenter postNotificationName:ZWEmotionDidSelectNotification object:nil userInfo:userInfo];
}
@end
