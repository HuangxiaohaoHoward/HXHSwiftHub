//
//  HXHRuntimeTest.m
//  HXHSwiftHub
//
//  Created by 黄小豪 on 2022/2/2.
//

#import "HXHRuntimeTest.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>

@implementation HXHRuntimeTest

- (void)test {
    // class_getInstanceSize方法可以获取实例对象的成员变量大小，即创建一个实例对象，至少需要多少内存。malloc_size方法可以获取对象指针所指向内存大小，即创建一个实例对象，实际上分配了多少内存。两个方法的区别具体可以看runtime底层源码观察其区别。

    NSObject *obj = [[NSObject alloc] init];
    // 8
    NSLog(@"%zd", class_getInstanceSize([NSObject class]));
    // 16
    NSLog(@"%zd", malloc_size((__bridge const void *)(obj)));
}
@end
