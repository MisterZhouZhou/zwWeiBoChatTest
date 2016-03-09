//
//  ZWEmotionListView.m
//  ZW微博
//
//  Created by rayootech on 16/2/9.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWEmotionListView.h"
#import "ZWEmotionPageView.h"


@interface ZWEmotionListView ()<UIScrollViewDelegate>

@property(nonatomic,weak)UIScrollView *scrollView;

@property(nonatomic,weak)UIPageControl *pageControl;

@end

@implementation ZWEmotionListView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor whiteColor];
        
        UIScrollView *scrollView=[[UIScrollView alloc]init];
        scrollView.pagingEnabled=YES;
        scrollView.delegate=self;
        //去除水平方向的滚动条
        scrollView.showsVerticalScrollIndicator=NO;
        scrollView.showsHorizontalScrollIndicator=NO;
        [self addSubview:scrollView];
        self.scrollView=scrollView;
        
        //pageControl
        UIPageControl *pageCon=[[UIPageControl alloc]init];
        pageCon.backgroundColor=[UIColor whiteColor];
        //只有一页的时候默认隐藏
        pageCon.hidesForSinglePage=YES;
        pageCon.userInteractionEnabled=NO;
        [pageCon setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"currentPageImage"];
        [pageCon setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"pageImage"];
        [self addSubview:pageCon];
        self.pageControl=pageCon;
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //设置frame
    //pagecon
    self.pageControl.width=self.width;
    self.pageControl.height=35;
    self.pageControl.x=0;
    self.pageControl.y=self.height-self.pageControl.height;
    
    //scrollview
    self.scrollView.width=self.width;
    self.scrollView.height=self.pageControl.y;
    self.scrollView.x=0;
    self.scrollView.y=0;
    
    //设置scrolview内部的每一页尺寸
    NSUInteger count=self.scrollView.subviews.count;
    for (int i=0; i<count; i++) {
        ZWEmotionPageView *pageView=self.scrollView.subviews[i];
        pageView.width=self.scrollView.width;
        pageView.x=pageView.width*i;
        pageView.height=self.scrollView.height;
        pageView.y=0;
    }
    
    //设置scorllview的contentSize
    self.scrollView.contentSize=CGSizeMake(count*self.scrollView.width, 0);
}

-(void)setEmotions:(NSArray *)emotions
{
    _emotions=emotions;
    
    //删除之前的控件
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //页码
    NSInteger count=(emotions.count+ZWEmotionPageSize-1)/ZWEmotionPageSize;
    
    //设置页数
    self.pageControl.numberOfPages=count;
    
    //创建用来显示每一页表情的控件
    for (int i=0; i<count; i++) {
        ZWEmotionPageView *pageView=[[ZWEmotionPageView alloc]init];
        //范围
        NSRange range;
        range.location=i*ZWEmotionPageSize;
        NSUInteger left=emotions.count-range.location;
        if (left>=ZWEmotionPageSize) {//足够20个
            range.length=ZWEmotionPageSize;
        }
        else{
            range.length=left;
        }
        
        pageView.emotions=[emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
    }
    
    //重新排版子控件
    [self setNeedsLayout];
}

#pragma mark-scrollView Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageNO=scrollView.contentOffset.x/scrollView.width;
    self.pageControl.currentPage=(int)(pageNO+0.5);
}

@end
