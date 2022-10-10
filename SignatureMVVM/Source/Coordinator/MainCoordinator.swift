//
//  MainCoordinator.swift
//  SignatureMVVM
//
//  Created by 김진우 on 2022/10/08.
//

import UIKit

final class MainCoordinator: Coordinator {
    // MARK: - Property
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Method
    func start() {
//        let 
    }
}
