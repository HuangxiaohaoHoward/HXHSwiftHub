//
//  HXHBaseViewController.swift
//  HXHSwiftHub
//
//  Created by huangyu on 2021/8/14.
//

import UIKit

class HXHBaseViewController: UIViewController {
    //MARK: - init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        baseConfig()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        baseConfig()
    }
    
    //MARK: - lift style
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //MARK: - base config
    private func baseConfig() {
        modalPresentationStyle = .fullScreen
//        modalTransitionStyle = .crossDissolve
    }
}
