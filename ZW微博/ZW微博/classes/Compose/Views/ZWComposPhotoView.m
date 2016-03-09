//
//  ZWComposPhotoView.m
//  ZW微博
//
//  Created by rayootech on 16/2/9.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWComposPhotoView.h"

@implementation ZWComposPhotoView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        _photos=[NSMutableArray array];
    }
    
    return self;
}

-(void)addPhoto:(UIImage *)image
{
    UIImageView *photoView=[[UIImageView alloc]init];
    photoView.image=image;
    [self addSubview:photoView];
    
    //存储图片
    [self.photos addObject:image];
}

-(void)layoutSubviews{

    [super layoutSubviews];
    
    //计算图片的尺寸和位置
    NSInteger count=self.photos.count;
    int maxCol=4;
    CGFloat imageWH=70;
    CGFloat margin=10;
    
    for(int i=0;i<count;i++)
    {
        UIImageView *photoView=self.subviews[i];
        int col=i % maxCol;
        int rol=i / maxCol;
        photoView.x=col*(imageWH+margin);
        photoView.y=rol*(imageWH+margin);
        photoView.width=imageWH;
        photoView.height=imageWH;
    }
}

@end
