//
//  HomeViewModel.swift
//  SignatureMVVM
//
//  Created by 김진우 on 2022/10/08.
//

import RxSwift
import RxRelay

protocol HomeViewModelInput {
    var loginButtonTap: PublishRelay<Void> { get }
}

protocol HomeViewModelState {
    var user: BehaviorSubject<Developer?> { get }
}

protocol HomeViewModelOutput {
    var name: Observable<String> { get }
    var isLogin: Observable<Bool> { get }
}

final class HomeViewModel: ViewModelType {

    // MARK: - Property
    let dependency: Dependency
    let payload: Payload
    let disposeBag: DisposeBag = .init()
    
    let input: Input = .init()
    let state: State
    let output: Output
    
    // MARK: - Init
    init(dependency: Dependency, payload: Payload) {
        self.dependency = dependency
        self.payload = payload
        
        self.state = State(input: input, dependency: .init(loginService: dependency.loginService))
        self.output = Output(state: state)
    }
}

extension HomeViewModel {
    // MARK: - Declaration
    struct Dependency {
        let loginService: LoginServiceProtocol
    }
    
    struct Payload {
    }
    
    struct Input: HomeViewModelInput {
        let loginButtonTap: PublishRelay<Void>
        
        init() {
            self.loginButtonTap = .init()
        }
    }
    
    struct State: HomeViewModelState {
        struct Dependency {
            let loginService: LoginServiceProtocol
        }
        
        let user: BehaviorSubject<Developer?> = .init(value: nil)
        
        private let disposeBag = DisposeBag()
        
        init(input: HomeViewModelInput, dependency: Dependency) {
            input.loginButtonTap.map { void in
                return dependency.loginService.login(void)
            }
            .flatMap { $0 }
            .bind(to: user)
            .disposed(by: disposeBag)
        }
    }
    
    struct Output: HomeViewModelOutput {
        let name: Observable<String>
        let isLogin: Observable<Bool>

        init(state: HomeViewModelState) {
            self.name = state.user.map { $0?.name ?? "유저 X" }
            self.isLogin = state.user.map { $0 != nil }
        }
    }
}
