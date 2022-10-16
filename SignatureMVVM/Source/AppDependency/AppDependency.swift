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
        let loginService = LoginServiceStub()
        
        let homeViewModelDependency = HomeViewModel.Dependency(loginService: loginService)
        let homeViewModelPayload = HomeViewModel.Payload()
        let homeViewModel = HomeViewModel(dependency: homeViewModelDependency, payload: homeViewModelPayload)

        return .init(homeViewModel: homeViewModel)
    }
}
