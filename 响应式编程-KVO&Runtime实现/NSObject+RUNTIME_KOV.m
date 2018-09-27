//
//  NSObject+RUNTIME_KOV.m
//  响应式编程-KVO&Runtime实现
//
//  Created by Yinht on 2018/9/21.
//  Copyright © 2018年 yinht. All rights reserved.
//

#import "NSObject+RUNTIME_KOV.h"
#import <objc/message.h>

@implementation NSObject (RUNTIME_KOV)

// 利用runtime交换原始类指针指向到创建动态类，然后在子类重写分类方法，从而实现监听
- (void)RUNTIME_addObserver:(NSObject *)observer {
    // 创建动态类
    NSString *oldClassName = NSStringFromClass([self class]);
    NSString *newName = [NSString stringWithFormat:@"RUNTIME_KVO_%@",oldClassName];
    const char *newClassName = [newName UTF8String];
    Class RUNTIMEClass = objc_allocateClassPair([self class], newClassName, 0);
    class_addMethod(RUNTIMEClass, @selector(setName:), (IMP)setName, "v@:@");

    // 注册
    objc_registerClassPair(RUNTIMEClass);
    // 指向
    object_setClass(self, RUNTIMEClass);
    // 绑定
    objc_setAssociatedObject(self, (__bridge const void *)@"123", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

// 注意使用消息转发机制的时候需要在Xcode配置中将检测机制关闭。坑啊，很多作者在发送runtime实现KVO功能的时候默认大家已经会使用runtime类库了就没有标注说明
void setName(id self,SEL _cmd,NSString * newName){
    
    id class = [self class];
    object_setClass(self, class_getSuperclass([self class]));
    objc_msgSend(self, @selector(setName:),newName);
    id observer = objc_getAssociatedObject(self, (__bridge const void *)@"123");
    objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject:change:context:),self,@"name",@{@"new":newName},nil);
    object_setClass(self, class);
    
}

@end
