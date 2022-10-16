//
//  RootCoordinator.swift
//  SignatureMVVM
//
//  Created by 김진우 on 2022/10/16.
//

import Foundation
import UIKit

final class RootCoordinator: Coordinator {
    // MARK: - Property
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController
    private let appDependency: AppDependency
    
    // MARK: - Init
    init(navigationController: UINavigationController, appDependency: AppDependency) {
        self.navigationController = navigationController
        self.appDependency = appDependency
    }
    
    // MARK: - Method
    func start() {
        let homeViewModel = appDependency.homeViewModel
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        navigationController.pushViewController(homeViewController, animated: false)
    }
}
