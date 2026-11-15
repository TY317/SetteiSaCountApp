//
//  ragnadorClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Ragnador: ObservableObject {
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

    // -------
    // ボイス選択
    // -------
    let ratioVoiceOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioVoiceOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioVoiceOver5: [Double] = [0,0,0,0,0.1,0.1,]
    let ratioVoiceOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("ragnadorVoiceCount1") var voiceCount1: Int = 0
    @AppStorage("ragnadorVoiceCount2") var voiceCount2: Int = 0
    @AppStorage("ragnadorVoiceCount3") var voiceCount3: Int = 0
    @AppStorage("ragnadorVoiceCount4") var voiceCount4: Int = 0
    @AppStorage("ragnadorVoiceCount5") var voiceCount5: Int = 0
    @AppStorage("ragnadorVoiceCount6") var voiceCount6: Int = 0
    @AppStorage("ragnadorVoiceCount7") var voiceCount7: Int = 0
    @AppStorage("ragnadorVoiceCount8") var voiceCount8: Int = 0
    @AppStorage("ragnadorVoiceCountSum") var voiceCountSum: Int = 0

    func voiceSumFunc() {
        voiceCountSum = countSum(
            voiceCount1,
            voiceCount2,
            voiceCount3,
            voiceCount4,
            voiceCount5,
            voiceCount6,
            voiceCount7,
            voiceCount8,
        )
    }

    func resetVoice() {
        voiceCount1 = 0
        voiceCount2 = 0
        voiceCount3 = 0
        voiceCount4 = 0
        voiceCount5 = 0
        voiceCount6 = 0
        voiceCount7 = 0
        voiceCount8 = 0
        voiceCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "ラグナドール"
    @AppStorage("ragnadorMinusCheck") var minusCheck: Bool = false
    @AppStorage("ragnadorSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetVoice()
    }
}


class RagnadorMemory1: ObservableObject {
    @AppStorage("ragnadorMemoMemory1") var memo = ""
    @AppStorage("ragnadorDateMemory1") var dateDouble = 0.0
}


class RagnadorMemory2: ObservableObject {
    @AppStorage("ragnadorMemoMemory2") var memo = ""
    @AppStorage("ragnadorDateMemory2") var dateDouble = 0.0
}


class RagnadorMemory3: ObservableObject {
    @AppStorage("ragnadorMemoMemory3") var memo = ""
    @AppStorage("ragnadorDateMemory3") var dateDouble = 0.0
}
