//
//  TfBindBtnVC.swift
//  RxSwiftDemo
//
//  Created by huangyu on 2021/7/14.
//  Copyright © 2021 huangyu. All rights reserved.
//

import UIKit

class TfBindBtnVC: HXHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseUI()
    }
    func setupBaseUI() {
        title = "RxSwift Demo List"
    }
    
    @IBAction func gotoSearchTFVC(_ sender: Any) {
        let vc = RxSwiftSearchVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
