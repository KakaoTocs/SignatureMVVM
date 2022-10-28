//
//  HomeViewCoordinator.swift
//  SignatureMVVM
//
//  Created by 김진우 on 2022/10/16.
//

import Foundation
import UIKit

final class HomeCoordinator: Coordinator {
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
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: false)
    }
    
    // Coordinator에서 뷰 전환 메소드 파라미터는 Payload가 있던가 or 아무것도 없거나. 선택지는 단 둘 뿐.?
    func pushUserViewController(userViewModelPayload: UserViewModel.Payload) {
        let userViewModelFactory = appDependency.homeViewModel.dependency.userViewModelFactory
        let userViewModel = userViewModelFactory.create(payload: userViewModelPayload)
        let userViewCoordinator = UserViewCoordinator(navigationController: navigationController, userViewModel: userViewModel)
        userViewCoordinator.parentCoordinator = self
        childCoordinator.append(userViewCoordinator)
        userViewCoordinator.start()
    }
}
