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
    let ratioFirstHitSc: [Double] = [326.5,321.6,295.8,287.6,279.7]   // 設定1,2,4,5,6
    @AppStorage("juoNormalGame") var normalGame: Int = 0
    @AppStorage("juoFirstHitCountSc") var firstHitCountSc: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountSc = 0
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
    @AppStorage("juoNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("juoFirstHitCountScMemory1") var firstHitCountSc: Int = 0
    @AppStorage("juoMemoMemory1") var memo = ""
    @AppStorage("juoDateMemory1") var dateDouble = 0.0
}


class JuoMemory2: ObservableObject {
    @AppStorage("juoNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("juoFirstHitCountScMemory2") var firstHitCountSc: Int = 0
    @AppStorage("juoMemoMemory2") var memo = ""
    @AppStorage("juoDateMemory2") var dateDouble = 0.0
}


class JuoMemory3: ObservableObject {
    @AppStorage("juoNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("juoFirstHitCountScMemory3") var firstHitCountSc: Int = 0
    @AppStorage("juoMemoMemory3") var memo = ""
    @AppStorage("juoDateMemory3") var dateDouble = 0.0
}
