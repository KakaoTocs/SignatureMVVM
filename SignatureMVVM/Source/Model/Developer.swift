//
//  User.swift
//  SignatureMVVM
//
//  Created by 김진우 on 2022/10/10.
//

import Foundation

struct Developer {
    let name: String
    let isiOSDeveloper: Bool
    let mainDevice: String?
}

extension Developer {
    static let iOSDeveloper: Developer = .init(name: "GAMZA", isiOSDeveloper: true, mainDevice: "MacBook Pro M1")
    static let WindowDeveloper: Developer = .init(name: "Chris Kim", isiOSDeveloper: false, mainDevice: nil)
    static let FullstackDeveloper: Developer = .init(name: "Green Kim", isiOSDeveloper: false, mainDevice: nil)
}
