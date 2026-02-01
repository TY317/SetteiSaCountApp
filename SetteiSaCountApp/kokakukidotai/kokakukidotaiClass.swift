//
//  kokakukidotaiClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/12.
//

import Foundation
import SwiftUI
import Combine

class Kokakukidotai: ObservableObject {
    // ---------
    // 通常時
    // ---------
    let ratioIede: [Double] = [30,32.9,37.5,41.7,45.8,48.3]
    @AppStorage("kokakukidotaiIedeCountMiss") var iedeCountMiss: Int = 0
    @AppStorage("kokakukidotaiIedeCountSuccess") var iedeCountSuccess: Int = 0
    @AppStorage("kokakukidotaiIedeCountSum") var iedeCountSum: Int = 0
    
    func iedeSumFunc() {
        iedeCountSum = iedeCountMiss + iedeCountSuccess
    }
    
    func resetNormal() {
        iedeCountMiss = 0
        iedeCountSuccess = 0
        iedeCountSum = 0
        minusCheck = false
    }
    
    // ----------
    // 初当り
    // ----------
    let ratioFirstHitCz: [Double] = [238.0,236.3,231.7,220.9,214,210.1]
    let ratioFirstHitAt: [Double] = [336.3,332,319.6,298.7,285.8,278]
    @AppStorage("kokakukidotaiNormalGame") var normalGame: Int = 0
    @AppStorage("kokakukidotaiFirstHitCountAt") var firstHitCountAt: Int = 0
    @AppStorage("kokakukidotaiFirstHitCountCz") var firstHitCountCz: Int = 0
    func resetFirstHit() {
        normalGame = 0
        firstHitCountAt = 0
        firstHitCountCz = 0
        minusCheck = false
    }
    
    // --------
    // 終了画面
    // --------
    @AppStorage("kokakukidotaiScreenCountDefault") var screenCountDefault: Int = 0
    @AppStorage("kokakukidotaiScreenCountHighJaku") var screenCountHighJaku: Int = 0
    @AppStorage("kokakukidotaiScreenCountKisu") var screenCountKisu: Int = 0
    @AppStorage("kokakukidotaiScreenCountGusu") var screenCountGusu: Int = 0
    @AppStorage("kokakukidotaiScreenCountHighMode") var screenCountHighMode: Int = 0
    @AppStorage("kokakukidotaiScreenCountOverB") var screenCountOverB: Int = 0
    @AppStorage("kokakukidotaiScreenCountOverC") var screenCountOverC: Int = 0
    @AppStorage("kokakukidotaiScreenCountOverCKyo") var screenCountOverCKyo: Int = 0
    @AppStorage("kokakukidotaiScreenCountOverD4") var screenCountOverD4: Int = 0
    @AppStorage("kokakukidotaiScreenCountWhiteEdge") var screenCountWhiteEdge: Int = 0
    @AppStorage("kokakukidotaiScreenCountSum") var screenCountSum: Int = 0
    
    func screenSumFunc() {
        screenCountSum = countSum(
            screenCountDefault,
            screenCountHighJaku,
            screenCountKisu,
            screenCountGusu,
            screenCountHighMode,
            screenCountOverB,
            screenCountOverC,
            screenCountOverCKyo,
            screenCountOverD4,
            screenCountWhiteEdge,
        )
    }
    
    func resetScreen() {
        screenCountDefault = 0
        screenCountHighJaku = 0
        screenCountKisu = 0
        screenCountGusu = 0
        screenCountHighMode = 0
        screenCountOverB = 0
        screenCountOverC = 0
        screenCountOverCKyo = 0
        screenCountOverD4 = 0
        screenCountWhiteEdge = 0
        screenCountSum = 0
        minusCheck = false
    }
    
    // ---------
    // AT中
    // ---------
    let ratioReboot: [Double] = [3.3,4.6,5.8,7.1,8.3,9.6]
    @AppStorage("kokakukidotaiRebootCountMiss") var rebootCountMiss: Int = 0
    @AppStorage("kokakukidotaiRebootCountSuccess") var rebootCountSuccess: Int = 0
    @AppStorage("kokakukidotaiRebootCountSum") var rebootCountSum: Int = 0
    
    func rebootSumFunc() {
        rebootCountSum = rebootCountMiss + rebootCountSuccess
    }
    
    func resetAt() {
        rebootCountMiss = 0
        rebootCountSuccess = 0
        rebootCountSum = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "攻殻機動隊"
    @AppStorage("kokakukidotaiMinusCheck") var minusCheck: Bool = false
    @AppStorage("kokakukidotaiSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetFirstHit()
        resetAt()
        resetNormal()
        resetScreen()
    }
}

class KokakukidotaiMemory1: ObservableObject {
    @AppStorage("kokakukidotaiIedeCountMissMemory1") var iedeCountMiss: Int = 0
    @AppStorage("kokakukidotaiIedeCountSuccessMemory1") var iedeCountSuccess: Int = 0
    @AppStorage("kokakukidotaiIedeCountSumMemory1") var iedeCountSum: Int = 0
    @AppStorage("kokakukidotaiNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("kokakukidotaiFirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("kokakukidotaiFirstHitCountCzMemory1") var firstHitCountCz: Int = 0
    @AppStorage("kokakukidotaiScreenCountDefaultMemory1") var screenCountDefault: Int = 0
    @AppStorage("kokakukidotaiScreenCountHighJakuMemory1") var screenCountHighJaku: Int = 0
    @AppStorage("kokakukidotaiScreenCountKisuMemory1") var screenCountKisu: Int = 0
    @AppStorage("kokakukidotaiScreenCountGusuMemory1") var screenCountGusu: Int = 0
    @AppStorage("kokakukidotaiScreenCountHighModeMemory1") var screenCountHighMode: Int = 0
    @AppStorage("kokakukidotaiScreenCountOverBMemory1") var screenCountOverB: Int = 0
    @AppStorage("kokakukidotaiScreenCountOverCMemory1") var screenCountOverC: Int = 0
    @AppStorage("kokakukidotaiScreenCountOverCKyoMemory1") var screenCountOverCKyo: Int = 0
    @AppStorage("kokakukidotaiScreenCountOverD4Memory1") var screenCountOverD4: Int = 0
    @AppStorage("kokakukidotaiScreenCountWhiteEdgeMemory1") var screenCountWhiteEdge: Int = 0
    @AppStorage("kokakukidotaiScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("kokakukidotaiRebootCountMissMemory1") var rebootCountMiss: Int = 0
    @AppStorage("kokakukidotaiRebootCountSuccessMemory1") var rebootCountSuccess: Int = 0
    @AppStorage("kokakukidotaiRebootCountSumMemory1") var rebootCountSum: Int = 0
    @AppStorage("kokakukidotaiMemoMemory1") var memo = ""
    @AppStorage("kokakukidotaiDateMemory1") var dateDouble = 0.0
}


class KokakukidotaiMemory2: ObservableObject {
    @AppStorage("kokakukidotaiIedeCountMissMemory2") var iedeCountMiss: Int = 0
    @AppStorage("kokakukidotaiIedeCountSuccessMemory2") var iedeCountSuccess: Int = 0
    @AppStorage("kokakukidotaiIedeCountSumMemory2") var iedeCountSum: Int = 0
    @AppStorage("kokakukidotaiNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("kokakukidotaiFirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("kokakukidotaiFirstHitCountCzMemory2") var firstHitCountCz: Int = 0
    @AppStorage("kokakukidotaiScreenCountDefaultMemory2") var screenCountDefault: Int = 0
    @AppStorage("kokakukidotaiScreenCountHighJakuMemory2") var screenCountHighJaku: Int = 0
    @AppStorage("kokakukidotaiScreenCountKisuMemory2") var screenCountKisu: Int = 0
    @AppStorage("kokakukidotaiScreenCountGusuMemory2") var screenCountGusu: Int = 0
    @AppStorage("kokakukidotaiScreenCountHighModeMemory2") var screenCountHighMode: Int = 0
    @AppStorage("kokakukidotaiScreenCountOverBMemory2") var screenCountOverB: Int = 0
    @AppStorage("kokakukidotaiScreenCountOverCMemory2") var screenCountOverC: Int = 0
    @AppStorage("kokakukidotaiScreenCountOverCKyoMemory2") var screenCountOverCKyo: Int = 0
    @AppStorage("kokakukidotaiScreenCountOverD4Memory2") var screenCountOverD4: Int = 0
    @AppStorage("kokakukidotaiScreenCountWhiteEdgeMemory2") var screenCountWhiteEdge: Int = 0
    @AppStorage("kokakukidotaiScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("kokakukidotaiRebootCountMissMemory2") var rebootCountMiss: Int = 0
    @AppStorage("kokakukidotaiRebootCountSuccessMemory2") var rebootCountSuccess: Int = 0
    @AppStorage("kokakukidotaiRebootCountSumMemory2") var rebootCountSum: Int = 0
    @AppStorage("kokakukidotaiMemoMemory2") var memo = ""
    @AppStorage("kokakukidotaiDateMemory2") var dateDouble = 0.0
}


class KokakukidotaiMemory3: ObservableObject {
    @AppStorage("kokakukidotaiIedeCountMissMemory3") var iedeCountMiss: Int = 0
    @AppStorage("kokakukidotaiIedeCountSuccessMemory3") var iedeCountSuccess: Int = 0
    @AppStorage("kokakukidotaiIedeCountSumMemory3") var iedeCountSum: Int = 0
    @AppStorage("kokakukidotaiNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("kokakukidotaiFirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("kokakukidotaiFirstHitCountCzMemory3") var firstHitCountCz: Int = 0
    @AppStorage("kokakukidotaiScreenCountDefaultMemory3") var screenCountDefault: Int = 0
    @AppStorage("kokakukidotaiScreenCountHighJakuMemory3") var screenCountHighJaku: Int = 0
    @AppStorage("kokakukidotaiScreenCountKisuMemory3") var screenCountKisu: Int = 0
    @AppStorage("kokakukidotaiScreenCountGusuMemory3") var screenCountGusu: Int = 0
    @AppStorage("kokakukidotaiScreenCountHighModeMemory3") var screenCountHighMode: Int = 0
    @AppStorage("kokakukidotaiScreenCountOverBMemory3") var screenCountOverB: Int = 0
    @AppStorage("kokakukidotaiScreenCountOverCMemory3") var screenCountOverC: Int = 0
    @AppStorage("kokakukidotaiScreenCountOverCKyoMemory3") var screenCountOverCKyo: Int = 0
    @AppStorage("kokakukidotaiScreenCountOverD4Memory3") var screenCountOverD4: Int = 0
    @AppStorage("kokakukidotaiScreenCountWhiteEdgeMemory3") var screenCountWhiteEdge: Int = 0
    @AppStorage("kokakukidotaiScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("kokakukidotaiRebootCountMissMemory3") var rebootCountMiss: Int = 0
    @AppStorage("kokakukidotaiRebootCountSuccessMemory3") var rebootCountSuccess: Int = 0
    @AppStorage("kokakukidotaiRebootCountSumMemory3") var rebootCountSum: Int = 0
    @AppStorage("kokakukidotaiMemoMemory3") var memo = ""
    @AppStorage("kokakukidotaiDateMemory3") var dateDouble = 0.0
}
