//
//  ZWPhotoView.m
//  ZW微博
//
//  Created by rayootech on 16/2/6.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWPhotoView.h"
#import "ZWPhoto.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "ZWPhotoImageView.h"
@interface ZWPhotoView ()

@end

@implementation ZWPhotoView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame:frame]) {
        
        //添加所有控件
        [self setUpAllChileView];
    }
    return self;
}

-(void)setUpAllChileView
{

   //添加9个子控件
    for (int i=0; i<9; i++) {
        ZWPhotoImageView *imageV=[[ZWPhotoImageView alloc]init];
        
        imageV.tag=i;
        //添加手势
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [imageV addGestureRecognizer:tap];
        
        [self addSubview: imageV];
    }
}

-(void)setPic_urls:(NSArray *)pic_urls
{

    _pic_urls=pic_urls;
    NSInteger count=self.subviews.count;
    for (int i=0; i<count; i++) {
        
        ZWPhotoImageView *imageV=self.subviews[i];
        
        if(i<_pic_urls.count){
            
            imageV.hidden=NO;
            
            ZWPhoto *photo=_pic_urls[i];
            
            //赋值
            imageV.photo=photo;
            
            
        }
        else{
            imageV.hidden=YES;
        }
    }
    
}

#pragma mark-计算显示出来的imageView尺寸
-(void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat x=0;
    CGFloat y=0;
    CGFloat w=70;
    CGFloat h=70;
    CGFloat margin=10;
    NSInteger col=0;
    NSInteger rol=0;
    NSInteger cols=_pic_urls.count==4?2:3;
    
    for(int i=0;i<_pic_urls.count;i++)
    {
        col=i%cols;
        rol=i/cols;
        UIImageView *imageV=self.subviews[i];
        x=col*(w+margin);
        y=rol*(w+margin);
        imageV.frame=CGRectMake(x, y, w, h);
    }
}

#pragma mark-Tap 点击图片时调用
-(void)tap:(UITapGestureRecognizer *)tap
{
    UIImageView *tapView=(UIImageView *)tap.view;
    //模型转化
    int i=0;
    NSMutableArray *arrM=[NSMutableArray array];
    for (ZWPhoto *photo in _pic_urls) {
        MJPhoto *p=[[MJPhoto alloc]init];
        NSString *urlStr=photo.thumbnail_pic.absoluteString;
        urlStr=[urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        p.url=[NSURL URLWithString:urlStr];
        p.index=i;
        p.srcImageView=tapView;
        [arrM addObject:p];
        
        i++;
    }
    
  
    //创建浏览器对象
    MJPhotoBrowser *brower=[[MJPhotoBrowser alloc]init];
    brower.photos=arrM;
    brower.currentPhotoIndex=tapView.tag;
    [brower show];
}
@end
