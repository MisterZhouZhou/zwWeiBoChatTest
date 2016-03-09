//
//  ZWHomeTableViewCell.m
//  ZW微博
//
//  Created by rayootech on 16/1/31.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWHomeTableViewCell.h"
#import "ZWOriginalView.h"
#import "ZWRetweetView.h"
#import "ZWStatusToolBar.h"
#import "ZWStatus.h"
#import "ZWHomeFrame.h"
#import "ZWIconView.h"
@interface ZWHomeTableViewCell()

@property(nonatomic,weak)ZWOriginalView *originalView;

@property(nonatomic,weak)ZWRetweetView *retweetView;

@property(nonatomic,weak)ZWStatusToolBar *statToolbarView;

@end

@implementation ZWHomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

//cell是用
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
 
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //添加所有子控件
        [self setUpAllChileView];
        self.backgroundColor=[UIColor clearColor];
    }
    return  self;
}


-(void)setUpAllChileView
{
    //原创微博
    ZWOriginalView *originalView=[[ZWOriginalView alloc]init];
    _originalView=originalView;
    [self addSubview:originalView];
    
    //转发微博
    
    ZWRetweetView *retweetView=[[ZWRetweetView alloc]init];
    _retweetView=retweetView;
    [self addSubview:retweetView];
    
    //工具条
    ZWStatusToolBar *statusToolbarView=[[ZWStatusToolBar alloc]init];
    _statToolbarView=statusToolbarView;
    [self addSubview:statusToolbarView];
    
}

+(instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *ID=@"cell";
    id cell=[tableview dequeueReusableCellWithIdentifier:ID];
    
    if (cell==nil) {
        cell=[[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }

//    cell.textLabel.text=self.status.user.name;
//    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
//    cell.detailTextLabel.text=status.text;

    
    return cell;
    
}

-(void)setStatusF:(ZWHomeFrame *)statusF
{
     _statusF=statusF;
    
    //设置原创微博的frame
    _originalView.frame=statusF.originalViewFrame;
    _originalView.statusFrame=statusF;
    
    //设置转发微博的frame
    if (statusF.status.retweeted_status) {
        _retweetView.frame=statusF.retweetViewFrame;
        _retweetView.statusFrame=statusF;
        _retweetView.hidden=NO;
    }else
    {
        _retweetView.hidden=YES;
    }
    
    //设置工具条的frame
    _statToolbarView.frame=statusF.statusToolBarViewFrame;
    _statToolbarView.status=statusF.status;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
