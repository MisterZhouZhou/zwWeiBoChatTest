//
//  ZWTextView.h
//  ZW微博
//
//  Created by rayootech on 16/2/8.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWEmotion;
@interface ZWTextView : UITextView

@property(nonatomic,copy)NSString *placeholder;//占位文字

@property(nonatomic,strong)UIColor *placeholderColor;//占位文字颜色

//设置表情文字混排
-(void)insertEmotion:(ZWEmotion *)emotion;

//获取（表情+文字）图文内容
-(NSString *)fullText;

@end
