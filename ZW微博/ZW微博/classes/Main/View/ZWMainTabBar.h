//
//  ZWMainTabBar.h
//  ZW微博
//
//  Created by rayootech on 15/11/1.
//  Copyright © 2015年 rayootech. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  ZWMainTabBar;
@protocol ZWMainTabBarDelegate <NSObject>

/**
 *  点击加号事件代理方法
 *
 *  @param tabBar ZWMainTabBar
 */
-(void)tabBarDidClickPlusButton:(ZWMainTabBar *)tabBar;

@end

@interface ZWMainTabBar : UITabBar

@property(nonatomic,weak)id <ZWMainTabBarDelegate>delegate;

@end
