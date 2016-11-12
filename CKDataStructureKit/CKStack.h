//
//  CKStack.h
//  CKDataStructureKit
//
//  Created by caokun on 16/11/4.
//  Copyright © 2016年 caokun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CKStack : NSObject

@property (assign, nonatomic) NSInteger size;   // 元素个数

// 为了性能，以下函数设计为线程不安全的，调用者需用 GCD 自行管理
- (void)push:(id)elem;      // 入栈
- (void)pop;                // 出栈
- (id)top;                  // 返回栈顶元素，或 nil
- (BOOL)isEmpty;            // 判空
- (NSArray *)allObjects;    // 返回栈中所有元素，顺序是栈顶到栈底
- (void)clear;              // 清空栈

@end
