//
//  ZWEmotion.m
//  ZW微博
//
//  Created by rayootech on 16/2/9.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWEmotion.h"
#import "MJExtension.h"
@implementation ZWEmotion

MJCodingImplementation

//#pragma mark-归档
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
////     [aCoder encodeObject:self.chs forKey:ZWChs];
////     [aCoder encodeObject:self.png forKey:ZWPng];
////     [aCoder encodeObject:self.code forKey:ZWCode];
//    
//}
//
//
//#pragma mark-解归档
//-(instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self=[super init]) {
////        self.chs=[aDecoder decodeObjectForKey:ZWChs];
////        self.png=[aDecoder decodeObjectForKey:ZWPng];
////        self.code=[aDecoder decodeObjectForKey:ZWCode];
//        //遍历所有的成员变量
//        [self enumerateIvarsWithBlock:^(MJIvar *ivar, BOOL *stop) {
//            ivar.value=[aDecoder decodeObjectForKey:ivar.name];
//        }];
//    }
//    return self;
//}

-(BOOL)isEqual:(ZWEmotion*)other
{
    return ([self.chs isEqualToString:other.chs] || [self.code isEqualToString:other.code]);

}

@end
