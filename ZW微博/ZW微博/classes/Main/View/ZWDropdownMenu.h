//
//  ZWDropdownMenu.h
//  ZW微博
//
//  Created by rayootech on 15/11/2.
//  Copyright © 2015年 rayootech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZWDropdownMenu;

@protocol ZWDropdownMenuDelegate <NSObject>
@optional
- (void)dropdownMenuDidDismiss:(ZWDropdownMenu *)menu;
- (void)dropdownMenuDidShow:(ZWDropdownMenu *)menu;
@end

@interface ZWDropdownMenu : UIView

@property (nonatomic, weak) id<ZWDropdownMenuDelegate> delegate;

/**
 *  内容
 */
@property (nonatomic, strong) UIView *content;
/**
 *  内容控制器
 */
@property (nonatomic, strong) UIViewController *contentController;

+ (instancetype)menu;

/**
 *  显示
 */
- (void)showFrom:(UIView *)from;
/**
 *  销毁
 */
- (void)dismiss;


@end
