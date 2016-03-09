//
//  ZWTitleButton.m
//  ZW微博
//
//  Created by rayootech on 15/11/2.
//  Copyright © 2015年 rayootech. All rights reserved.
//

#import "ZWTitleButton.h"

#define ZWMargin 5

@implementation ZWTitleButton

-(instancetype)initWithFrame:(CGRect)frame{

    self=[super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font=[UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    }
    return self;
}

//目的，在系统计算和设置按钮的尺寸后，修改一下尺寸
-(void)setFrame:(CGRect)frame{

    frame.size.width+=ZWMargin;
    [super setFrame:frame];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //如果仅仅是调整按钮内部的titleLabel 和imageView的位置，在layoutSubviews设置即可
    //1.计算titleLabel的frame
//    self.titleLabel.x=self.imageView.x;
    
    //2.计算imageView的frame
    self.imageView.x=CGRectGetMaxX(self.titleLabel.frame)+ZWMargin;
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
 
    [super setTitle:title forState:state];
    
    //设置标题自适应大小
    [self sizeToFit];
}

-(void)setImage:(UIImage *)image forState:(UIControlState)state{
 
    [super setImage:image forState:state];
    
    //修改图片自适应
    [self sizeToFit];
}

@end
