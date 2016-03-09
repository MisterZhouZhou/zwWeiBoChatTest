//
//  ZWComposToolBar.h
//  ZW微博
//
//  Created by rayootech on 16/2/8.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,ZWToolBarType)
{
    ZWToolBarTakePhoto=0,
    ZWToolBarGetPicture,
    ZWToolBarAtSomeBody,
    ZWToolBarShareSomething,
    ZWToolBarSmile
};
@class ZWComposToolBar;
@protocol ZWComposToolBarDelegate <NSObject>

@optional
-(void)composeToolBar:(ZWComposToolBar *)toolbar didClickButton:(ZWToolBarType)buttonType;

@end

@interface ZWComposToolBar : UIView

@property(nonatomic,weak)id<ZWComposToolBarDelegate> delegate;


/**
 * 显示键盘图标还是显示表情图标 0为表情，1为键盘
 */
@property(nonatomic,assign)BOOL isshowKeyBoard;

@end
