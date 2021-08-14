//
//  HXHMultiThreadVC.swift
//  HXHSwiftHub
//
//  Created by huangyu on 2021/8/14.
//

import UIKit

class HXHMultiThreadVC: HXHBaseViewController {
    var tmpCount: Int = 0
    @IBOutlet weak var multiRequest: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK: - action
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
}
