//
//  MainVC.swift
//  RxSwiftDemo
//
//  Created by huangyu on 2021/7/14.
//  Copyright © 2021 huangyu. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    let manager = MainVCManager()
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.builder()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        title = "HXH Swift Hud"
    }
    
}
extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.tableItems?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let sources = manager.tableItems {
            let item = sources[indexPath.row]
            switch item {
            case .tfBindBtn,
                 .algorithm,
                 .loadHtml,
                 .multiThread,
                 .TestModelPerformance,
                 .optionSet :
                if let cell = table.dequeueReusableCell(withIdentifier: "cell") {
                    cell.textLabel?.text = item.rawValue
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let sources = manager.tableItems else { return }
        let item = sources[indexPath.row]
        switch item {
        case .tfBindBtn:
            gotoTfBindBtn()
        case .algorithm:
            gotoAlgorithm()
        case .loadHtml:
            gotoLocalHtml()
        case .multiThread:
            gotoMultiThread()
        case .TestModelPerformance:
            testModelPerformance()
        case .optionSet:
            testOptionSet()
        }
    }
//MARK: - action
func testOptionSet() {
    var opt: CellTypeOptions = [.detention]
    opt = opt.union(.fuel)
    switch opt {
    case [.detention, .fuel]:
        print("two")
    case let opt where opt.contains([.detention]):
        print("test contain ")
    case [.fuel]:
        print("fuel")
    default:
        print("default ")
    }
    opt.insert(.detention)
    print(opt)
    opt.remove(.detention)
    print(opt)
    
    let a: CGFloat = 1.23000
    print(a)
    print(String(format: "%.3f", a))
    
    let b: Double = 1.23000
    print(b)
    print(b.cleanZero)
}
    func testModelPerformance() {
        let param = ["username" : "username",
                     "age" : 2,
                     "weight" : 6.5] as [String : Any]
        var params: [[String : Any]] = []
        var tmp1: [DecoderUser] = []
        let dStartTime = CFAbsoluteTimeGetCurrent()
        for _ in 0..<99999 {
            let decoder = JSONDecoder()
            let jsondata = try! JSONSerialization.data(withJSONObject: param)
            let tmp = try? decoder.decode(DecoderUser.self, from: jsondata)
            if let tmp = tmp {
                tmp1.append(tmp)
            }
        }
        print(tmp1.count)
        print("decode time : \(String(format: "%f", CFAbsoluteTimeGetCurrent()-dStartTime))")
        
        var tmp2:[User] = []
        
        let oStartTime = CFAbsoluteTimeGetCurrent()
        for _ in 0..<99999 {
            let a = User(JSON: param)
            if let a = a {
                tmp2.append(a)
            }
        }
        print(tmp2.count)
        print("O time : \(String(format: "%f", CFAbsoluteTimeGetCurrent()-oStartTime))")
    }
    func gotoLocalHtml() {
        let vc = HXHLoadHtmlVC()
        present(vc, animated: true) {
            
        }
    }
    func gotoTfBindBtn() {
        let vc = TfBindBtnVC()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    func gotoAlgorithm() {
        let vc = AlgorithmVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    func gotoMultiThread() {
        let vc = HXHMultiThreadVC()
        present(vc, animated: true) {
            
        }
    }
}

enum MainItem: String {
    case tfBindBtn = "tf bind btn"
    case algorithm = "Algorithm"
    case loadHtml = "Load Html"
    case multiThread = "Multi Thread"
    case TestModelPerformance = "Test Model Performance"
    case optionSet = "OptionSet"
}

class MainVCManager {
    var tableItems: [MainItem]?
    func builder() {
        tableItems = [.tfBindBtn,
                      .algorithm,
                      .loadHtml,
                      .multiThread,
                      .TestModelPerformance,
                      .optionSet]
    }
}

struct CellTypeOptions: OptionSet {
    let rawValue: Int
    static let fuel = CellTypeOptions(rawValue: 1 << 0)
    static let trip = CellTypeOptions(rawValue: 1 << 1)
    static let detention = CellTypeOptions(rawValue: 1 << 2)
}
