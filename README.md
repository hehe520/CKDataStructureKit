# CKDataStructureKit


用 oc 封装了栈，队列，优先队列


使用方法在 ViewController.m 中


优先队列的使用

```
self.priQueue = [[CKPriorityQueue alloc] initWithCompareBlock:^BOOL(id obj1, id obj2) {
    int b1 = [(NSNumber *)obj1 intValue];
    int b2 = [(NSNumber *)obj2 intValue];
    return b1 > b2 ? true : false;          // b1 > b2 返回 true 表示升序
}];

for (int i=0; i<10; i++) {
    int x = arc4random() % 100;
    [self.priQueue push:@(x)];    // 加入单个对象
}

[self.priQueue pushWithArray:@[@(2), @(1), @(3)]];  // 加入数组

NSNumber *c;
while (![self.priQueue isEmpty]) {
    c = [self.priQueue top];    // 队头
    NSLog(@"pop = %@", c);
    [self.priQueue pop];      // 出队
}
```


三个容器的实现文件分别是，可以单独拖到其他项目使用


CKStack.h
CKStack.m



CKQueue.h
CKQueue.m



CKPriorityQueue.h
CKPriorityQueue.m



如果您发现程序有问题，欢迎反馈，谢谢，我的QQ:657668857，或者邮箱657668857@qq.com
