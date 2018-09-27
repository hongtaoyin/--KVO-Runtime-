//
//  ViewController.m
//  响应式编程-KVO&Runtime实现
//
//  Created by Yinht on 2018/9/21.
//  Copyright © 2018年 yinht. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+RUNTIME_KOV.h"
#import <objc/message.h>

@interface ViewController ()

@property (nonatomic, strong) Person *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    Person *person = [[Person alloc] init];
//    _person = person;
//    [person RUNTIME_addObserver:self];
    
    // 改用runtime消息转发机制实现实例化
    Person *person = objc_msgSend(objc_msgSend([Person class], @selector(alloc)), @selector(init));
    _person = person;
    objc_msgSend(_person, @selector(RUNTIME_addObserver:),self);
    
    UIImageView *imageView = objc_msgSend(objc_msgSend([UIImageView class], @selector(alloc)), @selector(init));
    objc_msgSend(imageView, @selector(setBackgroundColor:),objc_msgSend([UIColor class], @selector(redColor)));
    objc_msgSend(imageView, @selector(setFrame:), CGRectMake(0, 0, 100, 100));
    objc_msgSend(objc_msgSend(self, @selector(view)), @selector(addSubview:), imageView);
    
    person.sleepNow.workNow.eat(@"面包");// 链式函数式编程
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"%@===>%@",change,_person.name);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    static int i = 0;
    i++;
    _person.name = [NSString stringWithFormat:@"%d",i];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
