//
//  Person.m
//  响应式编程-KVO&Runtime实现
//
//  Created by Yinht on 2018/9/21.
//  Copyright © 2018年 yinht. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)setName:(NSString *)name {
    _name = ([NSString stringWithFormat:@"监测到name赋值,%@",name]);
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    
    return YES;
}

@end
