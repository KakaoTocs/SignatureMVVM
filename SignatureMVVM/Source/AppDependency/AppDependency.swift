//
//  AppDependency.swift
//  SignatureMVVM
//
//  Created by 김진우 on 2022/10/16.
//

import Foundation

struct AppDependency {
    let homeViewModel: HomeViewModel
    
    static func resolve() -> AppDependency {
        // Service
        let loginService = LoginServiceStub()
        
        // ViewModel
        let userViewModelFactory = UserViewModel.Factory(dependency: .init())
        
        let homeViewModelDependency = HomeViewModel.Dependency(loginService: loginService, userViewModelFactory: userViewModelFactory)
        let homeViewModelPayload = HomeViewModel.Payload()
        let homeViewModel = HomeViewModel(dependency: homeViewModelDependency, payload: homeViewModelPayload)

        return .init(homeViewModel: homeViewModel)
    }
}
