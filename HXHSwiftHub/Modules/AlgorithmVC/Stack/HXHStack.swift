//
//  HXHStack.swift
//  HXHSwiftHub
//
//  Created by 黄小豪 on 2022/1/17.
//

import Foundation

//栈  Stack
/*
 线性表
 后进先出
 和内存的栈的概念不同
 */


/*
 栈可以包含的方法
 size: Int
 isEmpty: Bool
 push 入栈
 pop 出栈
 top 获取栈顶元素
 */

/*
 可以用数组和链表实现
 */

//MARK: - 数据结构定义
class HXHStack {
    private var list: [Character]
    var size: Int {
      return  list.count
    }
    var isEmpty: Bool {
        return size == 0
    }
    func push(element: Character) {
        list.append(element)
    }
    func pop() {
        list.removeLast()
    }
    var top: Character? {
        list.last
    }
    func clear() {
        list.removeAll()
    }
    init() {
        list = []
    }
}

//MARK: - 栈的应用

//1.浏览器的前进和后退.  类似的场景还有撤销，回复等。是一样的原理


/*
 2. 有效的括号
 给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串 s ，判断字符串是否有效。

 有效字符串需满足：

 左括号必须用相同类型的右括号闭合。
 左括号必须以正确的顺序闭合。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/valid-parentheses
*/

func validParentheses(s: String) -> Bool {
    
    var leftStack: HXHStack = HXHStack.init()
    let _map:[Character:Character] = ["(":")",
                               "[":"]",
                               "{":"}"]
    for c in s {
        if _map.keys.contains(c) {
            leftStack.push(element: c)
        } else {
            if let top = leftStack.top,
               _map[top] == c {
                print(leftStack.pop())
            } else {
                return false
            }
        }
    }
    
    print(leftStack.size)
    return leftStack.isEmpty
}
