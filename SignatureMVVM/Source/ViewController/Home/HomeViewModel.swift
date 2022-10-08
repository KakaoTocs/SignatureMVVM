//
//  HomeViewModel.swift
//  SignatureMVVM
//
//  Created by 김진우 on 2022/10/08.
//

final class HomeViewModel: ViewModelType {
    
    struct Dependency {
        
    }
    
    struct Payload {
        
    }
    
    enum Input {
        case loginButtonTap
    }
    
    enum Output {
        case presentAlert
    }
    
    var dependency: Dependency
    var payload: Payload
    
    var input: Input
    var output: Output
    
    init(dependency: Dependency, payload: Payload) {
        self.dependency = dependency
        self.payload = payload
        
        input = .loginButtonTap
        output = .presentAlert
    }
}
