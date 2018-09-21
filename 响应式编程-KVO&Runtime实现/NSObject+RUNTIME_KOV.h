//
//  NSObject+RUNTIME_KOV.h
//  响应式编程-KVO&Runtime实现
//
//  Created by Yinht on 2018/9/21.
//  Copyright © 2018年 yinht. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (RUNTIME_KOV)

- (void)RUNTIME_addObserver:(NSObject *)observer;

@end
