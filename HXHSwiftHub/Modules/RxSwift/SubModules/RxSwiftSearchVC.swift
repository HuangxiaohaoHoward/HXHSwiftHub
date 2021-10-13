//
//  RxSwiftSearchVC.swift
//  HXHSwiftHub
//
//  Created by huangyu on 2021/10/9.
//

import UIKit
import RxSwift
import RxCocoa

class RxSwiftSearchVC: HXHBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let cellReuseId: String = "cell"
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    let searchTF: UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseUI()
        bind()
    }
    func setupBaseUI() {
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseId)
//        table.delegate = self
//        table.dataSource = self
    }
//    func s() {
//        let searchResults = searchBar.rx.text.orEmpty
//            .throttle(0.3, scheduler: MainScheduler.instance)
//            .distinctUntilChanged()
//            .flatMapLatest { query -> Observable<[Repository]> in
//                if query.isEmpty {
//                    return .just([])
//                }
//                return searchGitHub(query)
//                    .catchErrorJustReturn([])
//            }
//            .observeOn(MainScheduler.instance)
//    }
    func bind() {
        func searchHud(_ query: String) -> Observable<[Repository]> {
            return Observable.empty()
        }
        let searchResult = searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query -> Observable<[Repository]> in
                if query.isEmpty {
                    return .just([])
                }
                return searchHud(query)
                    .catchAndReturn([])
            }
            .observe(on: MainScheduler.instance)
        searchResult.bind(to: table.rx.items(cellIdentifier: cellReuseId)) { (index, repository: Repository, cell)  in
            cell.textLabel?.text = "ss \(index) + searchResult : \(repository.title)"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: cellReuseId) ?? UITableViewCell()
        cell.textLabel?.text = "ss"
        return cell
    }
}

struct Repository {
    var title: String?
}
