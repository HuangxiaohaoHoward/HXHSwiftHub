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
    
    var rootNode: BTNode?
    var size: Int = 0
    var isEmpty: Bool {
        size == 0
    }
    func add(val: Int) {
        // 步骤：找到父节点，创建子节点
        
        /*
         疑问：
         1. 相同值如何处理： 覆盖旧值，或者直接return，覆盖更合理
         2. compare方法的实现
        */
    }
    
    
    /// 前序遍历：根节点在前，先访问左子树。
    func preorderTraversal() {
        
        // 方法1： 递归，递归的缺点是会栈溢出
        preorderTraversal(rootNode)
    }
    func preorderTraversal(_ node: BTNode?) {
        if nil == node {
            return
        }
        print(node?.val)
        preorderTraversal(node?.left)
        preorderTraversal(node?.right)
    }
    
    func inorderTraversal() {
        
    }
    func postorderTraversal() {
        
    }
    func levelOrderTraversal() {
        
    }
    
}

class BTNode {
    var val: Int
    var left: BTNode?
    var right: BTNode?
    var parent: BTNode?
    init(val: Int, left: BTNode?, right: BTNode?, parent: BTNode?) {
        self.val = val
        self.left = left
        self.right = right
        self.parent = parent
        
    }
}
