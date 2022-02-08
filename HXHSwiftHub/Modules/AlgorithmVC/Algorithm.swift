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
    //MARK: - 二分查找
    /*
     给定一个 n 个元素有序的（升序）整型数组 nums 和一个目标值 target  ，写一个函数搜索 nums 中的 target，如果目标值存在返回下标，否则返回 -1。

     示例 1:

     输入: nums = [-1,0,3,5,9,12], target = 9
     输出: 4
     解释: 9 出现在 nums 中并且下标为 4
     示例 2:

     输入: nums = [-1,0,3,5,9,12], target = 2
     输出: -1
     解释: 2 不存在 nums 中因此返回 -1
      

     提示：

     你可以假设 nums 中的所有元素是不重复的。
     n 将在 [1, 10000]之间。
     nums 的每个元素都将在 [-9999, 9999]之间。

     */
    func binarySearch(_ nums: [Int], _ target: Int) -> Int {
        var start = 0
        var end = nums.count - 1
        while start <= end {
            let idx = (end - start ) / 2 + start
            if target == nums[idx] {
                return idx
            } else if target > nums[idx] {
                start = idx + 1
            } else if target < nums[idx] {
                end = idx - 1
            }
        }
        return -1
    }
    
    /// 二分法搜索 - 是否包含 （没啥用，只能返回是否包含，而且递归会引起栈溢出）
    func binarySearch(x: Int=3, nums: [Int]=[-1,0,3,5,9,12]) -> Bool {
        var result = false
        let min: Int = nums.startIndex
        let max: Int = nums.endIndex
        if max < min {
            return false
        }
        let mid: Int = (min + max)/2
        let value = nums[mid]
        if x == value {
            return true
        }
        if x < value {
            let tmpNums = min < mid ? Array(nums[min..<mid]) : Array<Int>()
            result = self.binarySearch(x: x, nums: tmpNums)
        }
        if x > value {
            let tmpNums = max > mid ? Array(nums[mid..<max]) : Array<Int>()
            result = self.binarySearch(x: x, nums: tmpNums)
        }
        return result
    }
    
    
    /*
     已知一个整数数组 nums 和一个整数 target，取数组中任意两个值相加的和等 整数 target，返回这两个值在数组中的索引。
     假设：
     只有一个有效答案
     同一个值不能重复取两次
     可以按任意顺序返回答案
     
     示例 1
     输入：nums = [2,7,11,15]，target = 9
     输出：[0,1]
     解释：因为 nums[0] + nums[1] == 9，所以返回 [0, 1]
     示例 2
     输入：nums = [3,2,4]，target = 6
     输出：[1,2]
     示例 3
     输入：nums = [3,3]，target = 6
     输出： [0,1]
     */
    func twoSum(nums: [Int], target: Int) -> [(Int, Int)] {
        var dict = [Int:Int]()
        var result = [(Int, Int)]()
        for (idx, num) in nums.enumerated() {
            if let lastIdx = dict[target - num] {
                result.append((lastIdx, idx))
            }
            dict[num] = idx
        }
        return result
    }
//MARK: - 盛最多水的容器
    /*
    盛最多水的容器
    
    分解：
    index的差和第二大的value的乘积最大
    */
    /// 基础的暴力解法，会时间复杂度太差
    func maxArea(nums: [Int])-> Int {
        var area: Int = 0
        for i in 0..<nums.count {
            for j in i..<nums.count {
                let x = j - i
                let y = min(nums[i], nums[j])
                let tmpArea = x * y
                if tmpArea > area {
                    area = tmpArea
                    print("------ i : \(i) ; j : \(j) ; area : \(area)  ------")

                }
            }
        }
        return area
    }


    /// 从最长的x轴开始计算。
    func maxArea2(_ height: [Int]) -> Int {
        var area: Int = 0
        var left: Int = 0
        var right: Int = height.count - 1
        while left < right {
            let tmpHeight = min(height[left], height[right])
            area = max(area, tmpHeight * (right - left))
            
            if tmpHeight == height[left] {
                left += 1
            } else {
                right -= 1
            }
            print("--- left: \(left), right : \(right) ---")
        }
        return area
    }
}
