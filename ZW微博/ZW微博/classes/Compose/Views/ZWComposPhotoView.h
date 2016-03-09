//
//  ZWComposPhotoView.h
//  ZW微博
//
//  Created by rayootech on 16/2/9.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWComposPhotoView : UIView

//图片数组
@property(nonatomic,strong,readonly)NSMutableArray *photos;

-(void)addPhoto:(UIImage *)image;

@end
