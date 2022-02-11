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
    
    //MARK: - 第一个错误的版本
    /*
     你是产品经理，目前正在带领一个团队开发新的产品。不幸的是，你的产品的最新版本没有通过质量检测。由于每个版本都是基于之前的版本开发的，所以错误的版本之后的所有版本都是错的。
     
     假设你有 n 个版本 [1, 2, ..., n]，你想找出导致之后所有版本出错的第一个错误的版本。
     
     你可以通过调用 bool isBadVersion(version) 接口来判断版本号 version 是否在单元测试中出错。实现一个函数来查找第一个错误的版本。你应该尽量减少对调用 API 的次数。
     
      
     示例 1：
     
     输入：n = 5, bad = 4
     输出：4
     解释：
     调用 isBadVersion(3) -> false
     调用 isBadVersion(5) -> true
     调用 isBadVersion(4) -> true
     所以，4 是第一个错误的版本。
     示例 2：
     
     输入：n = 1, bad = 1
     输出：1
      
     
     提示：
     
     1 <= bad <= n <= 231 - 1
     */
    func isBadVersion(_ version: Int) -> Bool{
        version >= 4
    }
    /// 二分法的变形
    func firstBadVersion(_ n: Int) -> Int {
        var left = 1
        var right = n
        while left < right {
            let idx = left + (right-left)/2
            if isBadVersion(idx) {
                right = idx
            } else {
                left = idx + 1
            }
        }
        return left
    }
    
    //MARK: - 搜索插入位置
    /*
     给定一个排序数组和一个目标值，在数组中找到目标值，并返回其索引。如果目标值不存在于数组中，返回它将会被按顺序插入的位置。
     
     请必须使用时间复杂度为 O(log n) 的算法。
     
      
     
     示例 1:
     
     输入: nums = [1,3,5,6], target = 5
     输出: 2
     示例 2:
     
     输入: nums = [1,3,5,6], target = 2
     输出: 1
     示例 3:
     
     输入: nums = [1,3,5,6], target = 7
     输出: 4
     示例 4:
     
     输入: nums = [1,3,5,6], target = 0
     输出: 0
     示例 5:
     
     输入: nums = [1], target = 0
     输出: 0
      
     
     提示:
     
     1 <= nums.length <= 104
     -104 <= nums[i] <= 104
     nums 为无重复元素的升序排列数组
     -104 <= target <= 104
     */
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var left = 0
        var right = nums.count - 1
        while left <= right {
            let mid = left + (right-left)/2
            if target > nums[mid] {
                left = mid + 1
            } else if target < nums[mid] {
                right = mid - 1
            } else {
                return mid
            }
        }
        return right + 1
    }
    //MARK: - 977. 有序数组的平方
    /*
     https://leetcode-cn.com/problems/squares-of-a-sorted-array/
     
     问题
     
     给你一个按 非递减顺序 排序的整数数组 nums，返回 每个数字的平方 组成的新数组，要求也按 非递减顺序 排序。
     
     示例 1：
     
     输入：nums = [-4,-1,0,3,10]
     输出：[0,1,9,16,100]
     解释：平方后，数组变为 [16,1,0,9,100]
     排序后，数组变为 [0,1,9,16,100]
     示例 2：
     
     输入：nums = [-7,-3,2,3,11]
     输出：[4,9,9,49,121]
     提示：
     
     1 <= nums.length <= 104
     -104 <= nums[i] <= 104
     nums 已按 非递减顺序 排序
     
     进阶：
     
     请你设计时间复杂度为 O(n) 的算法解决本问题
     */
    
    func sortedSquares1(_ nums: [Int]) -> [Int] {
        /*
         尝试1
         思考：
         第一步 平方； 第二步 排序
         
         执行用时：**480 ms**, 在所有 Swift 提交中击败了 **5.37%** 的用户
         内存消耗：**15.3 MB**, 在所有 Swift 提交中击败了 **11.71%** 的用户
         */
        var result: [Int] = []
        for num in nums {
            let n = num * num
            print(n)
            if result.isEmpty {
                result.append(n)
            } else if result.count == 1 {
                if n >= result[0] {
                    result.append(n)
                } else {
                    result.insert(n, at: 0)
                }
            } else {
                for i in 0..<(result.count) {
                    if i == 0 {
                        if n <= result[0] {
                            result.insert(n, at: 0)
                            break
                        } else if n > result[0] && n < result[1] {
                            result.insert(n, at: 1)
                            break
                        }
                    } else if i == (result.count - 1) {
                        if n >= result[i] {
                            result.append(n)
                            break
                        } else if n < result[i] && n > result[i-1] {
                            result.insert(n, at: i)
                            break
                        }
                    } else {
                        let left = result[i]
                        let right = result[i+1]
                        if n >= left && n <= right {
                            result.insert(n, at: i+1)
                            break
                        }
                    }
                }
            }
        }
        
        return result
    }
    
    func sortedSquares2(_ nums: [Int]) -> [Int] {
        var result: [Int] = []
        var left = 0
        var right = nums.count - 1
        var k = nums.count - 1
        result = Array.init(repeating: -1, count: nums.count)
        
        while left <= right {
            let lefts = nums[left] * nums[left]
            let rights = nums[right] * nums[right]
            print("lefts : \(lefts), rights : \(rights)")
            print("k : \(k)")
            if lefts < rights {
                result[k] = rights
                right -= 1
                k -= 1
            } else if lefts > rights {
                result[k] = lefts
                left += 1
                k -= 1
            } else {
                result[k] = rights
                right -= 1
                k -= 1
            }
        }
        
        return result
        
    }
    
    //MARK: - 189. 轮转数组
    /*
     https://leetcode-cn.com/problems/rotate-array/
     
     问
     
     给你一个数组，将数组中的元素向右轮转 k 个位置，其中 k 是非负数。
     
     示例 1:
     
     输入: nums = [1,2,3,4,5,6,7], k = 3
     输出: [5,6,7,1,2,3,4]
     解释:
     向右轮转 1 步: [7,1,2,3,4,5,6]
     向右轮转 2 步: [6,7,1,2,3,4,5]
     向右轮转 3 步: [5,6,7,1,2,3,4]
     示例 2:
     
     输入：nums = [-1,-100,3,99], k = 2
     输出：[3,99,-1,-100]
     解释:
     向右轮转 1 步: [99,-1,-100,3]
     向右轮转 2 步: [3,99,-1,-100]
     提示：
     
     1 <= nums.length <= 105
     -231 <= nums[i] <= 231 - 1
     0 <= k <= 105
     
     进阶：
     
     尽可能想出更多的解决方案，至少有 三种 不同的方法可以解决这个问题。
     你可以使用空间复杂度为 O(1) 的原地算法解决这个问题吗？
     */
    func rotate(_ nums: inout [Int], _ k: Int) {
        // 自己的尝试
        if k == 0 {
            return
        }
        var result = Array.init(repeating: -1, count: nums.count)
        for (i, num) in nums.enumerated() {
            result[(k + i) % (nums.count)] = num
        }
        nums = result
        print(nums)
    }
    
    func rotate2(_ nums: inout [Int], _ k: Int) {
        // 题解都是3次翻转 ， 这个不容易想像，但如果画一下，还算比较容易明白。
        let x = k % nums.count
        reverse(nums: &nums, left: 0, right: nums.count-1)
        print(1)
        print(nums)
        reverse(nums: &nums, left: 0, right: x-1)
        print(2)
        print(nums)
        reverse(nums: &nums, left: x, right: nums.count-1)
        print(3)
        print(nums)
    }

    func reverse(nums: inout [Int], left: Int, right: Int) {
        
        var _left = left
        var _right = right
        while _left < _right {
            let tmp = nums[_right]
            nums[_right] = nums[_left]
            nums[_left] = tmp
            _left += 1
            _right -= 1
        }
        
    }
    
    //MARK: - 283. 移动零
    /*
     给定一个数组 nums，编写一个函数将所有 0 移动到数组的末尾，同时保持非零元素的相对顺序。

     请注意 ，必须在不复制数组的情况下原地对数组进行操作。

      

     示例 1:

     输入: nums = [0,1,0,3,12]
     输出: [1,3,12,0,0]
     示例 2:

     输入: nums = [0]
     输出: [0]
      

     提示:

     1 <= nums.length <= 104
     -231 <= nums[i] <= 231 - 1
      

     进阶：你能尽量减少完成的操作次数吗？

     */
    // 两次都是看答案才写出来。说明对双指针不够熟练
    func moveZeroes(_ nums: inout [Int]) {
        var lastIndex: Int = 0
        for i in 0..<nums.count {
            if nums[i] != 0 {
                nums[lastIndex] = nums[i]
                lastIndex += 1
            }
        }
        while lastIndex < nums.count {
            nums[lastIndex] = 0
            lastIndex += 1
        }
        print(nums)
    }
    func moveZeroes2(_ nums: inout [Int]) {
        var lastIndex: Int = 0
        for i in 0..<nums.count {
            if nums[i] != 0 {
                nums[lastIndex] = nums[i]
                if i != lastIndex {
                    nums[i] = 0
                }
                lastIndex += 1
            }
        }
        print(nums)
    }
    
    
    
}
