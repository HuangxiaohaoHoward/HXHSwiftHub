//
//  Algorithm.swift
//  RxSwiftDemo
//
//  Created by huangyu on 2021/7/15.
//  Copyright © 2021 huangyu. All rights reserved.
//

import UIKit

class Algorithm: NSObject {
    
    func twoThreadPrintABInOrder() {
        
    }
    /// 这个写法可以实现，但是会很麻烦，应该用下标控制，
    /// 返回下标，错误为-1. return subscript， error num is -1。
//    func binarySearch()-> Int {
//        var nums: [Int] = [-1,0,3,5,9,12]
//        var result: Int = -1
//        let target = 0
//        let middleNum = nums.count/2
//        let middle = nums[middleNum]
//        if target == middle {
//            return nums.firstIndex(of: target) ?? -1
//        }
//        if target < middle {
//
//        }
//        return result
//    }
    func binarySearch(nums: [Int]=[-1,0,3,5,9,12]) -> Bool {
        var result = false
        
        
        return result
    }
    /// 二分查找：判断有序的数组里面是否包含某一个数字
//    func binarySearch(x: Int) -> Bool {
//        var result = false
//        let min = self.startIndex
//        let max = self.endIndex - 1
//
//        if min > max {
//            return false
//        }
//
//        let mid = Int((min + max)/2)
//        let value = self[mid]
//
//        if x == value {
//            return true
//        }
//
//        if x < value {
//            let array = min < mid ? Array(self[min..<mid]) : Array<Int>()
//            result = array.binarySearch(x: x)
//        }
//
//        if x > value {
//            let array = max > mid ? Array(self[mid..<max]) : Array<Int>()
//            result = array.binarySearch(x: x)
//        }
//        return result
//    }
}
