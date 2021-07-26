//
//  AlgorithmVC.swift
//  RxSwiftDemo
//
//  Created by huangyu on 2021/7/15.
//  Copyright © 2021 huangyu. All rights reserved.
//

import UIKit

class AlgorithmVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
