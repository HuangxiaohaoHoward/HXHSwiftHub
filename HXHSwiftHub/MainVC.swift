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
                 .multiThread:
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
        }
    }
    //MARK: - action
    func gotoLocalHtml() {
        let vc = HXHLoadHtmlVC()
        present(vc, animated: true) {
            
        }
    }
    func gotoTfBindBtn() {
        let vc = TfBindBtnVC()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true) {
        }
    }
    func gotoAlgorithm() {
        let vc = AlgorithmVC()
        present(vc, animated: true) {
            
        }
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
}

class MainVCManager {
    var tableItems: [MainItem]?
    func builder() {
        tableItems = [.tfBindBtn,
                      .algorithm,
                      .loadHtml,
                      .multiThread]
    }
}
