//
//  ZWEmotion.h
//  ZW微博
//
//  Created by rayootech on 16/2/9.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWEmotion : NSObject<NSCoding>

/*表情的文字描述*/
@property(nonatomic,copy)NSString *chs;
/*表情的png图片名*/
@property(nonatomic,copy)NSString *png;
/*表情的16进制编码*/
@property(nonatomic,copy)NSString *code;
@end
