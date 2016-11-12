//
//  CKStack.m
//  CKDataStructureKit
//
//  Created by caokun on 16/11/4.
//  Copyright © 2016年 caokun. All rights reserved.
//

#import "CKStack.h"

typedef struct Node {       // 节点结构
    void *data;
    struct Node *next;
} Node;

// 栈结构 top -> [data] -> [data] -> NULL
typedef struct stack {      // 栈结构，链表存储
    Node *top;
    int size;
} Stack;


@implementation CKStack {
    Stack *stack;       // 栈
}

- (instancetype)init {
    if (self = [super init]) {
        [self initStack];
    }
    return self;
}

- (void)dealloc {
    [self destoryStack];
}

- (void)initStack {
    stack = (Stack *)malloc(sizeof(Stack));
    if (stack) {
        stack->size = 0;
        Node *tmp = (Node *)malloc(sizeof(Node));
        tmp->next = NULL;
        tmp->data = NULL;
        stack->top = (tmp ? tmp : NULL);
    } else {
        stack = NULL;
    }
}

- (void)destoryStack {
    while (stack->top) {
        Node *tmp = stack->top;
        stack->top = stack->top->next;
        if (tmp->data) {
            CFRelease(tmp->data);
        }
        free(tmp);
    }
    free(stack);
    stack = NULL;
}

- (void)push:(id)elem {
    if (stack->top == NULL) return ;
    
    Node *tmp = (Node *)malloc(sizeof(Node));
    tmp->data = (__bridge_retained void *)elem;     // retain 方式
    tmp->next = stack->top;         // 头部插入
    stack->top = tmp;
    stack->size++;
}

- (void)pop {
    if (stack->size <= 0) return ;
    
    Node *tmp = stack->top;
    stack->top = stack->top->next;
    if (tmp->data) {
        CFRelease(tmp->data);
    }
    free(tmp);
    stack->size--;
}

- (id)top {
    if (stack->size > 0) {
        return (__bridge id)stack->top->data;
    }
    return nil;
}

- (NSInteger)size {
    return stack->size;
}

- (BOOL)isEmpty {
    return stack->size > 0 ? false : true;
}

- (NSArray *)allObjects {    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    Node *cur = stack->top;
    while (cur->next) {
        [array addObject:(__bridge id)cur->data];
        cur = cur->next;
    }
    return array;
}

- (void)clear {
    while (stack->top && stack->top->next) {
        Node *tmp = stack->top;
        stack->top = stack->top->next;
        if (tmp->data) {
            CFRelease(tmp->data);
        }
        free(tmp);
    }
    stack->size = 0;
}

@end
