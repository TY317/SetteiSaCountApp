//
//  mhrsbClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Mhrsb: ObservableObject {
    // -------
    // 通常時
    // -------

    func resetNormal() {
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitBz: [Double] = [111.4,108.8,105.6,99.3,97.2,95.8]
    let ratioFirstHitFukubiki: [Double] = [2290.1,2090.4,1821.1,1472.5,1219.3,976.4]
    let ratioFirstHitAt: [Double] = [349.9,337.0,319.8,283.6,264.0,242.3]
    // 猛焔一閃直撃の実質確率（すべての抽選を考慮した数値。参考情報のみ）
    let ratioMouenIssenChokugeki: [Double] = [16281.7,14875.5,12788.0,8702.1,6351.2,4263.1]
    @AppStorage("mhrsbNormalGame") var normalGame: Int = 0
    @AppStorage("mhrsbFirstHitCountBz") var firstHitCountBz: Int = 0
    @AppStorage("mhrsbFirstHitCountFukubiki") var firstHitCountFukubiki: Int = 0
    @AppStorage("mhrsbFirstHitCountAt") var firstHitCountAt: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountBz = 0
        firstHitCountFukubiki = 0
        firstHitCountAt = 0
        minusCheck = false
    }

    // --------
    // 終了画面
    // --------
    let ratioScreenNegate2: [Double] = [0.1,0,0.1,0.1,0.1,0.1,]
    let ratioScreenNegate3: [Double] = [0.1,0.1,0,0.1,0.1,0.1,]
    let ratioScreenOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioScreenOver5: [Double] = [0,0,0,0,0.1,0.1,]
    let ratioScreenOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("mhrsbScreenCount1") var screenCount1: Int = 0
    @AppStorage("mhrsbScreenCount2") var screenCount2: Int = 0
    @AppStorage("mhrsbScreenCount3") var screenCount3: Int = 0
    @AppStorage("mhrsbScreenCount4") var screenCount4: Int = 0
    @AppStorage("mhrsbScreenCount5") var screenCount5: Int = 0
    @AppStorage("mhrsbScreenCount6") var screenCount6: Int = 0
    @AppStorage("mhrsbScreenCount7") var screenCount7: Int = 0
    @AppStorage("mhrsbScreenCount8") var screenCount8: Int = 0
    @AppStorage("mhrsbScreenCount9") var screenCount9: Int = 0
    @AppStorage("mhrsbScreenCountSum") var screenCountSum: Int = 0

    func screenSumFunc() {
        screenCountSum = countSum(
            screenCount1,
            screenCount2,
            screenCount3,
            screenCount4,
            screenCount5,
            screenCount6,
            screenCount7,
            screenCount8,
            screenCount9,
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
        screenCount8 = 0
        screenCount9 = 0
        screenCountSum = 0
        minusCheck = false
    }

    // -------
    // エンディング
    // -------
    let ratioEndingOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioEndingOver3: [Double] = [0,0,0.1,0.1,0.1,0.1,]
    let ratioEndingOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioEndingOver5: [Double] = [0,0,0,0,0.1,0.1,]
    let ratioEndingOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("mhrsbEndingCount1") var endingCount1: Int = 0
    @AppStorage("mhrsbEndingCount2") var endingCount2: Int = 0
    @AppStorage("mhrsbEndingCount3") var endingCount3: Int = 0
    @AppStorage("mhrsbEndingCount4") var endingCount4: Int = 0
    @AppStorage("mhrsbEndingCount5") var endingCount5: Int = 0
    @AppStorage("mhrsbEndingCount6") var endingCount6: Int = 0
    @AppStorage("mhrsbEndingCount7") var endingCount7: Int = 0
    @AppStorage("mhrsbEndingCount8") var endingCount8: Int = 0
    @AppStorage("mhrsbEndingCount9") var endingCount9: Int = 0
    @AppStorage("mhrsbEndingCountSum") var endingCountSum: Int = 0

    func endingSumFunc() {
        endingCountSum = countSum(
            endingCount1,
            endingCount2,
            endingCount3,
            endingCount4,
            endingCount5,
            endingCount6,
            endingCount7,
            endingCount8,
            endingCount9,
        )
    }

    func resetEnding() {
        endingCount1 = 0
        endingCount2 = 0
        endingCount3 = 0
        endingCount4 = 0
        endingCount5 = 0
        endingCount6 = 0
        endingCount7 = 0
        endingCount8 = 0
        endingCount9 = 0
        endingCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "モンスターハンターライズ：サンブレイク"
    @AppStorage("mhrsbMinusCheck") var minusCheck: Bool = false
    @AppStorage("mhrsbSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetScreen()
        resetEnding()
    }
}


class MhrsbMemory1: ObservableObject {
    @AppStorage("mhrsbNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("mhrsbFirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("mhrsbScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("mhrsbScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("mhrsbScreenCount3Memory1") var screenCount3: Int = 0
    @AppStorage("mhrsbScreenCount4Memory1") var screenCount4: Int = 0
    @AppStorage("mhrsbScreenCount5Memory1") var screenCount5: Int = 0
    @AppStorage("mhrsbScreenCount6Memory1") var screenCount6: Int = 0
    @AppStorage("mhrsbScreenCount7Memory1") var screenCount7: Int = 0
    @AppStorage("mhrsbScreenCount8Memory1") var screenCount8: Int = 0
    @AppStorage("mhrsbScreenCount9Memory1") var screenCount9: Int = 0
    @AppStorage("mhrsbScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("mhrsbEndingCount1Memory1") var endingCount1: Int = 0
    @AppStorage("mhrsbEndingCount2Memory1") var endingCount2: Int = 0
    @AppStorage("mhrsbEndingCount3Memory1") var endingCount3: Int = 0
    @AppStorage("mhrsbEndingCount4Memory1") var endingCount4: Int = 0
    @AppStorage("mhrsbEndingCount5Memory1") var endingCount5: Int = 0
    @AppStorage("mhrsbEndingCount6Memory1") var endingCount6: Int = 0
    @AppStorage("mhrsbEndingCount7Memory1") var endingCount7: Int = 0
    @AppStorage("mhrsbEndingCount8Memory1") var endingCount8: Int = 0
    @AppStorage("mhrsbEndingCount9Memory1") var endingCount9: Int = 0
    @AppStorage("mhrsbEndingCountSumMemory1") var endingCountSum: Int = 0
    @AppStorage("mhrsbFirstHitCountBzMemory1") var firstHitCountBz: Int = 0
    @AppStorage("mhrsbFirstHitCountFukubikiMemory1") var firstHitCountFukubiki: Int = 0
    @AppStorage("mhrsbMemoMemory1") var memo = ""
    @AppStorage("mhrsbDateMemory1") var dateDouble = 0.0
}


class MhrsbMemory2: ObservableObject {
    @AppStorage("mhrsbNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("mhrsbFirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("mhrsbScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("mhrsbScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("mhrsbScreenCount3Memory2") var screenCount3: Int = 0
    @AppStorage("mhrsbScreenCount4Memory2") var screenCount4: Int = 0
    @AppStorage("mhrsbScreenCount5Memory2") var screenCount5: Int = 0
    @AppStorage("mhrsbScreenCount6Memory2") var screenCount6: Int = 0
    @AppStorage("mhrsbScreenCount7Memory2") var screenCount7: Int = 0
    @AppStorage("mhrsbScreenCount8Memory2") var screenCount8: Int = 0
    @AppStorage("mhrsbScreenCount9Memory2") var screenCount9: Int = 0
    @AppStorage("mhrsbScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("mhrsbEndingCount1Memory2") var endingCount1: Int = 0
    @AppStorage("mhrsbEndingCount2Memory2") var endingCount2: Int = 0
    @AppStorage("mhrsbEndingCount3Memory2") var endingCount3: Int = 0
    @AppStorage("mhrsbEndingCount4Memory2") var endingCount4: Int = 0
    @AppStorage("mhrsbEndingCount5Memory2") var endingCount5: Int = 0
    @AppStorage("mhrsbEndingCount6Memory2") var endingCount6: Int = 0
    @AppStorage("mhrsbEndingCount7Memory2") var endingCount7: Int = 0
    @AppStorage("mhrsbEndingCount8Memory2") var endingCount8: Int = 0
    @AppStorage("mhrsbEndingCount9Memory2") var endingCount9: Int = 0
    @AppStorage("mhrsbEndingCountSumMemory2") var endingCountSum: Int = 0
    @AppStorage("mhrsbFirstHitCountBzMemory2") var firstHitCountBz: Int = 0
    @AppStorage("mhrsbFirstHitCountFukubikiMemory2") var firstHitCountFukubiki: Int = 0
    @AppStorage("mhrsbMemoMemory2") var memo = ""
    @AppStorage("mhrsbDateMemory2") var dateDouble = 0.0
}


class MhrsbMemory3: ObservableObject {
    @AppStorage("mhrsbNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("mhrsbFirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("mhrsbScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("mhrsbScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("mhrsbScreenCount3Memory3") var screenCount3: Int = 0
    @AppStorage("mhrsbScreenCount4Memory3") var screenCount4: Int = 0
    @AppStorage("mhrsbScreenCount5Memory3") var screenCount5: Int = 0
    @AppStorage("mhrsbScreenCount6Memory3") var screenCount6: Int = 0
    @AppStorage("mhrsbScreenCount7Memory3") var screenCount7: Int = 0
    @AppStorage("mhrsbScreenCount8Memory3") var screenCount8: Int = 0
    @AppStorage("mhrsbScreenCount9Memory3") var screenCount9: Int = 0
    @AppStorage("mhrsbScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("mhrsbEndingCount1Memory3") var endingCount1: Int = 0
    @AppStorage("mhrsbEndingCount2Memory3") var endingCount2: Int = 0
    @AppStorage("mhrsbEndingCount3Memory3") var endingCount3: Int = 0
    @AppStorage("mhrsbEndingCount4Memory3") var endingCount4: Int = 0
    @AppStorage("mhrsbEndingCount5Memory3") var endingCount5: Int = 0
    @AppStorage("mhrsbEndingCount6Memory3") var endingCount6: Int = 0
    @AppStorage("mhrsbEndingCount7Memory3") var endingCount7: Int = 0
    @AppStorage("mhrsbEndingCount8Memory3") var endingCount8: Int = 0
    @AppStorage("mhrsbEndingCount9Memory3") var endingCount9: Int = 0
    @AppStorage("mhrsbEndingCountSumMemory3") var endingCountSum: Int = 0
    @AppStorage("mhrsbFirstHitCountBzMemory3") var firstHitCountBz: Int = 0
    @AppStorage("mhrsbFirstHitCountFukubikiMemory3") var firstHitCountFukubiki: Int = 0
    @AppStorage("mhrsbMemoMemory3") var memo = ""
    @AppStorage("mhrsbDateMemory3") var dateDouble = 0.0
}
