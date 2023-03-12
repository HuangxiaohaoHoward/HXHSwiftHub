//
//  HXHSyncTableVC.swift
//  HXHSwiftHub
//
//  Created by 黄小豪 on 2022/8/22.
//

import UIKit

class HXHSyncTableVC: HXHBaseViewController, UITableViewDelegate, UITableViewDataSource  {
    var tableView: HXHBaseTableView = HXHBaseTableView.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupTableView()
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HXHScrollSyncCell.self, forCellReuseIdentifier: "HXHScrollSyncCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
}
extension HXHSyncTableVC {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            cell.contentView.backgroundColor = UIColor.orange
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HXHScrollSyncCell", for: indexPath)
            cell.contentView.backgroundColor = UIColor.blue
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
