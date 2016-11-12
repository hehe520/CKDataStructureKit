//
//  CKPriorityQueue.m
//  CKDataStructureKit
//
//  Created by caokun on 16/11/8.
//  Copyright © 2016年 caokun. All rights reserved.
//

#import "CKPriorityQueue.h"

#define INITSIZE 100    // 初始大小
#define INCSIZE  100    // 增量大小

typedef struct {        // 2-d堆结构
    void **base;        // 基址
    int lenth;			// 使用量
    int size;			// 总容量
} Heap;


@interface CKPriorityQueue ()

@property (strong, nonatomic) CompareBlock cmp;

@end

@implementation CKPriorityQueue

Heap *heap;     // 二叉堆

- (instancetype)initWithCompareBlock:(CompareBlock)cmp {
    if (self = [super init]) {
        self.cmp = cmp;
        initHeap();
    }
    return self;
}

- (void)dealloc {
    destoryHeap();
}

void initHeap() {
    heap = (Heap *)malloc(sizeof(Heap));
    if (heap) {
        // base[0] 不放元素，0 不方便计算，堆顶是 1 号元素
        heap->base = (void **)malloc(INITSIZE * sizeof(void *));
        heap->lenth = 0;
        heap->size = INITSIZE;
    } else {
        heap = NULL;
    }
}

void destoryHeap() {
    if (heap) {
        for (int i=1; i<=heap->lenth; i++) {
            CFRelease(heap->base[i]);
        }
        free(heap);
    }
}

- (NSInteger)length {
    if (heap) {
        return heap->lenth;
    }
    return 0;
}

- (void)push:(id)elem {
    if (heap->lenth + 1 >= heap->size) {        // 满了，扩容
        void **tmp = (void **)realloc(heap->base, (heap->size + INCSIZE) * sizeof(void *));
        if (tmp) {
            heap->base = tmp;
            heap->size += INCSIZE;
        } else {
            return ;
        }
    }
    heap->lenth++;
    heap->base[heap->lenth] = (__bridge_retained void *)elem;
    [self upNode:heap index:heap->lenth];
}

// 上调一个节点
- (void)upNode:(Heap *)h index:(int)index {
    if (self.cmp == nil) return ;
    if (index > h->lenth || index <= 0) return ;
    
    void *node = h->base[index];        // 待上调节点
    while (index > 1 && self.cmp((__bridge id)(h->base[index / 2]), (__bridge id)node)) {
        h->base[index] = h->base[index / 2];        // 下沉
        index /= 2;
    }
    h->base[index] = node;      // 放 node
}

// 下调一个节点
- (void)downNode:(Heap *)h index:(int)index {
    if (self.cmp == nil) return ;
    if (index > h->lenth || index <= 0) return ;
    
    int len = h->lenth;
    int lc, rc;                     // 左右孩子
    void *node = h->base[index];    // 待下调节点
    
    while (true) {
        lc = 2 * index;
        rc = 2 * index + 1;
        
        if (lc > len) {     // 没左孩子
            break ;

        } else {
            if (rc > len) {     // 没右孩子
                if (self.cmp((__bridge id)node, (__bridge id)h->base[lc])) {
                    h->base[index] = h->base[lc];
                    index = lc;
                } else {
                    break;
                }
            } else {    // 左右都有
                id left = (__bridge id)h->base[lc];
                id right = (__bridge id)h->base[rc];
                id cur = (__bridge id)node;
                
                // 比较左右，选一个小的上调
                if (self.cmp(right, left)) {
                    if (self.cmp(cur, left)) {
                        h->base[index] = h->base[lc];
                        index = lc;
                    } else {
                        break;
                    }
                } else {
                    if (self.cmp(cur, right)) {
                        h->base[index] = h->base[rc];
                        index = rc;
                    } else {
                        break;
                    }
                }
            }
        }
    }
    h->base[index] = node;
}

- (void)pop {
    [self removeNode:heap index:1];
    [self tryReduceSize:heap];
}

- (void)tryReduceSize:(Heap *)h {
    if (h->lenth + INCSIZE < h->size) {
        void **tmp = (void **)realloc(heap->base, (heap->size - INCSIZE) * sizeof(void *));
        if (tmp) {
            heap->base = tmp;
            heap->size -= INCSIZE;
        } else {
            return ;
        }
    }
}

// 删除一个节点
- (void)removeNode:(Heap *)h index:(int)index {
    if (index > 0 && index <= h->lenth) {
        h->base[index] = h->base[h->lenth];
        [self downNode:h index:index];
        h->lenth--;
    }
}

- (id)top {
    if (heap->lenth <= 0) { return nil; }
    
    return (__bridge id)heap->base[1];
}

- (BOOL)isEmpty {
    return heap->lenth == 0 ? true :false;
}

- (void)clear {
    for (int i=1; i<=heap->lenth; i++) {
        CFRelease(heap->base[i]);
    }
    void **tmp = (void **)realloc(heap->base, INITSIZE * sizeof(void *));
    if (tmp) {
        heap->base = tmp;
        heap->size = INITSIZE;
        heap->lenth = 0;
    } else {
        heap->lenth = 0;
    }
}

- (void)pushWithArray:(NSArray *)array {
    if (array) {
        for (id obj in array) {
            [self push:obj];
        }
    }
}

- (NSArray *)allObjects {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    while (![self isEmpty]) {
        NSNumber *b = [self top];
        [self pop];
        [array addObject:b];
    }
    return array;
}

@end
