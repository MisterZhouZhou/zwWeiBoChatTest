//
//  ZWEmotionKeyboard.m
//  ZW微博
//
//  Created by rayootech on 16/2/9.
//  Copyright © 2016年 rayootech. All rights reserved.
//   键盘整体（ZWEmotionListView+）

#import "ZWEmotionKeyboard.h"
#import "ZWEmotionListView.h"
#import "ZWEmotionToolBar.h"
#import "ZWEmotion.h"
#import "ZWComposeTool.h"

@interface ZWEmotionKeyboard ()<ZWEmotionToolBarDelegate>
//tabBar
@property(nonatomic,strong)ZWEmotionToolBar *tabBar;

//表情内容
@property(nonatomic,strong)ZWEmotionListView *recentlistView;
@property(nonatomic,strong)ZWEmotionListView *defaultlistView;
@property(nonatomic,strong)ZWEmotionListView *emojilistView;
@property(nonatomic,strong)ZWEmotionListView *lxhlistView;

//当前显示的内容
@property(nonatomic,weak)ZWEmotionListView *showingListView;

@end

@implementation ZWEmotionKeyboard

#pragma mark-懒加载
-(ZWEmotionListView *)recentlistView
{
    if (!_recentlistView) {
        self.recentlistView=[[ZWEmotionListView alloc]init];
        self.recentlistView.emotions=[ZWComposeTool getRecentEmotion];
    }
    return _recentlistView;
}

-(ZWEmotionListView *)defaultlistView
{
    if (!_defaultlistView) {
        self.defaultlistView=[[ZWEmotionListView alloc]init];
        
        NSString *defpath=[[NSBundle mainBundle]pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        NSArray *defEmotions=[ZWEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:defpath]];
        self.defaultlistView.emotions=defEmotions;
    }
    return _defaultlistView;
}


-(ZWEmotionListView *)emojilistView
{
    if (!_emojilistView) {
        self.emojilistView=[[ZWEmotionListView alloc]init];
        
        NSString *emojipath=[[NSBundle mainBundle]pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        NSArray *emojiEmotions=[ZWEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:emojipath]];
        self.emojilistView.emotions=emojiEmotions;
    }
    return _emojilistView;
}

-(ZWEmotionListView *)lxhlistView
{
    if (!_lxhlistView) {
        self.lxhlistView=[[ZWEmotionListView alloc]init];
        
        NSString *lxhpath=[[NSBundle mainBundle]pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        NSArray *lxhEmotions=[ZWEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:lxhpath]];
        self.lxhlistView.emotions=lxhEmotions;
    }
    return _lxhlistView;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame: frame]) {
        
        //tabBar
        ZWEmotionToolBar *tabBar=[[ZWEmotionToolBar alloc]init];
        tabBar.delegate=self;
        [self addSubview:tabBar];
        self.tabBar=tabBar;
        
        //表情选中的通知
        [ZWNotificationCenter addObserver:self selector:@selector(emotionDidSelect) name:ZWEmotionDidSelectNotification object:nil];
        
    }
    
    return self;
}

#pragma mark-表情选中
-(void)emotionDidSelect
{
    self.recentlistView .emotions=[ZWComposeTool getRecentEmotion];
}


-(void)dealloc{
    [ZWNotificationCenter removeObserver:self];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //tabBar
    self.tabBar.width=self.width;
    self.tabBar.height=37;
    self.tabBar.x=0;
    self.tabBar.y=self.height-self.tabBar.height;
    
    
    //表情内容
    self.showingListView.x=self.showingListView.y=0;
    self.showingListView.width=self.width;
    self.showingListView.height=self.tabBar.y;
    
}

#pragma mark-工具条代理方法
-(void)emotionTabBar:(ZWEmotionToolBar *)tabBar didSelectButton:(ZWEmotionTBarButtonType)buttonType
{

    //移除contentView之前显示的控件
    [self.showingListView removeFromSuperview];
    
    //根据按钮类型，切换contentView上面的listView
    switch (buttonType) {
        case ZWEmotionTBarButtonTypeRecent://最近
            ZWLog(@"最近");
//            //从沙盒中取数据
//            self.recentlistView.emotions=[ZWComposeTool getRecentEmotion];
            [self addSubview:self.recentlistView];
           
            break;
        case ZWEmotionTBarButtonTypeDefault://默认
        {
            ZWLog(@"默认");
           [self addSubview:self.defaultlistView];
          
        }
            break;
        case ZWEmotionTBarButtonTypeEmoji://表情
        {
            ZWLog(@"表情");
           [self addSubview:self.emojilistView];
          
        }
            break;
        case ZWEmotionTBarButtonTypeLXH://浪小花
        {
            ZWLog(@"浪小花");
            [self addSubview:self.lxhlistView];
             
        }
           break;
            
        default:
            break;
    }
    
    //设置正在显示的listView
    self.showingListView=[self.subviews lastObject];
    
    //设置frame
    [self setNeedsLayout];

}

@end
