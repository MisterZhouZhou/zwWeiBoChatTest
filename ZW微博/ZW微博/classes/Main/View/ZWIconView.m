//
//  ZWIconView.m
//  ZW微博
//
//  Created by rayootech on 16/2/8.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWIconView.h"
#import "ZWUser.h"
@interface ZWIconView ()

@property(nonatomic,weak)UIImageView *verifiedView;

@end
@implementation ZWIconView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.clipsToBounds=YES;
    }
    return self;
}

-(UIImageView *)verifiedView
{
    if (_verifiedView==nil) {
        UIImageView *verView=[[UIImageView alloc]init];
        [self addSubview:verView];
        self.verifiedView=verView;
    }
    
    return _verifiedView;
}

-(void)setUser:(ZWUser *)user
{

    _user=user;
    
    //下载图片
    [self sd_setImageWithURL:user.profile_image_url placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    //设置图片
    switch (user.verified_type) {
//        case ZWUserVerifiedTypeNone://没有任何认证
//            self.verifiedView.hidden=YES;
//            
//            break;
        case ZWUserVerifiedPersonal://个人认证
             self.verifiedView.hidden=NO;
             self.verifiedView.image=[UIImage imageNamed:@"avatar_vip"];
            
            break;
        case ZWUserVerifiedOrgEnterprice://企业官方：CSDN，EOE，搜狐新闻客户端
        case ZWUserVerifiedOrgEMedia://媒体官方：程序员杂志，苹果汇
        case ZWUserVerifiedOrgWebsite://网站官方：猫扑
            self.verifiedView.hidden=NO;
            self.verifiedView.image=[UIImage imageNamed:@"avatar_enterprise_vip"];
            
            break;
        case ZWUserVerifiedDaren://微博达人
            self.verifiedView.hidden=NO;
            self.verifiedView.image=[UIImage imageNamed:@"avatar_grassroot"];
            
            break;
        default:
            self.verifiedView.hidden=YES;
            break;
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat scale=0.6;
    self.verifiedView.size=self.verifiedView.image.size;
    self.verifiedView.x=self.width-self.verifiedView.width*scale;
    self.verifiedView.y=self.height-self.verifiedView.height*scale;

}

@end
