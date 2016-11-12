//
//  CKQueue.h
//  CKDataStructureKit
//
//  Created by caokun on 16/11/7.
//  Copyright © 2016年 caokun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CKQueue : NSObject

@property (assign, nonatomic) NSInteger length;   // 元素个数

// 为了性能，以下函数设计为线程不安全的，调用者需用 GCD 自行管理
- (void)push:(id)elem;      // 入队
- (void)pop;                // 出队
- (id)front;                // 返回队头元素，没有返回 nil
- (id)rear;                 // 返回队尾元素
- (BOOL)isEmpty;            // 判空
- (NSArray *)allObjects;    // 返回队列中所有元素，顺序是队头到队尾
- (void)clear;              // 清空队列

@end
