//
//  HXHRuntimeTest.h
//  HXHSwiftHub
//
//  Created by 黄小豪 on 2022/2/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HXHRuntimeTest : NSObject

- (void)test;

@end

@interface HXHPerson : NSObject
{
    @public
    int _no;
    int _age;
//    int _age2;
//    int _age3;
//    int _age4;
//    int _age5;
}


@end

struct HXHStudent_IMPL {
    Class isa;
    int _no;
    int _age;
    int _sex;
};

@interface HXHStudent : HXHPerson
{
    @public
    int _sex;
}

- (void)test;

@end


NS_ASSUME_NONNULL_END
