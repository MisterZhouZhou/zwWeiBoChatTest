//
//  UITextView+ZWExtension.h
//  ZW微博
//
//  Created by rayootech on 16/2/10.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (ZWExtension)

//插入表情
-(void)insertArrributeText:(NSAttributedString *)imgStr;

//设置会先调用外面设置
-(void)insertArrributeText:(NSAttributedString *)imgStr settingBlock:(void(^)(NSMutableAttributedString * attributedText))settingBlock;

@end
