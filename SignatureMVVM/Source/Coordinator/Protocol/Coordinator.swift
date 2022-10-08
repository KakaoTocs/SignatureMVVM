//
//  Coordinator.swift
//  SignatureMVVM
//
//  Created by 김진우 on 2022/10/08.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinator: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
