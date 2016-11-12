//
//  ViewController.m
//  CKDataStructureKit
//
//  Created by caokun on 16/11/4.
//  Copyright © 2016年 caokun. All rights reserved.
//

#import "ViewController.h"
#import "CKDataStructureKit.h"      // 导入头文件

@interface ViewController ()

@property (strong, nonatomic) CKStack *stack;               // 栈
@property (strong, nonatomic) CKQueue *queue;               // 队列
@property (strong, nonatomic) CKPriorityQueue *priQueue;    // 优先队列

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // -------------------- stack 测试 ---------------------
    self.stack = [[CKStack alloc] init];
    NSLog(@"入栈");
    for (int i=0; i<50; i++) {
        [self.stack push:@(i)];
    }
    NSLog(@"size = %ld", self.stack.size);
    NSArray *array = [self.stack allObjects];
    NSLog(@"%@", array);
    
    NSLog(@"出栈");
    NSNumber *b = nil;
    while (![self.stack isEmpty]) {
        b = [self.stack top];
        if (b) {
            NSLog(@"%@", b);
        }
        [self.stack pop];
    }
    NSLog(@"出栈完毕");
    
    [self.stack clear];
    [self.stack push:@(123)];
    [self.stack push:nil];      // 支持 nil
    self.stack = nil;           // 手动释放，也可由 ARC 释放
    
    
    // -------------------- queue 测试 ---------------------
    self.queue = [[CKQueue alloc] init];
    NSLog(@"入队");
    for (int i=0; i<10; i++) {
        [self.queue push:@(i)];
    }
    [self.queue pop];
    for (int i=0; i<5; i++) {
        [self.queue push:@(i)];
    }
    NSNumber *f = [self.queue front];
    NSNumber *r = [self.queue rear];
    NSLog(@"%@, %@, %ld", f, r, self.queue.length);
    NSLog(@"%@", [self.queue allObjects]);
    
    NSLog(@"出队");
    while (![self.queue isEmpty]) {
        NSLog(@"%@", [self.queue front]);
        [self.queue pop];
    }
    
    [self.queue push:@(123)];
    [self.queue clear];
    NSLog(@"%@", [self.queue allObjects]);
    
    [self.queue push:@(222)];
    NSLog(@"%@", [self.queue allObjects]);
    [self.queue pop];
    [self.queue pop];
    
    self.queue = nil;
    
    
    // -------------------- PriorityQueue 测试 ---------------------
    self.priQueue = [[CKPriorityQueue alloc] initWithCompareBlock:^BOOL(id obj1, id obj2) {
        int b1 = [(NSNumber *)obj1 intValue];
        int b2 = [(NSNumber *)obj2 intValue];
        return b1 > b2 ? true : false;          // b1 > b2 返回 true 表示升序
    }];
    
    NSLog(@"pri 入队");
    for (int i=0; i<10; i++) {
        int x = arc4random() % 100;
        [self.priQueue push:@(x)];
    }
    [self.priQueue pushWithArray:@[@(2), @(1), @(3)]];
//    [self.priQueue clear];

    NSLog(@"pri 出队");
    NSNumber *c;
    while (![self.priQueue isEmpty]) {
        c = [self.priQueue top];
        NSLog(@"pop = %@", c);
        [self.priQueue pop];
    }
    self.priQueue = nil; 
}

@end
