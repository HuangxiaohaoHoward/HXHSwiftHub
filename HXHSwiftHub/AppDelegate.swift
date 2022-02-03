//
//  AppDelegate.swift
//  HXHSwiftHub
//
//  Created by huangyu on 2021/7/26.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupUI()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("url:\(url)")
        return true
    }
}

//MARK: - UI set extension
extension AppDelegate {
    func setupUI() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let rootVC = HXHBaseNavigationController(rootViewController: MainVC())
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        
        print(class_getInstanceSize(NSObject.self))
        
        let queue = DispatchQueue(label: "forSizeTest")
        let semphore = DispatchSemaphore(value: 0)
        queue.async {
            withUnsafeBytes(of: NSObject.self) { unsafeRawBufferPointer in
                print("不带&")
                for bute in unsafeRawBufferPointer {
                    print(bute)
                    print("malloc_size : \(malloc_size(unsafeRawBufferPointer.baseAddress))")
                }
                semphore.signal()
            }
            semphore.wait()
            var object = NSObject.init()
            withUnsafeBytes(of: &object) { unsafeRawBufferPointer in
                print("带&")
                for bute in unsafeRawBufferPointer {
                    print(bute)
                    print("malloc_size : \(malloc_size(unsafeRawBufferPointer.bindMemory(to: UInt8.self).baseAddress))")
                }
                semphore.signal()
            }
            semphore.wait()
            print("HXHRuntimeTest")
            let test = HXHRuntimeTest()
            test.test()
        }
        
    }
}



