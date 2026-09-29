//
//  kanokariClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Kanokari: ObservableObject {
    // -------
    // 通常時
    // -------

    func resetNormal() {
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitCz: [Double] = [172,169,164,154,151,149]
    let ratioFirstHitBonus: [Double] = [269,263,254,235,231,226]
    @AppStorage("kanokariNormalGame") var normalGame: Int = 0
    @AppStorage("kanokariFirstHitCountCz") var firstHitCountCz: Int = 0
    @AppStorage("kanokariFirstHitCountBonus") var firstHitCountBonus: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountCz = 0
        firstHitCountBonus = 0
        minusCheck = false
    }

    // -------
    // 画面選択
    // -------
    let ratioScreenOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioScreenOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioScreenOver5: [Double] = [0,0,0,0,0.1,0.1,]
    let ratioScreenOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("kanokariScreenCount1") var screenCount1: Int = 0
    @AppStorage("kanokariScreenCount2") var screenCount2: Int = 0
    @AppStorage("kanokariScreenCount3") var screenCount3: Int = 0
    @AppStorage("kanokariScreenCount4") var screenCount4: Int = 0
    @AppStorage("kanokariScreenCount5") var screenCount5: Int = 0
    @AppStorage("kanokariScreenCount6") var screenCount6: Int = 0
    @AppStorage("kanokariScreenCount7") var screenCount7: Int = 0
    @AppStorage("kanokariScreenCountSum") var screenCountSum: Int = 0

    func screenSumFunc() {
        screenCountSum = countSum(
            screenCount1,
            screenCount2,
            screenCount3,
            screenCount4,
            screenCount5,
            screenCount6,
            screenCount7,
        )
    }

    func resetScreen() {
        screenCount1 = 0
        screenCount2 = 0
        screenCount3 = 0
        screenCount4 = 0
        screenCount5 = 0
        screenCount6 = 0
        screenCount7 = 0
        screenCountSum = 0
        minusCheck = false
    }

    // -------
    // RB中 キャラ紹介シナリオ
    // -------
    let ratioRbCharaNegate1: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioRbCharaNegate2: [Double] = [0.1,0,0.1,0.1,0.1,0.1,]
    let ratioRbCharaNegate3: [Double] = [0.1,0.1,0,0.1,0.1,0.1,]
    let ratioRbCharaNegate4: [Double] = [0.1,0.1,0.1,0,0.1,0.1,]
    let ratioRbCharaNegate5: [Double] = [0.1,0.1,0.1,0.1,0,0.1,]
    let ratioRbCharaOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioRbCharaOver3: [Double] = [0,0,0.1,0.1,0.1,0.1,]
    let ratioRbCharaOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioRbCharaOver5: [Double] = [0,0,0,0,0.1,0.1,]
    let ratioRbCharaOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("kanokariRbCharaCountDefault") var rbCharaCountDefault: Int = 0
    @AppStorage("kanokariRbCharaCountKisu") var rbCharaCountKisu: Int = 0
    @AppStorage("kanokariRbCharaCountGusu") var rbCharaCountGusu: Int = 0
    @AppStorage("kanokariRbCharaCountHighJaku") var rbCharaCountHighJaku: Int = 0
    @AppStorage("kanokariRbCharaCountHighKyo") var rbCharaCountHighKyo: Int = 0
    @AppStorage("kanokariRbCharaCountNegate1") var rbCharaCountNegate1: Int = 0
    @AppStorage("kanokariRbCharaCountNegate2") var rbCharaCountNegate2: Int = 0
    @AppStorage("kanokariRbCharaCountNegate3") var rbCharaCountNegate3: Int = 0
    @AppStorage("kanokariRbCharaCountNegate4") var rbCharaCountNegate4: Int = 0
    @AppStorage("kanokariRbCharaCountNegate5") var rbCharaCountNegate5: Int = 0
    @AppStorage("kanokariRbCharaCountOver2") var rbCharaCountOver2: Int = 0
    @AppStorage("kanokariRbCharaCountOver3") var rbCharaCountOver3: Int = 0
    @AppStorage("kanokariRbCharaCountOver4") var rbCharaCountOver4: Int = 0
    @AppStorage("kanokariRbCharaCountOver5") var rbCharaCountOver5: Int = 0
    @AppStorage("kanokariRbCharaCountOver6") var rbCharaCountOver6: Int = 0
    @AppStorage("kanokariRbCharaCountSum") var rbCharaCountSum: Int = 0

    func rbCharaSumFunc() {
        rbCharaCountSum = countSum(
            rbCharaCountDefault,
            rbCharaCountKisu,
            rbCharaCountGusu,
            rbCharaCountHighJaku,
            rbCharaCountHighKyo,
            rbCharaCountNegate1,
            rbCharaCountNegate2,
            rbCharaCountNegate3,
            rbCharaCountNegate4,
            rbCharaCountNegate5,
            rbCharaCountOver2,
            rbCharaCountOver3,
            rbCharaCountOver4,
            rbCharaCountOver5,
            rbCharaCountOver6,
        )
    }

    func resetRbChara() {
        rbCharaCountDefault = 0
        rbCharaCountKisu = 0
        rbCharaCountGusu = 0
        rbCharaCountHighJaku = 0
        rbCharaCountHighKyo = 0
        rbCharaCountNegate1 = 0
        rbCharaCountNegate2 = 0
        rbCharaCountNegate3 = 0
        rbCharaCountNegate4 = 0
        rbCharaCountNegate5 = 0
        rbCharaCountOver2 = 0
        rbCharaCountOver3 = 0
        rbCharaCountOver4 = 0
        rbCharaCountOver5 = 0
        rbCharaCountOver6 = 0
        rbCharaCountSum = 0
        minusCheck = false
    }

    // -------
    // キャラ選択（1Gレンチャンス）
    // -------
    @AppStorage("kanokariKoryakuCharaCount1") var koryakuCharaCount1: Int = 0   // 偶数設定示唆
    @AppStorage("kanokariKoryakuCharaCount2") var koryakuCharaCount2: Int = 0   // 奇数設定示唆
    @AppStorage("kanokariKoryakuCharaCountSum") var koryakuCharaCountSum: Int = 0

    func koryakuCharaSumFunc() {
        koryakuCharaCountSum = countSum(
            koryakuCharaCount1,
            koryakuCharaCount2,
        )
    }

    func resetKoryakuChara() {
        koryakuCharaCount1 = 0
        koryakuCharaCount2 = 0
        koryakuCharaCountSum = 0
        minusCheck = false
    }

    // -------
    // ボイス選択（エンディング）
    // -------
    let ratioEndingVoiceOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioEndingVoiceOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioEndingVoiceOver5: [Double] = [0,0,0,0,0.1,0.1,]
    let ratioEndingVoiceOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("kanokariEndingVoiceCount1") var endingVoiceCount1: Int = 0   // デフォルト
    @AppStorage("kanokariEndingVoiceCount2") var endingVoiceCount2: Int = 0   // 高設定示唆 弱
    @AppStorage("kanokariEndingVoiceCount3") var endingVoiceCount3: Int = 0   // 高設定示唆 中
    @AppStorage("kanokariEndingVoiceCount4") var endingVoiceCount4: Int = 0   // 高設定示唆 強
    @AppStorage("kanokariEndingVoiceCount5") var endingVoiceCount5: Int = 0   // 設定2 以上濃厚
    @AppStorage("kanokariEndingVoiceCount6") var endingVoiceCount6: Int = 0   // 設定4 以上濃厚
    @AppStorage("kanokariEndingVoiceCount7") var endingVoiceCount7: Int = 0   // 設定5 以上濃厚
    @AppStorage("kanokariEndingVoiceCount8") var endingVoiceCount8: Int = 0   // 設定6 濃厚
    @AppStorage("kanokariEndingVoiceCountSum") var endingVoiceCountSum: Int = 0

    func endingVoiceSumFunc() {
        endingVoiceCountSum = countSum(
            endingVoiceCount1,
            endingVoiceCount2,
            endingVoiceCount3,
            endingVoiceCount4,
            endingVoiceCount5,
            endingVoiceCount6,
            endingVoiceCount7,
            endingVoiceCount8,
        )
    }

    func resetEndingVoice() {
        endingVoiceCount1 = 0
        endingVoiceCount2 = 0
        endingVoiceCount3 = 0
        endingVoiceCount4 = 0
        endingVoiceCount5 = 0
        endingVoiceCount6 = 0
        endingVoiceCount7 = 0
        endingVoiceCount8 = 0
        endingVoiceCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "彼女、お借りします"
    @AppStorage("kanokariMinusCheck") var minusCheck: Bool = false
    @AppStorage("kanokariSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
        resetRbChara()
        resetKoryakuChara()
        resetEndingVoice()
    }
}


class KanokariMemory1: ObservableObject {
    @AppStorage("kanokariNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("kanokariFirstHitCountCzMemory1") var firstHitCountCz: Int = 0
    @AppStorage("kanokariFirstHitCountBonusMemory1") var firstHitCountBonus: Int = 0
    @AppStorage("kanokariScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("kanokariScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("kanokariScreenCount3Memory1") var screenCount3: Int = 0
    @AppStorage("kanokariScreenCount4Memory1") var screenCount4: Int = 0
    @AppStorage("kanokariScreenCount5Memory1") var screenCount5: Int = 0
    @AppStorage("kanokariScreenCount6Memory1") var screenCount6: Int = 0
    @AppStorage("kanokariScreenCount7Memory1") var screenCount7: Int = 0
    @AppStorage("kanokariScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("kanokariRbCharaCountDefaultMemory1") var rbCharaCountDefault: Int = 0
    @AppStorage("kanokariRbCharaCountKisuMemory1") var rbCharaCountKisu: Int = 0
    @AppStorage("kanokariRbCharaCountGusuMemory1") var rbCharaCountGusu: Int = 0
    @AppStorage("kanokariRbCharaCountHighJakuMemory1") var rbCharaCountHighJaku: Int = 0
    @AppStorage("kanokariRbCharaCountHighKyoMemory1") var rbCharaCountHighKyo: Int = 0
    @AppStorage("kanokariRbCharaCountNegate1Memory1") var rbCharaCountNegate1: Int = 0
    @AppStorage("kanokariRbCharaCountNegate2Memory1") var rbCharaCountNegate2: Int = 0
    @AppStorage("kanokariRbCharaCountNegate3Memory1") var rbCharaCountNegate3: Int = 0
    @AppStorage("kanokariRbCharaCountNegate4Memory1") var rbCharaCountNegate4: Int = 0
    @AppStorage("kanokariRbCharaCountNegate5Memory1") var rbCharaCountNegate5: Int = 0
    @AppStorage("kanokariRbCharaCountOver2Memory1") var rbCharaCountOver2: Int = 0
    @AppStorage("kanokariRbCharaCountOver3Memory1") var rbCharaCountOver3: Int = 0
    @AppStorage("kanokariRbCharaCountOver4Memory1") var rbCharaCountOver4: Int = 0
    @AppStorage("kanokariRbCharaCountOver5Memory1") var rbCharaCountOver5: Int = 0
    @AppStorage("kanokariRbCharaCountOver6Memory1") var rbCharaCountOver6: Int = 0
    @AppStorage("kanokariRbCharaCountSumMemory1") var rbCharaCountSum: Int = 0
    @AppStorage("kanokariKoryakuCharaCount1Memory1") var koryakuCharaCount1: Int = 0
    @AppStorage("kanokariKoryakuCharaCount2Memory1") var koryakuCharaCount2: Int = 0
    @AppStorage("kanokariKoryakuCharaCountSumMemory1") var koryakuCharaCountSum: Int = 0
    @AppStorage("kanokariEndingVoiceCount1Memory1") var endingVoiceCount1: Int = 0
    @AppStorage("kanokariEndingVoiceCount2Memory1") var endingVoiceCount2: Int = 0
    @AppStorage("kanokariEndingVoiceCount3Memory1") var endingVoiceCount3: Int = 0
    @AppStorage("kanokariEndingVoiceCount4Memory1") var endingVoiceCount4: Int = 0
    @AppStorage("kanokariEndingVoiceCount5Memory1") var endingVoiceCount5: Int = 0
    @AppStorage("kanokariEndingVoiceCount6Memory1") var endingVoiceCount6: Int = 0
    @AppStorage("kanokariEndingVoiceCount7Memory1") var endingVoiceCount7: Int = 0
    @AppStorage("kanokariEndingVoiceCount8Memory1") var endingVoiceCount8: Int = 0
    @AppStorage("kanokariEndingVoiceCountSumMemory1") var endingVoiceCountSum: Int = 0
    @AppStorage("kanokariMemoMemory1") var memo = ""
    @AppStorage("kanokariDateMemory1") var dateDouble = 0.0
}


class KanokariMemory2: ObservableObject {
    @AppStorage("kanokariNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("kanokariFirstHitCountCzMemory2") var firstHitCountCz: Int = 0
    @AppStorage("kanokariFirstHitCountBonusMemory2") var firstHitCountBonus: Int = 0
    @AppStorage("kanokariScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("kanokariScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("kanokariScreenCount3Memory2") var screenCount3: Int = 0
    @AppStorage("kanokariScreenCount4Memory2") var screenCount4: Int = 0
    @AppStorage("kanokariScreenCount5Memory2") var screenCount5: Int = 0
    @AppStorage("kanokariScreenCount6Memory2") var screenCount6: Int = 0
    @AppStorage("kanokariScreenCount7Memory2") var screenCount7: Int = 0
    @AppStorage("kanokariScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("kanokariRbCharaCountDefaultMemory2") var rbCharaCountDefault: Int = 0
    @AppStorage("kanokariRbCharaCountKisuMemory2") var rbCharaCountKisu: Int = 0
    @AppStorage("kanokariRbCharaCountGusuMemory2") var rbCharaCountGusu: Int = 0
    @AppStorage("kanokariRbCharaCountHighJakuMemory2") var rbCharaCountHighJaku: Int = 0
    @AppStorage("kanokariRbCharaCountHighKyoMemory2") var rbCharaCountHighKyo: Int = 0
    @AppStorage("kanokariRbCharaCountNegate1Memory2") var rbCharaCountNegate1: Int = 0
    @AppStorage("kanokariRbCharaCountNegate2Memory2") var rbCharaCountNegate2: Int = 0
    @AppStorage("kanokariRbCharaCountNegate3Memory2") var rbCharaCountNegate3: Int = 0
    @AppStorage("kanokariRbCharaCountNegate4Memory2") var rbCharaCountNegate4: Int = 0
    @AppStorage("kanokariRbCharaCountNegate5Memory2") var rbCharaCountNegate5: Int = 0
    @AppStorage("kanokariRbCharaCountOver2Memory2") var rbCharaCountOver2: Int = 0
    @AppStorage("kanokariRbCharaCountOver3Memory2") var rbCharaCountOver3: Int = 0
    @AppStorage("kanokariRbCharaCountOver4Memory2") var rbCharaCountOver4: Int = 0
    @AppStorage("kanokariRbCharaCountOver5Memory2") var rbCharaCountOver5: Int = 0
    @AppStorage("kanokariRbCharaCountOver6Memory2") var rbCharaCountOver6: Int = 0
    @AppStorage("kanokariRbCharaCountSumMemory2") var rbCharaCountSum: Int = 0
    @AppStorage("kanokariKoryakuCharaCount1Memory2") var koryakuCharaCount1: Int = 0
    @AppStorage("kanokariKoryakuCharaCount2Memory2") var koryakuCharaCount2: Int = 0
    @AppStorage("kanokariKoryakuCharaCountSumMemory2") var koryakuCharaCountSum: Int = 0
    @AppStorage("kanokariEndingVoiceCount1Memory2") var endingVoiceCount1: Int = 0
    @AppStorage("kanokariEndingVoiceCount2Memory2") var endingVoiceCount2: Int = 0
    @AppStorage("kanokariEndingVoiceCount3Memory2") var endingVoiceCount3: Int = 0
    @AppStorage("kanokariEndingVoiceCount4Memory2") var endingVoiceCount4: Int = 0
    @AppStorage("kanokariEndingVoiceCount5Memory2") var endingVoiceCount5: Int = 0
    @AppStorage("kanokariEndingVoiceCount6Memory2") var endingVoiceCount6: Int = 0
    @AppStorage("kanokariEndingVoiceCount7Memory2") var endingVoiceCount7: Int = 0
    @AppStorage("kanokariEndingVoiceCount8Memory2") var endingVoiceCount8: Int = 0
    @AppStorage("kanokariEndingVoiceCountSumMemory2") var endingVoiceCountSum: Int = 0
    @AppStorage("kanokariMemoMemory2") var memo = ""
    @AppStorage("kanokariDateMemory2") var dateDouble = 0.0
}


class KanokariMemory3: ObservableObject {
    @AppStorage("kanokariNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("kanokariFirstHitCountCzMemory3") var firstHitCountCz: Int = 0
    @AppStorage("kanokariFirstHitCountBonusMemory3") var firstHitCountBonus: Int = 0
    @AppStorage("kanokariScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("kanokariScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("kanokariScreenCount3Memory3") var screenCount3: Int = 0
    @AppStorage("kanokariScreenCount4Memory3") var screenCount4: Int = 0
    @AppStorage("kanokariScreenCount5Memory3") var screenCount5: Int = 0
    @AppStorage("kanokariScreenCount6Memory3") var screenCount6: Int = 0
    @AppStorage("kanokariScreenCount7Memory3") var screenCount7: Int = 0
    @AppStorage("kanokariScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("kanokariRbCharaCountDefaultMemory3") var rbCharaCountDefault: Int = 0
    @AppStorage("kanokariRbCharaCountKisuMemory3") var rbCharaCountKisu: Int = 0
    @AppStorage("kanokariRbCharaCountGusuMemory3") var rbCharaCountGusu: Int = 0
    @AppStorage("kanokariRbCharaCountHighJakuMemory3") var rbCharaCountHighJaku: Int = 0
    @AppStorage("kanokariRbCharaCountHighKyoMemory3") var rbCharaCountHighKyo: Int = 0
    @AppStorage("kanokariRbCharaCountNegate1Memory3") var rbCharaCountNegate1: Int = 0
    @AppStorage("kanokariRbCharaCountNegate2Memory3") var rbCharaCountNegate2: Int = 0
    @AppStorage("kanokariRbCharaCountNegate3Memory3") var rbCharaCountNegate3: Int = 0
    @AppStorage("kanokariRbCharaCountNegate4Memory3") var rbCharaCountNegate4: Int = 0
    @AppStorage("kanokariRbCharaCountNegate5Memory3") var rbCharaCountNegate5: Int = 0
    @AppStorage("kanokariRbCharaCountOver2Memory3") var rbCharaCountOver2: Int = 0
    @AppStorage("kanokariRbCharaCountOver3Memory3") var rbCharaCountOver3: Int = 0
    @AppStorage("kanokariRbCharaCountOver4Memory3") var rbCharaCountOver4: Int = 0
    @AppStorage("kanokariRbCharaCountOver5Memory3") var rbCharaCountOver5: Int = 0
    @AppStorage("kanokariRbCharaCountOver6Memory3") var rbCharaCountOver6: Int = 0
    @AppStorage("kanokariRbCharaCountSumMemory3") var rbCharaCountSum: Int = 0
    @AppStorage("kanokariKoryakuCharaCount1Memory3") var koryakuCharaCount1: Int = 0
    @AppStorage("kanokariKoryakuCharaCount2Memory3") var koryakuCharaCount2: Int = 0
    @AppStorage("kanokariKoryakuCharaCountSumMemory3") var koryakuCharaCountSum: Int = 0
    @AppStorage("kanokariEndingVoiceCount1Memory3") var endingVoiceCount1: Int = 0
    @AppStorage("kanokariEndingVoiceCount2Memory3") var endingVoiceCount2: Int = 0
    @AppStorage("kanokariEndingVoiceCount3Memory3") var endingVoiceCount3: Int = 0
    @AppStorage("kanokariEndingVoiceCount4Memory3") var endingVoiceCount4: Int = 0
    @AppStorage("kanokariEndingVoiceCount5Memory3") var endingVoiceCount5: Int = 0
    @AppStorage("kanokariEndingVoiceCount6Memory3") var endingVoiceCount6: Int = 0
    @AppStorage("kanokariEndingVoiceCount7Memory3") var endingVoiceCount7: Int = 0
    @AppStorage("kanokariEndingVoiceCount8Memory3") var endingVoiceCount8: Int = 0
    @AppStorage("kanokariEndingVoiceCountSumMemory3") var endingVoiceCountSum: Int = 0
    @AppStorage("kanokariMemoMemory3") var memo = ""
    @AppStorage("kanokariDateMemory3") var dateDouble = 0.0
}
