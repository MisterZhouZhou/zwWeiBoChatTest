//
//  ZWRetweetView.m
//  ZW微博
//
//  Created by rayootech on 16/1/31.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWRetweetView.h"
#import "ZWHomeFrame.h"
#import "ZWStatus.h"
#import "ZWPhotoView.h"
@interface ZWRetweetView ()

//昵称
@property(nonatomic,weak) UILabel *nameLabel;

//正文
@property(nonatomic,weak) UILabel *contentLabel;

//pei图
@property(nonatomic,weak)ZWPhotoView *photoView;

@end

@implementation ZWRetweetView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self=[super initWithFrame:frame]) {
        //添加所有子控件
        [self setUpAllChileView];
        self.userInteractionEnabled=YES;
        self.image=[UIImage imageWithStretchableName:@"timeline_retweet_background"];
        
    }
    
    return self;
}

-(void)setUpAllChileView
{
    //昵称
    UILabel *nameLabel=[[UILabel alloc]init];
    nameLabel.textColor=[UIColor blueColor];
    nameLabel.font=ZWNameFont;
    _nameLabel=nameLabel;
    [self addSubview:nameLabel];
    
    //正文
    UILabel *contentLabel=[[UILabel alloc]init];
    contentLabel.numberOfLines=0;
    contentLabel.font=ZWTextFont;
    _contentLabel=contentLabel;
    [self addSubview:contentLabel];
    
    //配图
    ZWPhotoView *photoView=[[ZWPhotoView alloc]init];
    [self addSubview:photoView];
    _photoView=photoView;
    
}

-(void)setStatusFrame:(ZWHomeFrame *)statusFrame
{

    _statusFrame=statusFrame;
    
    ZWStatus *status=statusFrame.status;
    //昵称
    _nameLabel.frame=statusFrame.retnameLabelFrame;
    _nameLabel.text=status.retweetName;
    
    //正文
    _contentLabel.frame=statusFrame.retcontentLabelFrame;
    _contentLabel.text=status.retweeted_status.text;
    
    //配图
    _photoView.frame=_statusFrame.retweetPhotoViewFrame;
#warning TODD :配置数据
    //配图
    _photoView.pic_urls=status.retweeted_status.pic_urls;

}

@end
