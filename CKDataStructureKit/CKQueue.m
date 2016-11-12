//
//  CKQueue.m
//  CKDataStructureKit
//
//  Created by caokun on 16/11/7.
//  Copyright © 2016年 caokun. All rights reserved.
//

#import "CKQueue.h"

typedef struct Node {       // 节点结构
    void *data;
    struct Node *next;
} Node;

// 队列结构 [front 出队] -> [] -> [] -> [rear 入队]
typedef struct Queue {      // 队列结构
    Node *front;
    Node *rear;
    int lenth;
} Queue;

@implementation CKQueue {
    Queue *queue;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initQueue];
    }
    return self;
}

- (void)dealloc {
    [self destoryQueue];
}

- (void)initQueue {
    queue = (Queue *)malloc(sizeof(Queue));
    if (queue) {
        queue->lenth = 0;
        queue->front = NULL;
        queue->rear = NULL;
    } else {
        queue = NULL;
    }
}

- (void)destoryQueue {
    while (queue->front) {
        Node *tmp = queue->front;
        queue->front = queue->front->next;
        if (tmp->data) {
            CFRelease(tmp->data);
        }
        free(tmp);
    }
    free(queue);
    queue = NULL;
}

- (void)push:(id)elem {
    Node *node = (Node *)malloc(sizeof(Node));
    node->data = (__bridge_retained void *)elem;
    node->next = NULL;
    
    if (queue->rear) {
        queue->rear->next = node;
        queue->rear = node;
    } else {
        queue->rear = node;
        queue->front = node;
    }
    queue->lenth += 1;
}

- (void)pop {
    if (queue->lenth > 0) {
        Node *tmp = queue->front;
        queue->front = queue->front->next;
        if (tmp->data) {
            CFRelease(tmp->data);
        }
        free(tmp);
        
        queue->lenth -= 1;
    }
}

- (id)front {
    if (queue->lenth > 0) {
        return (__bridge id)queue->front->data;
    }
    return nil;
}

- (id)rear {
    if (queue->lenth > 0) {
        return (__bridge id)queue->rear->data;
    }
    return nil;
}

- (NSInteger)length {
    if (queue) {
        return queue->lenth;
    }
    return 0;
}

- (BOOL)isEmpty {
    if (queue->lenth > 0) {
        return false;
    }
    return true;
}

- (void)clear {
    while (queue->front != NULL) {
        Node *tmp = queue->front;
        queue->front = queue->front->next;
        if (tmp->data) {
            CFRelease(tmp->data);
        }
        free(tmp);
    }
    queue->front = NULL;
    queue->rear = NULL;
    queue->lenth = 0;
}

- (NSArray *)allObjects {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    Node *cur = queue->front;
    while (cur) {
        [array addObject:(__bridge id)cur->data];
        cur = cur->next;
    }
    return array;
}

@end
