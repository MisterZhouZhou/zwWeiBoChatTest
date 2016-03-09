//
//  ZWHomeFrame.m
//  ZW微博
//
//  Created by rayootech on 16/1/31.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWHomeFrame.h"
#import "ZWStatus.h"
#import "ZWUser.h"

@implementation ZWHomeFrame

-(void)setStatus:(ZWStatus *)status
{
    _status=status;
    
    //计算原创微博
    [self setUpOriginalViewFrame];
    
    CGFloat toolBarY=CGRectGetMaxY(_originalViewFrame);
    //计算转发微博
    if (status.retweeted_status) {
      [self setUpreweetViewFrame];
        
        toolBarY=CGRectGetMaxY(_retweetViewFrame);
    }
   
    
    //计算工具条高度
    CGFloat toolBarX=0;
    CGFloat toolBarW=kScreen_Width;
    CGFloat toolBarH=35;
    _statusToolBarViewFrame=CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    //计算cell高度
    _cellHight=CGRectGetMaxY(_statusToolBarViewFrame);
}

#pragma mark-计算原创微博
-(void)setUpOriginalViewFrame
{
    //头像
    CGFloat imageX=ZWStatusCellMargin;
    CGFloat imageY=imageX;
    CGFloat imageWH=35;
    _iconViewFrame=CGRectMake(imageX, imageY, imageWH, imageWH);
    
    //昵称
    CGFloat nameX=CGRectGetMaxX(_iconViewFrame)+ZWStatusCellMargin;
    CGFloat nameY=imageY;
   
    CGSize nameSize=[_status.user.name sizeWithFont:ZWNameFont];
    _nameLabelFrame=(CGRect){{nameX,nameY},nameSize};
    
    //vip
    if (_status.user.isVip) {
        CGFloat vipX=CGRectGetMaxX(_nameLabelFrame)+ZWStatusCellMargin;
        CGFloat vipY=nameY;
        CGFloat vipWH=14;
        _vipLabelFrame=CGRectMake(vipX, vipY, vipWH, vipWH);
    }
    
    //时间
//    CGFloat timeX=nameX;
//    CGFloat timeY=CGRectGetMaxY(_nameLabelFrame)+ZWStatusCellMargin*0.5;
//    CGSize timeSize=[_status.created_at sizeWithFont:ZWNameFont];
//    _timeLabelFrame=(CGRect){{timeX,timeY},timeSize};
    
    //来源
//    CGFloat sourceX=CGRectGetMaxX(_timeLabelFrame)+ZWStatusCellMargin;
//    CGFloat sourceY=timeY;
//    CGSize soucreSize=[_status.source sizeWithFont:ZWNameFont];
//    _souceLabelFrame=(CGRect){{sourceX,sourceY},soucreSize};
    
    //正文
    CGFloat textX=imageX;
    CGFloat textY=CGRectGetMaxY(_iconViewFrame)+ZWStatusCellMargin;
    CGFloat textW=kScreen_Width-2*ZWStatusCellMargin;
    CGSize textSize=[_status.text sizeWithFont:ZWTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _contentLabelFrame=(CGRect){{textX,textY},textSize};
    
    CGFloat originH=CGRectGetMaxY(_contentLabelFrame)+ZWStatusCellMargin;
    //配图
    if (_status.pic_urls.count) {
        CGFloat photosX=ZWStatusCellMargin;
        CGFloat photosY=CGRectGetMaxY(_contentLabelFrame)+ZWStatusCellMargin;
        CGSize photosSize=[self photosSizeWithCount:_status.pic_urls.count];
        _originPhotoViewFrame=(CGRect){{photosX,photosY},photosSize};
        
        originH=CGRectGetMaxY(_originPhotoViewFrame)+ZWStatusCellMargin;
    }
    
    
    //原创微博的frame
    CGFloat originX=0;
    CGFloat originY=10;
    CGFloat originW=kScreen_Width;
    
    _originalViewFrame=CGRectMake(originX, originY, originW, originH);
    
}

#pragma mark-计算配图的尺寸
-(CGSize)photosSizeWithCount:(NSInteger)count
{
 
 //获得总列数
    NSInteger cols=count==4?2:3;
    //获得总行数 5
    NSInteger rols=(count-1) / cols + 1;;
    CGFloat photoWH=70;
    CGFloat w=cols*photoWH+(cols-1)*ZWStatusCellMargin;
    CGFloat h=rols*photoWH+(rols-1)*ZWStatusCellMargin;
    

    return CGSizeMake(w, h);
}


#pragma mark-计算转发微博
-(void)setUpreweetViewFrame
{
    //昵称
    CGFloat nameX=ZWStatusCellMargin;
    CGFloat nameY=nameX;
    
    CGSize nameSize=[_status.retweeted_status.user.name sizeWithFont:ZWNameFont];
    _retnameLabelFrame=(CGRect){{nameX,nameY},nameSize};
    
    //正文
    CGFloat textX=nameX;
    CGFloat textY=CGRectGetMaxY(_retnameLabelFrame)+ZWStatusCellMargin;
    CGFloat textW=kScreen_Width-2*ZWStatusCellMargin;
    CGSize textSize=[_status.retweetName sizeWithFont:ZWTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _retcontentLabelFrame=(CGRect){{textX,textY},textSize};
    
    
    CGFloat retweetH=CGRectGetMaxY(_retcontentLabelFrame)+ZWStatusCellMargin;

    //配图
    NSInteger count=_status.retweeted_status.pic_urls.count;
    if (count) {
        CGFloat photosX=ZWStatusCellMargin;
        CGFloat photosY=CGRectGetMaxY(_retcontentLabelFrame)+ZWStatusCellMargin;
        CGSize photosSize=[self photosSizeWithCount:count];
        _retweetPhotoViewFrame=(CGRect){{photosX,photosY},photosSize};
        
        retweetH=CGRectGetMaxY(_retweetPhotoViewFrame)+ZWStatusCellMargin;
    }

    //转发微博的frame
    CGFloat retweetX=0;
    CGFloat retweetY=CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW=kScreen_Width;
        _retweetViewFrame=CGRectMake(retweetX, retweetY, retweetW, retweetH);

}



@end
