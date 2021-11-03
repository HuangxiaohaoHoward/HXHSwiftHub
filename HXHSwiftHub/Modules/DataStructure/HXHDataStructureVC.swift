//
//  HXHDataStructureVC.swift
//  HXHSwiftHub
//
//  Created by huangyu on 2021/9/8.
//

import Foundation
import RxSwift
import RxCocoa
import SnapKit
import UIKit

class HXHDataStructureVC: HXHBaseViewController {
    let disposeBag: DisposeBag = DisposeBag()
    lazy var scrollView: UIScrollView = {
        let s = UIScrollView()
        s.contentInsetAdjustmentBehavior = .never
        return s
    }()
    lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseUI()
    }
    //MARK: base UI
    private func setupBaseUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(stack)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        stack.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView.snp.centerX)
            make.top.equalTo(scrollView.snp.top)
            make.left.equalTo(scrollView.snp.left)
            make.right.equalTo(scrollView.snp.right)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
    }
    private func setupBtns() {
        let btn = UIButton(type: .custom)
        btn.setTitle("go to Array VC", for: .normal)
        btn.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let vc = HXHArrayVC()
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
