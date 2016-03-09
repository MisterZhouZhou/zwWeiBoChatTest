//
//  ZWOriginalView.m
//  ZW微博
//
//  Created by rayootech on 16/1/31.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWOriginalView.h"
#import "ZWHomeFrame.h"
#import "ZWStatus.h"
#import "UIImageView+WebCache.h"
#import "ZWPhotoView.h"
#import "ZWIconView.h"
@interface ZWOriginalView ()
//头像
@property(nonatomic,weak) ZWIconView *iconView;
//昵称
@property(nonatomic,weak) UILabel *nameLabel;
//vip
@property(nonatomic,weak) UIImageView *vipView;
//时间
@property(nonatomic,weak) UILabel *timeLabel;
//来源
@property(nonatomic,weak) UILabel *souceLabel;
//正文
@property(nonatomic,weak) UILabel *contentLabel;

//配图
@property(nonatomic,weak)ZWPhotoView *photoView;

@end
@implementation ZWOriginalView

-(instancetype)initWithFrame:(CGRect)frame
{

    if (self=[super initWithFrame:frame]) {
        //添加所有子控件
        [self setUpAllChileView];
        self.userInteractionEnabled=YES;
        self.image=[UIImage imageWithStretchableName:@"timeline_card_top_background"];
    }
    
    return self;
}

-(void)setUpAllChileView
{
    //头像
    ZWIconView *iconView=[[ZWIconView alloc]init];
    _iconView=iconView;
    [self addSubview:iconView];
    
    //昵称
    UILabel *nameLabel=[[UILabel alloc]init];
    nameLabel.font=ZWNameFont;
    _nameLabel=nameLabel;
    [self addSubview:nameLabel];
    
    
    //vip
    UIImageView *vipview=[[UIImageView alloc]init];
    _vipView=vipview;
    [self addSubview:vipview];
    
    
    //时间
    UILabel *timeLabel=[[UILabel alloc]init];
    timeLabel.font=ZWTimeFont;
    timeLabel.textColor=[UIColor orangeColor];
     _timeLabel=timeLabel;
    [self addSubview:timeLabel];
    
    //来源
    UILabel *souceLabel=[[UILabel alloc]init];
    souceLabel.font=ZWSourceFont;
    souceLabel.textColor=[UIColor lightGrayColor];
    _souceLabel=souceLabel;
    [self addSubview:souceLabel];
    
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
    
    //设置frame
    [self setUpFrame];
    
    //设置数据
    [self setUpData];
    
}

//设置数据
-(void)setUpData
{

    ZWStatus *status=_statusFrame.status;
    //头像
//    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    _iconView.user=status.user;
    
    //昵称
    if (status.user.vip) {
        _nameLabel.textColor=[UIColor redColor];
    }
    else
    {
        _nameLabel.textColor=[UIColor blackColor];
    }
    _nameLabel.text=status.user.name;
    //vip
    NSString *imageName=[NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
    _vipView.image=[UIImage imageNamed:imageName];
    
    //时间
    _timeLabel.text=status.created_at;
    
    //来源
    _souceLabel.text=status.source;
    
    //正文
    _contentLabel.text=status.text;
    
    //配图
    _photoView.pic_urls=status.pic_urls;
}


//设置frame
-(void)setUpFrame
{
    //头像
    _iconView.frame=_statusFrame.iconViewFrame;

    //昵称
    _nameLabel.frame=_statusFrame.nameLabelFrame;
    
    //是vip
    if (_statusFrame.status.user.vip) {
        _vipView.hidden=NO;
        _vipView.frame=_statusFrame.vipLabelFrame;
    }else
    {
        _vipView.hidden=YES;
    }
    
    //时间，有新时间要算新时间的frame
     ZWStatus *status=_statusFrame.status;
    CGFloat timeX=_nameLabel.frame.origin.x;
    CGFloat timeY=CGRectGetMaxY(_nameLabel.frame)+ZWStatusCellMargin*0.5;
    CGSize timeSize=[status.created_at sizeWithFont:ZWNameFont];
    _timeLabel.frame=(CGRect){{timeX,timeY},timeSize};
    
    //来源
    CGFloat sourceX=CGRectGetMaxX(_timeLabel.frame)+ZWStatusCellMargin;
    CGFloat sourceY=timeY;
    CGSize soucreSize=[status.source sizeWithFont:ZWNameFont];
    _souceLabel.frame=(CGRect){{sourceX,sourceY},soucreSize};
    
    //正文
    _contentLabel.frame=_statusFrame.contentLabelFrame;
    
    //配图
    _photoView.frame=_statusFrame.originPhotoViewFrame;
}

@end
