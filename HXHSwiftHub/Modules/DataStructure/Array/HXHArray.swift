//
//  HXHArray.swift
//  HXHSwiftHub
//
//  Created by 黄小豪 on 2021/11/3.
//

import Foundation
/*
 数组的优化
 
 */
/*
 let array = [1, 2, 3]栈空间的array变量指向堆空间的数组元素
 
 很多语言中的数组有个缺点：无法动态修改容量
 */
class HXHArray {
    private var size: UInt
    public var count: Int = 0
    private var elements: [Int]
    public init(capacity: UInt) {
        size = capacity
        elements = []
    }
    public func insert(index: Int, element: Int) {
        guard index >= 0,
              index <= count else {
                  return
              }
        for i in 0..<count-index {
            
        }
    }
    public func add(element: Int) {
        elements[count] = element
        count += 1
    }
    /// get element with index
    public func get(index: UInt) {
        guard index < size else {
            return
        }
        elements
    }
    func jsonPrint() -> String {
        guard JSONSerialization.isValidJSONObject(self),
              let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted),
              let string = String(data: data, encoding: .utf8) else {
                  return ""
              }
        return string
    }
}
