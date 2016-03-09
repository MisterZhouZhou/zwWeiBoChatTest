//
//  UIView+ZWCommon.m
//  ZW微博
//
//  Created by rayootech on 16/2/6.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "UIView+ZWCommon.h"
#import "Masonry.h"
#import <objc/runtime.h>
static char BlankPageViewKey;
@implementation UIView (ZWCommon)
#pragma mark - BlankPageView(空白页视图)
- (void)setBlankPageView:(EaseBlankPageView *)blankPageView{
    [self willChangeValueForKey:@"BlankPageViewKey"];
    objc_setAssociatedObject(self, &BlankPageViewKey,
                             blankPageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"BlankPageViewKey"];
}

- (EaseBlankPageView *)blankPageView{
    return objc_getAssociatedObject(self, &BlankPageViewKey);
}

- (void)configBlankPage:(ZWBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block{
    if (hasData) {
        if (self.blankPageView) {
            self.blankPageView.hidden = YES;
            [self.blankPageView removeFromSuperview];
        }
    }else{
        if (!self.blankPageView) {
            
            CGFloat height = 0;
            if (self.bounds.size.height == kScreen_Height) {
                height = self.bounds.size.height - 64;
            }
            else {
                height = self.bounds.size.height;
            }
            self.blankPageView = [[EaseBlankPageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, height)];
        }
        self.blankPageView.hidden = NO;
        [self.blankPageContainer addSubview:self.blankPageView];
        
        //        [self.blankPageContainer insertSubview:self.blankPageView atIndex:0];
        //        [self.blankPageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.size.equalTo(self);
        //            make.top.left.equalTo(self.blankPageContainer);
        //        }];
        [self.blankPageView configWithType:blankPageType hasData:hasData hasError:hasError reloadButtonBlock:block];
    }
}

- (UIView *)blankPageContainer{
    UIView *blankPageContainer = self;
    for (UIView *aView in [self subviews]) {
        if ([aView isKindOfClass:[UITableView class]]) {
            blankPageContainer = aView;
        }
    }
    return blankPageContainer;
}
@end

@implementation EaseBlankPageView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}

- (void)configWithType:(ZWBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block
{
    if (hasData) {
        [self removeFromSuperview];
    }
    self.alpha=1.0;
    
    if (!_bgiconView) {
        _bgiconView=[[UIImageView alloc]initWithFrame:CGRectZero];
        [self addSubview:_bgiconView];
    }
    
    if (!_tipLabel) {
        _tipLabel=[[UILabel alloc]initWithFrame:CGRectZero];
        _tipLabel.backgroundColor=[UIColor clearColor];
        _tipLabel.numberOfLines=0;
        _tipLabel.font=[UIFont systemFontOfSize:17.0];
        _tipLabel.textColor=[UIColor lightGrayColor];
        _tipLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_tipLabel];
    }
    
    [_bgiconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        //make.bottom.equalTo(self.mas_centerY);
        make.top.mas_equalTo(kScreen_Width/320*70);
    }];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerX.equalTo(self);
        make.top.equalTo(_bgiconView.mas_bottom);
        make.height.mas_equalTo(kScreen_Width/320*40);
    }];
    
    _reloadButtonBlock=nil;
    
    if (hasError) {
        //加载失败
        if (!_reloadButton) {
            _reloadButton=[UIButton buttonWithType:UIButtonTypeSystem];
            [_reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
            [_reloadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _reloadButton.backgroundColor=ZWColor(240,60,70);
            _reloadButton.layer.cornerRadius=5;
            _reloadButton.layer.masksToBounds=YES;
            _reloadButton.adjustsImageWhenHighlighted=YES;
            _reloadButton.titleLabel.font=FontBoldSize(18);
            [_reloadButton addTarget:self action:@selector(reloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_reloadButton];
            [_reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(_tipLabel.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(160, kScreen_Width/320*40));
            }];
        }
        _reloadButton.hidden=NO;
        _reloadButtonBlock=block;
        [_bgiconView setImage:[UIImage imageNamed:@"d_baibai"]];
        _tipLabel.text = @"网络连接异常,请检查网络设置";
    }
    else{
        if (_reloadButton) {
            _reloadButton.hidden=YES;
        }
        NSString *imageName,*tipStr;
        switch (blankPageType) {
            case ZWBlankPageScoreView:
                imageName = @"blankpage_image_loadFail";
                tipStr = @"暂无微博数据";
                break;
            case ZWBlankPageScoreView2:
                
                break;
            default:
                break;
        }
        [_bgiconView setImage:[UIImage imageNamed:imageName]];
        _tipLabel.text = tipStr;
    }
}

#pragma mark-重新加载
- (void)reloadButtonClicked:(id)sender{

    self.hidden = YES;
    
    [self removeFromSuperview];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (_reloadButtonBlock) {
            _reloadButtonBlock(sender);
        }
    });
}
@end