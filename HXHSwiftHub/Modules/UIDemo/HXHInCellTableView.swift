//
//  HXHInCellTableView.swift
//  HXHSwiftHub
//
//  Created by 黄小豪 on 2022/8/22.
//

import UIKit

class HXHInCellTableView: UITableView {
    override var contentOffset: CGPoint {
        didSet {
            print("HXHInCellTableView.contentOffset: \(contentOffset) --- oldValue : \(oldValue)")
        }
    }

}
