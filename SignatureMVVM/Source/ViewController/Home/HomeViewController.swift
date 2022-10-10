//
//  HomeViewController.swift
//  SignatureMVVM
//
//  Created by 김진우 on 2022/10/08.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class HomeViewController: UIViewController {
    // MARK: - UI Component
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        view.addSubview(label)
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.setTitle("로그아웃", for: .selected)
        button.titleLabel?.textAlignment = .center
        view.addSubview(button)
        return button
    }()
    
    // MARK: - Property
    private let viewModel: HomeViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
        bindState()
        bindAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Method
    private func setupUI() {
        view.backgroundColor = .white
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(44)
            $0.width.equalTo(200)
            $0.centerX.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
            $0.width.equalTo(100)
            $0.height.equalTo(44)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func bindState() {
        viewModel.output.name
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.isLogin
            .bind(to: loginButton.rx.isSelected)
            .disposed(by: disposeBag)
    }
    
    private func bindAction() {
        loginButton.rx.tap
            .bind(to: viewModel.input.loginButtonTap)
            .disposed(by: disposeBag)
    }
}
