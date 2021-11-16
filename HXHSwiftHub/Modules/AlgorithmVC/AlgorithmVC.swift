//
//  AlgorithmVC.swift
//  RxSwiftDemo
//
//  Created by huangyu on 2021/7/15.
//  Copyright © 2021 huangyu. All rights reserved.
//

import UIKit

class AlgorithmVC: HXHBaseViewController {
    let manager = Algorithm()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - action
    
    @IBAction func twoNumSum(_ sender: UIButton) {
        let nums = [2,3,4,6,0,8,11]
        let target = 10
        print(manager.twoSum(nums: nums, target: target))
    }
    @IBAction func binarySearch(_ sender: UIButton) {
        print(manager.binarySearch(x: 12))
    }
    @IBAction func twoThreadPrintABInOrder() {
        twoThreadPrintABInOrderBySemaphore()
    }
    func twoThreadPrintABInOrderBySemaphore() {
        print(#function)
        var n = 0
        let q1 = DispatchQueue(label: "q1")
        let q2 = DispatchQueue(label: "q2")
        let semaphore1 = DispatchSemaphore(value: 1)
        let semaphore2 = DispatchSemaphore(value: 0)
        DispatchQueue.global().async {
            q1.async {
                while n < 100 {
                    //打印奇数
                    semaphore1.wait()
                    print("q1 : n : \(n) thread: \(Thread.current)")
                    n += 1
                    semaphore2.signal()
                }
                semaphore1.signal()
                semaphore2.signal()
            }
            q2.async {
                while n < 100 {
                    //打印偶数
                    semaphore2.wait()
                    print("q2 : n : \(n); thread: \(Thread.current)")
                    n += 1
                    semaphore1.signal()
                }
                semaphore1.signal()
                semaphore2.signal()
            }
        }// globle queue
        
    }
}

