//
//  juoClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Juo: ObservableObject {
    // -------
    // 通常時
    // -------

    func resetNormal() {
        minusCheck = false
    }

    // --------
    // 初当り
    // --------

    func resetFirstHit() {
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "獣王"
    @AppStorage("juoMinusCheck") var minusCheck: Bool = false
    @AppStorage("juoSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class JuoMemory1: ObservableObject {
    @AppStorage("juoMemoMemory1") var memo = ""
    @AppStorage("juoDateMemory1") var dateDouble = 0.0
}


class JuoMemory2: ObservableObject {
    @AppStorage("juoMemoMemory2") var memo = ""
    @AppStorage("juoDateMemory2") var dateDouble = 0.0
}


class JuoMemory3: ObservableObject {
    @AppStorage("juoMemoMemory3") var memo = ""
    @AppStorage("juoDateMemory3") var dateDouble = 0.0
}
