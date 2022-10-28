//
//  UserViewCoordinator.swift
//  SignatureMVVM
//
//  Created by 김진우 on 2022/10/16.
//

import UIKit

final class UserViewCoordinator: Coordinator {
    // MARK: - Property
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parentCoordinator: HomeCoordinator?
    
    private let userViewModel: UserViewModel
    
    init(navigationController: UINavigationController, userViewModel: UserViewModel) {
        self.navigationController = navigationController
        self.userViewModel = userViewModel
    }
    
    func start() {
        let userViewController = UserViewController(viewModel: userViewModel)
        userViewController.coordinator = self
        navigationController.pushViewController(userViewController, animated: true)
    }
}
