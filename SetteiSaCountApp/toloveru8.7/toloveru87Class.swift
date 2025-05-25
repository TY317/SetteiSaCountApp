//
//  toloveru87Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/19.
//

import Foundation
import SwiftUI

class Toloveru87: ObservableObject {
    // //////////////////
    // どきどきポイント
    // //////////////////
    @AppStorage("toloveru87DokiPtLeft") var dokiPtLeft: Int = 0
    @AppStorage("toloveru87DokiPtCenter") var dokiPtCenter: Int = 0
    @AppStorage("toloveru87DokiPtRight") var dokiPtRight: Int = 0
    
    func resetDokiDokiPoint() {
        dokiPtLeft = 0
        dokiPtCenter = 0
        dokiPtRight = 0
        minusCheck = false
    }
    
    func resetDokiDokiPointLeft() {
        dokiPtLeft = 0
    }
    func resetDokiDokiPointCenter() {
        dokiPtCenter = 0
    }
    func resetDokiDokiPointRight() {
        dokiPtRight = 0
    }
    
    // ///////////////////////
    // ハーレムモード
    // ///////////////////////
    let ratioWhisper: [Double] = [-100,3.1,3.6,6.0,7.1,11.9]
    @AppStorage("toloveru87HarlemWhisperCount") var harlemWhisperCount = 0 {
        didSet {
            harlemCountSum = countSum(harlemWhisperCount, harlemAisplush)
        }
    }
        @AppStorage("toloveru87HarlemAisplushCount") var harlemAisplush = 0 {
            didSet {
                harlemCountSum = countSum(harlemWhisperCount, harlemAisplush)
            }
        }
    @AppStorage("toloveru87HarlemCountSum") var harlemCountSum = 0
    
    func resetHarlem() {
        harlemWhisperCount = 0
        harlemAisplush = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("toloveru87MinusCheck") var minusCheck: Bool = false
    @AppStorage("toloveru87SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetDokiDokiPoint()
        resetHarlem()
    }
}


// //// メモリー1
class Toloveru87Memory1: ObservableObject {
    @AppStorage("toloveru87DokiPtLeftMemory1") var dokiPtLeft: Int = 0
    @AppStorage("toloveru87DokiPtCenterMemory1") var dokiPtCenter: Int = 0
    @AppStorage("toloveru87DokiPtRightMemory1") var dokiPtRight: Int = 0
    @AppStorage("toloveru87HarlemWhisperCountMemory1") var harlemWhisperCount = 0
    @AppStorage("toloveru87HarlemAisplushCountMemory1") var harlemAisplush = 0
    @AppStorage("toloveru87HarlemCountSumMemory1") var harlemCountSum = 0
    @AppStorage("toloveru87MemoMemory1") var memo = ""
    @AppStorage("toloveru87DateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class Toloveru87Memory2: ObservableObject {
    @AppStorage("toloveru87DokiPtLeftMemory2") var dokiPtLeft: Int = 0
    @AppStorage("toloveru87DokiPtCenterMemory2") var dokiPtCenter: Int = 0
    @AppStorage("toloveru87DokiPtRightMemory2") var dokiPtRight: Int = 0
    @AppStorage("toloveru87HarlemWhisperCountMemory2") var harlemWhisperCount = 0
    @AppStorage("toloveru87HarlemAisplushCountMemory2") var harlemAisplush = 0
    @AppStorage("toloveru87HarlemCountSumMemory2") var harlemCountSum = 0
    @AppStorage("toloveru87MemoMemory2") var memo = ""
    @AppStorage("toloveru87DateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class Toloveru87Memory3: ObservableObject {
    @AppStorage("toloveru87DokiPtLeftMemory3") var dokiPtLeft: Int = 0
    @AppStorage("toloveru87DokiPtCenterMemory3") var dokiPtCenter: Int = 0
    @AppStorage("toloveru87DokiPtRightMemory3") var dokiPtRight: Int = 0
    @AppStorage("toloveru87HarlemWhisperCountMemory3") var harlemWhisperCount = 0
    @AppStorage("toloveru87HarlemAisplushCountMemory3") var harlemAisplush = 0
    @AppStorage("toloveru87HarlemCountSumMemory3") var harlemCountSum = 0
    @AppStorage("toloveru87MemoMemory3") var memo = ""
    @AppStorage("toloveru87DateMemory3") var dateDouble = 0.0
}
