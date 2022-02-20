//
//  Algorithm+Sort.swift
//  HXHSwiftHub
//
//  Created by 黄小豪 on 2022/2/20.
//

import Foundation

extension Algorithm {
    /*
     350. 两个数组的交集 II
     
     给你两个整数数组 nums1 和 nums2 ，请你以数组形式返回两数组的交集。返回结果中每个元素出现的次数，应与元素在两个数组中都出现的次数一致（如果出现次数不一致，则考虑取较小值）。可以不考虑输出结果的顺序。

      

     示例 1：

     输入：nums1 = [1,2,2,1], nums2 = [2,2]
     输出：[2,2]
     示例 2:

     输入：nums1 = [4,9,5], nums2 = [9,4,9,8,4]
     输出：[4,9]
      

     提示：

     1 <= nums1.length, nums2.length <= 1000
     0 <= nums1[i], nums2[i] <= 1000
      

     进阶：

     如果给定的数组已经排好序呢？你将如何优化你的算法？
     如果 nums1 的大小比 nums2 小，哪种方法更优？
     如果 nums2 的元素存储在磁盘上，内存是有限的，并且你不能一次加载所有的元素到内存中，你该怎么办？
     */
    
    
    /// 方法 一 速度快，但是占用内存多，双指针思想
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        // 先排序
        let n1 = nums1.sorted()
        let n2 = nums2.sorted()
        
        var n1i = 0
        var n2i = 0
        // 之后移动指针到不可以 继续右移
        var result = [Int]()
        while n1i < n1.count && n2i < n2.count {
            let n1Val = n1[n1i]
            let n2Val = n2[n2i]
            if n1Val == n2Val {
                result.append(n1Val)
                n1i += 1
                n2i += 1
            } else if n1Val > n2Val {
                n2i += 1
            } else if n1Val < n2Val {
                n1i += 1
            }
        }
        return result
    }
    
    /// 方法 2 ： 用map存下第一个num的值及其出现次数，第二个nums遍历时根据出现次数生成结果
    func intersect2(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        guard !nums1.isEmpty && !nums2.isEmpty else{
            return []
        }
        var hs = [Int: Int](), res = [Int]()
        for num in nums1 {
            hs[num, default: 0] += 1
        }
        for num in nums2 {
            if let record = hs[num],
               record > 0 {
                res.append(num)
                hs[num] = record - 1
            }
        }
        return res
    }
    
}
