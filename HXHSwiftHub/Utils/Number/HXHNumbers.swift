//
//  HXHNumbers.swift
//  HXHSwiftHub
//
//  Created by huangyu on 2021/10/13.
//

import Foundation
import CoreGraphics

protocol HXHNumberProtocol{

}
extension HXHNumberProtocol {
    
}
extension Double: HXHNumberProtocol {
    var cleanZero: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
extension Float: HXHNumberProtocol {
    var cleanZero: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
