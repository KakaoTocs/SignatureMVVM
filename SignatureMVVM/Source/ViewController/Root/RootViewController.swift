//
//  RootViewController.swift
//  SignatureMVVM
//
//  Created by 김진우 on 2022/10/08.
//

import UIKit

final class RootViewController: UINavigationController {
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setViewController()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Method
    private func setViewController() {
        let loginService = LoginServiceStub()
        
        let dependency = HomeViewModel.Dependency(loginService: loginService)
        let homeViewModel = HomeViewModel(dependency: dependency, payload: .init())
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        
        viewControllers = [homeViewController]
    }
}
