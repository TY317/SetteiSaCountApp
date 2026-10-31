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
    // ---- レア役成立時のSC高確移行率（設定1,2,4,5,6）
    let ratioCherryScHigh: [Double] = [3.1,3.5,5.5,5.9,6.3]
    let ratioRareReplayScHigh: [Double] = [20.3,21.1,27.3,30.9,33.6]
    @AppStorage("juoCherryCount") var cherryCount: Int = 0
    @AppStorage("juoCherryCountScHigh") var cherryCountScHigh: Int = 0
    @AppStorage("juoRareReplayCount") var rareReplayCount: Int = 0
    @AppStorage("juoRareReplayCountScHigh") var rareReplayCountScHigh: Int = 0

    func resetNormal() {
        cherryCount = 0
        cherryCountScHigh = 0
        rareReplayCount = 0
        rareReplayCountScHigh = 0
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
    @AppStorage("juoCherryCountMemory1") var cherryCount: Int = 0
    @AppStorage("juoCherryCountScHighMemory1") var cherryCountScHigh: Int = 0
    @AppStorage("juoRareReplayCountMemory1") var rareReplayCount: Int = 0
    @AppStorage("juoRareReplayCountScHighMemory1") var rareReplayCountScHigh: Int = 0
    @AppStorage("juoMemoMemory1") var memo = ""
    @AppStorage("juoDateMemory1") var dateDouble = 0.0
}


class JuoMemory2: ObservableObject {
    @AppStorage("juoNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("juoFirstHitCountScMemory2") var firstHitCountSc: Int = 0
    @AppStorage("juoCherryCountMemory2") var cherryCount: Int = 0
    @AppStorage("juoCherryCountScHighMemory2") var cherryCountScHigh: Int = 0
    @AppStorage("juoRareReplayCountMemory2") var rareReplayCount: Int = 0
    @AppStorage("juoRareReplayCountScHighMemory2") var rareReplayCountScHigh: Int = 0
    @AppStorage("juoMemoMemory2") var memo = ""
    @AppStorage("juoDateMemory2") var dateDouble = 0.0
}


class JuoMemory3: ObservableObject {
    @AppStorage("juoNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("juoFirstHitCountScMemory3") var firstHitCountSc: Int = 0
    @AppStorage("juoCherryCountMemory3") var cherryCount: Int = 0
    @AppStorage("juoCherryCountScHighMemory3") var cherryCountScHigh: Int = 0
    @AppStorage("juoRareReplayCountMemory3") var rareReplayCount: Int = 0
    @AppStorage("juoRareReplayCountScHighMemory3") var rareReplayCountScHigh: Int = 0
    @AppStorage("juoMemoMemory3") var memo = ""
    @AppStorage("juoDateMemory3") var dateDouble = 0.0
}
