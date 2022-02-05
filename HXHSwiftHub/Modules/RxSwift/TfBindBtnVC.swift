//
//  TfBindBtnVC.swift
//  RxSwiftDemo
//
//  Created by huangyu on 2021/7/14.
//  Copyright © 2021 huangyu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TfBindBtnVC: HXHBaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var dispose = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseUI()
        setupRxSwiftTestCode()
    }
    func setupRxSwiftTestCode() {
//        functionStyle()
//        kvoTest()
        bindTfAndLabel()
//        setupRxTimer()
//        setupNetwork()
        observableTrilogy()
    }
    func setupBaseUI() {
        title = "RxSwift Demo List"
        scrollView.rx.contentOffset
            .subscribe(onNext: { offset in
                print(offset)
            })
            .disposed(by: dispose)
    }
    
    @IBAction func gotoSearchTFVC(_ sender: Any) {
        let vc = RxSwiftSearchVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - test code

    @IBOutlet weak var tf: UITextField!
    
    @IBOutlet weak var bindTfLabel: UILabel!
    
    func bindTfAndLabel() {
        
        tf.rx.text.orEmpty
            .subscribe(onNext: { text in
                print(text)
            })
            .disposed(by: dispose)
        
        tf.rx.text
            .bind(to: bindTfLabel.rx.text)
            .disposed(by: dispose)
        
    }
    
    @IBAction func kvoTestBtnAction(_ sender: UIButton) {
        kvoStr += " - touch - "
    }
    
    /// 不写上 @objc dynamic 无法监听
    @objc dynamic var kvoStr: String = "kvoStr"
    func kvoTest() {
        let observe = self.rx.observeWeakly(String.self, "kvoStr")
        
        observe.subscribe(onNext: { (val) in
            print(val)
        }, onError: { error in
            print("error : \(error)")
        }, onCompleted: {
            print("onCompleted")
        }, onDisposed: {
            print("onDisposed")
        })
            .disposed(by: dispose)
        
    }
    func functionStyle() {
        print(#function)
        /*
         函数式 ： y = f(x) -> x = f(x) -> y = f(f(x))
         */
        
        let array = [1,2,3,4,5,6,7]
        
        // 大于3的数字
        // 获取之后 + 1
        // 输出偶数
        array.filter { $0 > 3 }
        .filter { ($0+1) % 2 == 0 }
        .forEach { i in
            print(i)
        }
        
    }
    
}

extension TfBindBtnVC {
    func setupNetwork() {
        guard let url = URL(string: "https://www.baidu.com") else {
            print("url init failure")
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, resp, error in
            print("---\ndata : \(String(describing: String(data: data ?? Data(), encoding: .utf8))), \n---\nresp: \(String(describing: resp)), \n---\nerror: \(String(describing: error))")
        }
        dataTask.resume()
        
        // 下边为 rxSwift的实现
        
        URLSession.shared.rx.response(request: URLRequest(url: url))
            .subscribe(onNext: { (resp, data) in
                print("rx 的 返回")
                print("---\ndata : \(String(describing: String(data: data , encoding: .utf8))), \n---\nresp: \(String(describing: resp)), \n---")
            })
            .disposed(by: dispose)
    }
    func setupRxTimer() {
        let timer = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler())
        timer.subscribe(onNext: { [weak self] time in
            print(time)
        })
            .disposed(by: dispose)
        
    }
    /// 序列三部曲： 产生 -> 订阅 -> 发送信号
    func observableTrilogy() {
        // 1. 产生
        let ob = Observable<Any>.create { obser -> Disposable in
            // 3. 发送信号
            obser.onNext("ob 1")
            obser.onError(NSError.init(domain: "error 1", code: 10010, userInfo: ["key1" : "error info"]))
            return Disposables.create()
        }
        // 2. 订阅
        ob.subscribe { any in
            print("any : \(any)")
        } onError: { error in
            print("error : \(error)")
        } onCompleted: {
            print("completed")
        } onDisposed: {
            print("disposed")
        }
        .disposed(by: dispose)
        
        

    }
}
