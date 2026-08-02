//
//  index2Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Index2: ObservableObject {
    // -------
    // 通常時
    // -------
    let ratioSuikaKokaku: [Double] = [47.7,48,49.2,50.4,54.7,55.5]
    let ratioSuikaMikotoKokaku: [Double] = [14.3,14.5,14.8,15.2,16.4,16.7]
    @AppStorage("index2SuikaCountKoyaku") var suikaCountKoyaku: Int = 0
    @AppStorage("index2SuikaCountKokaku") var suikaCountKokaku: Int = 0
    @AppStorage("index2SuikaCountMikoto") var suikaCountMikoto: Int = 0

    func resetNormal() {
        suikaCountKoyaku = 0
        suikaCountKokaku = 0
        suikaCountMikoto = 0
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
    let machineName: String = "とある魔術の禁書目録2"
    @AppStorage("index2MinusCheck") var minusCheck: Bool = false
    @AppStorage("index2SelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
    }
}


class Index2Memory1: ObservableObject {
    @AppStorage("index2MemoMemory1") var memo = ""
    @AppStorage("index2DateMemory1") var dateDouble = 0.0
}


class Index2Memory2: ObservableObject {
    @AppStorage("index2MemoMemory2") var memo = ""
    @AppStorage("index2DateMemory2") var dateDouble = 0.0
}


class Index2Memory3: ObservableObject {
    @AppStorage("index2MemoMemory3") var memo = ""
    @AppStorage("index2DateMemory3") var dateDouble = 0.0
}
