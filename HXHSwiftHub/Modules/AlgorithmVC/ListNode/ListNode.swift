//
//  ListNode.swift
//  HXHSwiftHub
//
//  Created by 黄小豪 on 2021/12/27.
//

import Foundation


/// 单向链表

class ListNode: Equatable {
    static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        return (lhs.val == rhs.val) && (lhs.next == rhs.next)
    }
    
    var val: Int
    var next: ListNode?
    public init() {
        self.val = 0;
        self.next = nil;
    }
    public init(_ val: Int) {
        self.val = val;
        self.next = nil;
    }
    public init(_ val: Int, _ next: ListNode?) {
        self.val = val;
        self.next = next;
    }
}

/// 双向链表
class DoubleListNode {

    var val: Int
    var next: ListNode?
    var prev: ListNode?
    init(val: Int, next: ListNode?=nil, prev: ListNode?=nil) {
        self.val = val
        self.next = next
        self.prev = prev
    }
}
//MARK: - algorithm
class ListNodeAlgorithm {

    //MARK: - 给定单链表的头节点 head ，请反转链表，并返回反转后的链表的头节点。
    /// 递归翻转单链表
    func reverseList(head: ListNode?) -> ListNode? {
        
        if head == nil || head?.next == nil {
            return head
        }
        let newHead = reverseList(head: head?.next)
        head?.next?.next = head
        head?.next = nil
        return newHead
    }
    ///非递归
    func reverseList2(head: ListNode?) -> ListNode? {
        
        if head == nil || head?.next == nil {
            return head
        }
        
        var newHead: ListNode? = nil
        var oldHead = head
        while oldHead != nil {
            let tmpNode = oldHead?.next  // 取出原链表的下次循环的头
            oldHead?.next = newHead  // 将新的头加到新链表上
            newHead = oldHead  // 将新的头赋值给newHead
            oldHead = tmpNode  // 将下次循环的头赋值给oldHead
        }
        return newHead
    }
    /// 非递归- 双指针思想 和2的区别在哪？
    func reverseList3(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        var pre: ListNode? = nil
        var cur: ListNode? = head
        var temp: ListNode? = nil
        while cur != nil {
            temp = cur?.next
            cur?.next = pre
            pre = cur
            cur = temp
        }
        return pre
    }

    //MARK: - 判断一个链表是否有环
    /*
     https://leetcode-cn.com/problems/linked-list-cycle/
     */
    /// 快慢指针法, 复杂度O(n)
    func hasCycle(_ head: ListNode?) -> Bool {
        if head == nil || head?.next == nil {
            return false
        }
        var slow = head
        var fast = head?.next
        while (fast != nil && fast?.next != nil) {
            if slow === fast {
                return true
            }
            slow = slow?.next
            fast = fast?.next?.next
        }
        return false
    }
    /// 快慢指针写法2, 复杂度O(n)
    func hasCycle2(_ head: ListNode?) -> Bool {
        var slow = head
        var fast = head
        
        while (fast != nil && fast?.next != nil) {
            slow = slow?.next
            fast = fast?.next?.next
            if slow === fast {
                return true
            }
        }
        return false
    }
    
}
