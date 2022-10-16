//
//  HomeViewModel.swift
//  SignatureMVVM
//
//  Created by 김진우 on 2022/10/08.
//

import RxSwift
import RxRelay

// 현재 Input/State/Output 프로토콜의 역할 없음 or 의미 없음(=있든 없든 차이가 없음)
// Coordinator 적용 하면서 DI 이전 & View 전환 코드 이전
protocol HomeViewModelInput {
    var loginButtonTap: PublishRelay<Void> { get }
    var detailButtonTap: PublishRelay<Void> { get }
}

protocol HomeViewModelState {
    var user: BehaviorSubject<Developer?> { get }
    var presentDetailViewController: BehaviorSubject<Void?> { get }
}

protocol HomeViewModelOutput {
    var name: Observable<String> { get }
    var loginButtonIsSelected: Observable<Bool> { get }
    var detailButtonIsEnable: Observable<Bool> { get }
    var presentDetailViewController: Observable<Void> { get }
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
        let loginButtonTap: PublishRelay<Void> = .init()
        let detailButtonTap: PublishRelay<Void> = .init()
        
        init() {
        }
    }
    
    struct State: HomeViewModelState {
        struct Dependency {
            let loginService: LoginServiceProtocol
        }
        
        let user: BehaviorSubject<Developer?> = .init(value: nil)
        let presentDetailViewController: BehaviorSubject<Void?> = .init(value: nil)
        
        private let dependency: Dependency
        
        private let disposeBag = DisposeBag()
        
        init(input: HomeViewModelInput, dependency: Dependency) {
            self.dependency = dependency
            
            input.loginButtonTap.map(loginButtonAction(_:))
                .flatMap { $0 }
                .bind(to: user)
                .disposed(by: disposeBag)
            
            input.detailButtonTap
                .bind(to: presentDetailViewController)
                .disposed(by: disposeBag)
        }
        
        private func loginButtonAction(_ void: Void) -> Observable<Developer?> {
            if let _ = try? user.value() {
                return .just(nil)
            } else {
                return dependency.loginService.login(())
            }
        }
    }
    
    struct Output: HomeViewModelOutput {
        let name: Observable<String>
        let loginButtonIsSelected: Observable<Bool>
        let detailButtonIsEnable: Observable<Bool>
        let presentDetailViewController: Observable<Void>

        init(state: HomeViewModelState) {
            self.name = state.user.map { $0?.name ?? "유저 X" }
            self.loginButtonIsSelected = state.user.map { $0 != nil }
            self.detailButtonIsEnable = state.user.map { $0 != nil }
            self.presentDetailViewController = state.presentDetailViewController.compactMap { $0 }
        }
    }
}
