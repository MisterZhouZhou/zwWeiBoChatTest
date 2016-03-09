//
//  UIImage+ZWImgRender.m
//  ZW微博
//
//  Created by rayootech on 15/11/1.
//  Copyright © 2015年 rayootech. All rights reserved.
//

#import "UIImage+ZWImgRender.h"
//iOS7渲染图片
@implementation UIImage (ZWImgRender)

+(instancetype)UIImageRenderingModeWithString:(NSString *)imgNameStr{
    
    UIImage *img=[UIImage imageNamed:imgNameStr];
    return [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     
}
@end
