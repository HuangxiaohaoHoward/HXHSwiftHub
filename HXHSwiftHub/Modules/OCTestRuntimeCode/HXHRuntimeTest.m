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
    HXHPerson *per  = [[HXHPerson alloc] init];
    per->_no = 3;
    per->_age = 6;
    
    HXHStudent *stu  = [[HXHStudent alloc] init];
    stu->_no = 2;
    stu->_age = 8;
    stu->_sex = 1;
    [stu test];
    
    NSLog(@"per : %zu", malloc_size((__bridge const void *)(per)));
    NSLog(@"stu : %zu", malloc_size((__bridge const void *)(stu)));
    struct HXHStudent_IMPL *stuImpl = (__bridge struct HXHStudent_IMPL *)stu;
    NSLog(@"\n--- _no: %d ---, --- _age : %d ---,  _sex : %d", stuImpl->_no, stuImpl->_age, stuImpl->_sex);
}
@end

@implementation HXHPerson


@end

@implementation HXHStudent

- (void)test {
    NSLog(@"\n---- %@ ----\n---- %s ----\n", NSStringFromClass(self.class), __func__);
    HXHStudent *std = [[HXHStudent alloc] init];
    // 8
    NSLog(@"\n---- %zd ----", class_getInstanceSize([HXHStudent class]));
    // 16
    NSLog(@"\n---- %zd ----", malloc_size((__bridge const void *)(std)));
}

@end
