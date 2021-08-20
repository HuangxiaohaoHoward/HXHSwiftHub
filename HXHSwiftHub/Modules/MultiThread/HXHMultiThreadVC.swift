//
//  HXHMultiThreadVC.swift
//  HXHSwiftHub
//
//  Created by huangyu on 2021/8/14.
//

import UIKit

class HXHMultiThreadVC: HXHBaseViewController {
    var tickerCount: Int = 10
    var tmpCount: Int = 0
    @IBOutlet weak var multiRequest: UIButton!
    //MARK: - view life
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: - action
    //MARK: - 信号量拦截请求，过滤同求，设置最大同步数，都可以。
    @IBAction func multiRequestAction(_ sender: UIButton) {
        // 类似AFNetworking的获取task用法
        let sem = DispatchSemaphore(value: 0)
        for _ in 0..<10 {
            DispatchQueue.global().async { [weak self] in
                guard let self = self else { return }
                self.semphoreRequest {[weak self] in
                    guard let self = self else { return }
                    print("request \(self.tmpCount) done")
                    sem.signal()
                }
            }
            sem.wait()
        }
        print(" done ")
    }
    func semphoreRequest(completion:(()->Void)) {
        tmpCount += 1
        print("request \(self.tmpCount) request")
        completion()
    }
    //MARK: - 利用互斥锁卖票
    @IBAction func testSynchronized(_ sender: UIButton) {
        func saleTicket() {
            //这里为什么要lockself， 不lock self.ticketCount
            //只能给对象加。nil也会失效
            synchronized(lock: self) {
                if self.tickerCount > 0 {
                    self.tickerCount -= 1
                    print("还有余票 : \(self.tickerCount) 张")
                } else {
                    print("车票已售罄")
                }
            }
        }
        DispatchQueue.global().async {
            for _ in 0..<5 {
                saleTicket()
            }
        }
        DispatchQueue.global().async {
            for _ in 0..<4 {
                saleTicket()
            }
        }
        DispatchQueue.global().async {
            for _ in 0..<2 {
                saleTicket()
            }
        }
        DispatchQueue.global().async {
            for _ in 0..<6 {
                saleTicket()
            }
        }
    }
    
    
    //MARK: - util
    func synchronized(lock: Any, callback:(()-> Void)) {
        objc_sync_enter(lock)
        callback()
        objc_sync_exit(lock)
    }
}
