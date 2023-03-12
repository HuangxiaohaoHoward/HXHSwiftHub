//
//  HXHBaseTableView.swift
//  HXHSwiftHub
//
//  Created by 黄小豪 on 2022/8/22.
//

import UIKit

class HXHBaseTableView: UITableView {

    override var contentOffset: CGPoint {
        didSet {
            print("HXHBaseTableView.contentOffset: \(contentOffset) --- oldValue : \(oldValue)")

        }
    }
}
