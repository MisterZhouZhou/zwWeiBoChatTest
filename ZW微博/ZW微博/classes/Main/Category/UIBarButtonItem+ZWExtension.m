//
//  UIBarButtonItem+ZWExtension.m
//  ZW微博
//
//  Created by rayootech on 15/11/1.
//  Copyright © 2015年 rayootech. All rights reserved.
//

#import "UIBarButtonItem+ZWExtension.h"

@implementation UIBarButtonItem (ZWExtension)

/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的那个方法
 *  @param image     图片
 *  @param highImage 高亮图片
 *
 *  @return <#return value description#>
 */
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage{
   
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    //设置尺寸
    btn.size=btn.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
@end
