//
//  HXHSet.swift
//  HXHSwiftHub
//
//  Created by 黄小豪 on 2022/2/3.
//

import Foundation
import UIKit

/*
 集合 （set）
 基础概念

 元素不重复
 可以用数组/链表或者二叉树实现，这就代表，可以是线性表也可以不是。
 链表与二叉树实现的区别

 1. 复杂度

 链表的搜索、删除、添加: O(n) 二叉树搜索是: O(n) 其余优于链表

 2. treeSet(树实现集合)的局限

 必须具备可比较性，所以最好传入一个 comparator 比较器。

 如果不用比较可以使用哈希表。
 */

class HXHSet {
    func add(e: Int) {
        //存在就覆盖，不存在就新增
        // swift用的名词是insert
        
    }
}


class HXHSetPractice {
    //MARK: - 练习 1. 两个数组的交集
    ///  解法1
    func intersectionOfTwoArray(arr1: [Int], arr2: [Int]) -> [Int]{
        var set: Set<Int> = Set(minimumCapacity: 0)
        var set2: Set<Int> = Set(minimumCapacity: 0)
        var intersection: Set<Int> = Set(minimumCapacity: 0)
        for a1 in arr1 {
            _ = set.insert(a1)
        }
        for a2 in arr2 {
            _ = set2.insert(a2)
        }
        for a3 in set {
            let result = set2.insert(a3)
            if result.inserted == false {
                intersection.insert(a3)
            }
        }
        return  Array(intersection)
    }
    
}

