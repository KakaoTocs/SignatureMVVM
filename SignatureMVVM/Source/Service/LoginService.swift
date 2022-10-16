//
//  LoginService.swift
//  SignatureMVVM
//
//  Created by 김진우 on 2022/10/10.
//

import RxSwift

protocol LoginServiceProtocol {
    func login(_ void: Void) -> Observable<Developer?>
}

final class LoginServiceStub: LoginServiceProtocol {
    func login(_ void: Void) -> Observable<Developer?> {
        return .just(.WindowDeveloper).delay(.seconds(3), scheduler: MainScheduler.instance)
    }
}
