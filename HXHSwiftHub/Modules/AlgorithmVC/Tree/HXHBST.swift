//
//  HXHBST.swift
//  HXHSwiftHub
//
//  Created by 黄小豪 on 2022/1/23.
//

import Foundation

/*
 
 二叉搜索树 Binary Search Tree 简称BST
 特性：如果左子树不为空则左子树上所有的节点均不大于他的根节点的值，右子树不为空则右子树上所有节点均小于他的根节点的值
 
 var size
 var isEmpty
 func clear
 func add
 func remove
 func contain
 
 没有像数组那样的索引因为不适合，不准确
 
 var rootNode 需要根节点属性
*/

class HXBinarySearchTree {
    
    var size: Int = 0
    var isEmpty: Bool {
        size == 0
    }
    func add(val: Int) {
        // 步骤：找到父节点，创建子节点
        
        /*
         疑问：
         1. 相同值如何处理： 覆盖旧值，或者直接return
         2. compare方法的实现
        */
    }
    
    class Node {
        var val: Int
        var left: Node?
        var right: Node?
        var parent: Node?
        init(val: Int, left: Node?, right: Node?, parent: Node?) {
            self.val = val
            self.left = left
            self.right = right
            self.parent = parent
            
        }
    }
    
}

