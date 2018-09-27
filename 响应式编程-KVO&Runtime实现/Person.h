//
//  Person.h
//  响应式编程-KVO&Runtime实现
//
//  Created by Yinht on 2018/9/21.
//  Copyright © 2018年 yinht. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic,copy) NSString *name;

- (Person *(^)(NSString *))eat;
- (Person *)workNow;
- (Person *)sleepNow;

@end
