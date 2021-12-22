//
//  HXHBaseNavigationController.swift
//  HXHSwiftHub
//
//  Created by huangyu on 2021/10/9.
//

import UIKit

class HXHBaseNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        navigationBar.isTranslucent = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
