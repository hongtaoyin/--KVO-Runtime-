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
    _person = objc_msgSend([Person class], @selector(alloc));
    objc_msgSend(_person, @selector(RUNTIME_addObserver:),self);
    
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
