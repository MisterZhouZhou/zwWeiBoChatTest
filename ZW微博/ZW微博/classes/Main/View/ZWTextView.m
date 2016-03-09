//
//  ZWTextView.m
//  ZW微博
//
//  Created by rayootech on 16/2/8.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWTextView.h"
#import "ZWEmotion.h"
#import "UITextView+ZWExtension.h"
#import "ZWEmotionAttachment.h"
@implementation ZWTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        //通知
        
        [ZWNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    
    return  self;
}

#pragma mark-文本框内容发生改变调用
-(void)textDidChange
{

   //重新画
    [self setNeedsDisplay];
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    
    //重新画
    [self setNeedsDisplay];
}

-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
    
}

-(void)drawRect:(CGRect)rect
{
    if (self.hasText) return;
    
    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName]=self.font;
    attrs[NSForegroundColorAttributeName]=self.placeholderColor?self.placeholderColor:[UIColor lightGrayColor];
    
    //画文字
    CGFloat x=5;
    CGFloat y=8;
    CGFloat w=rect.size.width-2*x;
    CGFloat h=rect.size.height-2*y;
    CGRect placeholderRect=CGRectMake(x, y, w, h);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder=[placeholder copy];
    
    [self setNeedsDisplay];
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{

    _placeholderColor=placeholderColor;
    
    [self setNeedsDisplay];
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsDisplay];
}

#pragma mark-插入表情文字
-(void)insertEmotion:(ZWEmotion *)emotion
{
    if (emotion.code) {//系统图片
        
        [self insertText:emotion.code.emoji];
        
    }else if (emotion.png)
    {
        //加载图片
        ZWEmotionAttachment *attch=[[ZWEmotionAttachment alloc]init];
        //传递模型
        attch.emotion=emotion;
        
        CGFloat attchWH=self.font.lineHeight;
        attch.bounds=CGRectMake(0, -4, attchWH, attchWH);
        NSAttributedString *Imgattr=[NSAttributedString attributedStringWithAttachment:attch];
        
        //插入表情
        [self insertArrributeText:Imgattr settingBlock:^(NSMutableAttributedString *attributedText) {
            
            //设置字t
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        }];
        
        
    }
}

#pragma mark-获取全文本
-(NSString *)fullText
{
    NSMutableString *fullText=[NSMutableString string];
    
    //遍历文字和图片，会把文字和图片拆分
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
       
        //如果是图片
        ZWEmotionAttachment *attch=attrs[@"NSAttachment"];
        if (attch) {//图片
            
            [fullText appendString:attch.emotion.chs];//图片描述
            
        }else //普通文本
        {
            //获取这个范围的文字
            NSAttributedString *str=[self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
        }
        
    }];
    return fullText;
}



-(void)dealloc
{
    [ZWNotificationCenter removeObserver:self];
}

@end
