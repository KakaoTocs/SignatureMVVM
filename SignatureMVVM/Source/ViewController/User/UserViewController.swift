//
//  UserViewController.swift
//  SignatureMVVM
//
//  Created by 김진우 on 2022/10/11.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class UserViewController: UIViewController {
    // MARK: - UI Component
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        view.addSubview(button)
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        view.addSubview(label)
        return label
    }()
    
    // MARK: - Property
    private let viewModel: UserViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(viewModel: UserViewModel) {
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
        viewModel.output.backgroundColor
            .bind(to: view.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        closeButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(44)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(closeButton).offset(20)
            $0.width.equalTo(100)
            $0.height.equalTo(44)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func bindState() {
        viewModel.output.name
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.backgroundColor
            .bind(to: view.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        viewModel.output.popViewController
            .bind { _ in
                self.dismissViewController()
            }
            .disposed(by: disposeBag)
    }
    
    private func bindAction() {
        closeButton.rx.tap
            .bind(to: viewModel.input.closeButtonTap)
            .disposed(by: disposeBag)
    }
    
    private func dismissViewController() {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
}
