//
//  ZWComposToolBar.m
//  ZW微博
//
//  Created by rayootech on 16/2/8.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWComposToolBar.h"

@interface ZWComposToolBar ()

@property(nonatomic,weak)UIButton *emotionButton;

@end

@implementation ZWComposToolBar

-(instancetype)initWithFrame:(CGRect)frame
{

    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
      
        //初始化按钮
        [self setUpBtn:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted" buttonType:ZWToolBarTakePhoto];
        
        [self setUpBtn:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" buttonType:ZWToolBarGetPicture];
        
        [self setUpBtn:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" buttonType:ZWToolBarAtSomeBody];
        
        
        [self setUpBtn:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" buttonType:ZWToolBarShareSomething];
        
        self.emotionButton=[self setUpBtn:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" buttonType:ZWToolBarSmile];
        
    }
    return self;
}

/**
 *  创建一个按钮
 */
-(UIButton *)setUpBtn:(NSString *)image highImage:(NSString *)highImage buttonType:(ZWToolBarType)type
{

    UIButton *btn=[[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag=type;
    [self addSubview:btn];
    
    return btn;
}

-(void)layoutSubviews{

    [super layoutSubviews];
    
    //设置所有的按钮的frame
    NSUInteger count=self.subviews.count;
    CGFloat btnW=self.width/count;
    CGFloat btnH=self.height;
    for (NSUInteger i=0; i<count; i++) {
        UIButton *btn=self.subviews[i];
        btn.y=0;
        btn.width=btnW;
        btn.x=i*btnW;
        btn.height=btnH;
    }
}

-(void)btnClick:(UIButton *)btn
{
//    NSLog(@"%f",btn.x/btn.width);

    if ([self.delegate respondsToSelector:@selector(composeToolBar:didClickButton:)]) {
        [self.delegate composeToolBar:self didClickButton:btn.tag];
    }
}

-(void)setIsshowKeyBoard:(BOOL)isshowKeyBoard
{
    _isshowKeyBoard=isshowKeyBoard;
    
    NSString *image=@"compose_emoticonbutton_background";
    NSString *highimage=@"compose_emoticonbutton_background_highlighted";
    if (isshowKeyBoard) {
        //显示键盘图标
        image=@"compose_keyboardbutton_background";
        highimage=@"compose_keyboardbutton_background_highlighted";
    }
    [self.emotionButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    [self.emotionButton setImage:[UIImage imageNamed:highimage] forState:UIControlStateHighlighted];

}

@end
