//
//  UserViewModel.swift
//  SignatureMVVM
//
//  Created by 김진우 on 2022/10/11.
//

import UIKit

import RxSwift
import RxRelay

protocol UserViewModelInput {
    var closeButtonTap: PublishRelay<Void> { get }
}

protocol UserViewModelState {
    var user: BehaviorSubject<Developer> { get }
    var popViewController: BehaviorSubject<Void?> { get }
}

protocol UserViewModelOutput {
    var name: Observable<String> { get }
    var backgroundColor: Observable<UIColor> { get }
    var popViewController: Observable<Void> { get }
}

final class UserViewModel: ViewModelType {
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
        
        self.state = State(input: input, payload: .init(developer: payload.developer))
        self.output = Output(state: state)
    }
}

extension UserViewModel {
    // MARK: - Declaration
    struct Dependency {
    }
    
    struct Payload {
        let developer: Developer
    }
    
    struct Input: UserViewModelInput {
        let closeButtonTap: PublishRelay<Void> = .init()
        
        init() {
        }
    }
    
    struct State: UserViewModelState {
        struct Payload {
            let developer: Developer
        }
        
        let user: BehaviorSubject<Developer>
        let popViewController: BehaviorSubject<Void?>
        
        private let disposeBag = DisposeBag()
        
        init(input: UserViewModelInput, payload: Payload) {
            user = .init(value: payload.developer)
            popViewController = .init(value: nil)
            
            input.closeButtonTap
                .bind(to: popViewController)
                .disposed(by: disposeBag)
        }
    }
    
    struct Output: UserViewModelOutput {
        let name: Observable<String>
        let backgroundColor: Observable<UIColor>
        let popViewController: Observable<Void>
        
        let disposeBag = DisposeBag()
        init(state: UserViewModelState) {
            self.name = state.user.map { $0.name }
            self.backgroundColor = state.user.map { $0.isiOSDeveloper ? .orange : .blue }
            self.popViewController = state.popViewController.compactMap { $0 }
        }
    }
}
