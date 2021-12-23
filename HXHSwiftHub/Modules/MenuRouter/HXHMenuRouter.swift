//
//  HXHMenuRouter.swift
//  HXHSwiftHub
//
//  Created by huangyu on 2021/12/23.
//

import UIKit

class HXHMenuRouter: NSObject, HXHMenuRouterProtocol {
    
    //MARK: - property
    var routers: [DeepLinkHost] = [.navigate]
    enum DeepLinkHost: String {
        case navigate = "navigate"
    }
    //MARK: - action
    func handleURL(url: URL) {
        guard let host = url.host,
              let enumHost = DeepLinkHost(rawValue: host),
              canRoute(host: enumHost) == true else {
                  return
              }
        switch enumHost {
        case .navigate:
            gotoNavi()
        }
        
    }
    
}
extension HXHMenuRouter {
    func gotoNavi() {
        
    }
}
protocol HXHMenuRouterProtocol {
    var routers: [HXHMenuRouter.DeepLinkHost] { get }
}
extension HXHMenuRouterProtocol {
    func canRoute(host: HXHMenuRouter.DeepLinkHost) -> Bool {
        return routers.contains(host)
    }
}
