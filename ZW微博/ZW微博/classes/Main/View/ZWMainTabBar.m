//
//  ZWMainTabBar.m
//  ZW微博
//
//  Created by rayootech on 15/11/1.
//  Copyright © 2015年 rayootech. All rights reserved.
//

#import "ZWMainTabBar.h"
@interface ZWMainTabBar()
@property(nonatomic,weak)UIButton *plusButton;

@end
@implementation ZWMainTabBar

-(UIButton *)plusButton{
    if (_plusButton==nil) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        //默认按钮的尺寸和图片一样大
        [btn sizeToFit];
        
        //监听按钮的点击事件
        [btn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        
        
        _plusButton=btn;
        
        [self addSubview:_plusButton];
    }
    return _plusButton;
    
}

-(void)layoutSubviews{

    [super layoutSubviews];
    CGFloat w=self.bounds.size.width;
    CGFloat h=self.bounds.size.height;
    
    CGFloat btnX=0;
    CGFloat btnY=0;
    CGFloat btnW=w/(self.items.count+1);
    CGFloat btnH=h;
    
    //调整系统tabbar上面按钮的位置
    int i=0;
    for (UIView *tabBarButton in self.subviews) {
        //判断下是否是UITabBarButton
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            if (i==2) {
                i=3;
            }
            btnX=i*btnW;
            tabBarButton.frame=CGRectMake(btnX, btnY, btnW, btnH);
            i++;
            }
    }
    //设置添加按钮的位置
    self.plusButton.center=CGPointMake(w*0.5, h*0.5);
   
}

#pragma mark-点击加号事件
-(void)plusClick
{
   //model事件
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
     }
}

@end
