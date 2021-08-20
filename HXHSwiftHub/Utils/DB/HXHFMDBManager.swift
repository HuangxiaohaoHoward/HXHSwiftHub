//
//  HXHFMDBManager.swift
//  HXHSwiftHub
//
//  Created by huangyu on 2021/8/19.
//

import UIKit

class HXHFMDBManager: NSObject {
    //MARK: - init
    static let shared = HXHFMDBManager()
    private override init() {
    }
    override func copy() -> Any {
        return self
    }
    override func mutableCopy() -> Any {
        return self
    }
    //MARK: - handle
    func createDB() {
        
    }
}
