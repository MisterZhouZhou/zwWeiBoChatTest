//
//  UITextView+ZWExtension.m
//  ZW微博
//
//  Created by rayootech on 16/2/10.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "UITextView+ZWExtension.h"

@implementation UITextView (ZWExtension)

-(void )insertArrributeText:(NSAttributedString *)text
{
    
    [self insertArrributeText:text settingBlock:nil];
}


-(void)insertArrributeText:(NSAttributedString *)text settingBlock:(void(^)(NSMutableAttributedString *attributedText))settingBlock
{
    NSMutableAttributedString *attributedText=[[NSMutableAttributedString alloc]init];
    //拼接之前的文字
    [attributedText appendAttributedString:self.attributedText];
    
    //    //加载图片
    //    NSTextAttachment *attch=[[NSTextAttachment alloc]init];
    //    attch.image=[UIImage imageNamed:emotion.png];
    //    CGFloat attchWH=self.font.lineHeight;
    //    attch.bounds=CGRectMake(0, -4, attchWH, attchWH);
    //    NSAttributedString *Imgattr=[NSAttributedString attributedStringWithAttachment:attch];
    
    //获取光标的位置
    NSUInteger loc=self.selectedRange.location;
//    [attributedText insertAttributedString:text atIndex:loc];
    
    //替换选中范围内的文字
    [attributedText replaceCharactersInRange:self.selectedRange withAttributedString:text];
    
    
    if (settingBlock) {
        
        settingBlock(attributedText);
    }
    
    self.attributedText=attributedText;
    
    //设置光标的位置
    self.selectedRange=NSMakeRange(loc+1, 0);
    
}
@end
