//
//  ListNode.swift
//  HXHSwiftHub
//
//  Created by 黄小豪 on 2021/12/27.
//

import Foundation
class ListNode {
    var val: Int
    var next: ListNode?
    init(val: Int, next: ListNode?=nil) {
        self.val = val
        self.next = next
    }
}

//MARK: - algorithm
class ListNodeAlgorithm {

    /// 给定单链表的头节点 head ，请反转链表，并返回反转后的链表的头节点。
    func reverseList(head: ListNode?) -> ListNode? {
        
        if head == nil || head?.next == nil {
            return head
        }
        let newHead = reverseList(head: head?.next)
        head?.next?.next = head
        head?.next = nil
        return newHead
    }
}
