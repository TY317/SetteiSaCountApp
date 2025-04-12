//
//  magiaClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import Foundation
import SwiftUI
import TipKit

class Magia: ObservableObject {
    // ////////////////////////
    // 通常時
    // ////////////////////////
    let ratioJakuCherry: [Double] = [60,57.7,55.5,53.5,51.7,50]
    let ratioSuikaCz: [Double] = [19.9,22.3,24.6,27.3,30.1,32.8]
    @AppStorage("magiaSuikaCzCountSuika") var suikaCzCountSuika: Int = 0
    @AppStorage("magiaSuikaCzCountCz") var suikaCzCountCz: Int = 0
    
    func resetNormal() {
        suikaCzCountSuika = 0
        suikaCzCountCz = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // BIG終了画面
    // ////////////////////////
    @AppStorage("magiaBigScreenCountDefault") var bigScreenCountDefault: Int = 0 {
        didSet {
            bigScreenCountSum = countSum(bigScreenCount356, bigScreenCount246, bigScreenCountHigh1, bigScreenCountHigh2,bigScreenCountDefault)
        }
    }
        @AppStorage("magiaBigScreenCount356") var bigScreenCount356: Int = 0 {
            didSet {
                bigScreenCountSum = countSum(bigScreenCount356, bigScreenCount246, bigScreenCountHigh1, bigScreenCountHigh2,bigScreenCountDefault)
            }
        }
            @AppStorage("magiaBigScreenCount246") var bigScreenCount246: Int = 0 {
                didSet {
                    bigScreenCountSum = countSum(bigScreenCount356, bigScreenCount246, bigScreenCountHigh1, bigScreenCountHigh2,bigScreenCountDefault)
                }
            }
                @AppStorage("magiaBigScreenCountHigh1") var bigScreenCountHigh1: Int = 0 {
                    didSet {
                        bigScreenCountSum = countSum(bigScreenCount356, bigScreenCount246, bigScreenCountHigh1, bigScreenCountHigh2,bigScreenCountDefault)
                    }
                }
                    @AppStorage("magiaBigScreenCountHigh2") var bigScreenCountHigh2: Int = 0 {
                        didSet {
                            bigScreenCountSum = countSum(bigScreenCount356, bigScreenCount246, bigScreenCountHigh1, bigScreenCountHigh2,bigScreenCountDefault)
                        }
                    }
    @AppStorage("magiaBigScreenCountSum") var bigScreenCountSum: Int = 0
    
    func resetBigScreen() {
        bigScreenCountDefault = 0
        bigScreenCount356 = 0
        bigScreenCount246 = 0
        bigScreenCountHigh1 = 0
        bigScreenCountHigh2 = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 初当り
    // ////////////////////////
    let ratioBonus: [Double] = [240.6,236.1,222.8,208.5,195.1,184.3]
    let ratioAt: [Double] = [654.6,633.4,571.8,516.6,456.5,416.7]
    @AppStorage("magiaNormalPlayGame") var normalPlayGame: Int = 0
    @AppStorage("magiaBonusCountBig") var bonusCountBig : Int = 0 {
        didSet {
            bonusCountSum = countSum(bonusCountBig, bonusCountMitama, bonusCountEpisode)
        }
    }
        @AppStorage("magiaBonusCountMitama") var bonusCountMitama : Int = 0 {
            didSet {
                bonusCountSum = countSum(bonusCountBig, bonusCountMitama, bonusCountEpisode)
            }
        }
            @AppStorage("magiaBonusCountEpisode") var bonusCountEpisode : Int = 0 {
                didSet {
                    bonusCountSum = countSum(bonusCountBig, bonusCountMitama, bonusCountEpisode)
                }
            }
    @AppStorage("magiaBonusCountSum") var bonusCountSum : Int = 0
    @AppStorage("magiaAtCount") var atCount : Int = 0
    
    func resetFirstHit() {
        normalPlayGame = 0
        bonusCountBig = 0
        bonusCountMitama = 0
        bonusCountEpisode = 0
        atCount = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // AT終了画面
    // ////////////////////////
    @AppStorage("magiaAtScreenCountDefault") var atScreenCountDefault: Int = 0 {
        didSet {
            atScreenCountSum = countSum(atScreenCountDefault, atScreenCount356, atScreenCount246)
        }
    }
        @AppStorage("magiaAtScreenCount356") var atScreenCount356: Int = 0 {
            didSet {
                atScreenCountSum = countSum(atScreenCountDefault, atScreenCount356, atScreenCount246)
            }
        }
            @AppStorage("magiaAtScreenCount246") var atScreenCount246: Int = 0 {
                didSet {
                    atScreenCountSum = countSum(atScreenCountDefault, atScreenCount356, atScreenCount246)
                }
            }
    @AppStorage("magiaAtScreenCountSum") var atScreenCountSum: Int = 0
    
    func resetAtScreen() {
        atScreenCountDefault = 0
        atScreenCount356 = 0
        atScreenCount246 = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("magiaMinusCheck") var minusCheck: Bool = false
    @AppStorage("magiaSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetBigScreen()
        resetAtScreen()
        resetFirstHit()
    }
}


// //// メモリー1
class MagiaMemory1: ObservableObject {
    @AppStorage("magiaSuikaCzCountSuikaMemory1") var suikaCzCountSuika: Int = 0
    @AppStorage("magiaSuikaCzCountCzMemory1") var suikaCzCountCz: Int = 0
    @AppStorage("magiaBigScreenCountDefaultMemory1") var bigScreenCountDefault: Int = 0
    @AppStorage("magiaBigScreenCount356Memory1") var bigScreenCount356: Int = 0
    @AppStorage("magiaBigScreenCount246Memory1") var bigScreenCount246: Int = 0
    @AppStorage("magiaBigScreenCountHigh1Memory1") var bigScreenCountHigh1: Int = 0
    @AppStorage("magiaBigScreenCountHigh2Memory1") var bigScreenCountHigh2: Int = 0
    @AppStorage("magiaBigScreenCountSumMemory1") var bigScreenCountSum: Int = 0
    @AppStorage("magiaNormalPlayGameMemory1") var normalPlayGame: Int = 0
    @AppStorage("magiaBonusCountBigMemory1") var bonusCountBig : Int = 0
    @AppStorage("magiaBonusCountMitamaMemory1") var bonusCountMitama : Int = 0
    @AppStorage("magiaBonusCountEpisodeMemory1") var bonusCountEpisode : Int = 0
    @AppStorage("magiaBonusCountSumMemory1") var bonusCountSum : Int = 0
    @AppStorage("magiaAtCountMemory1") var atCount : Int = 0
    @AppStorage("magiaAtScreenCountDefaultMemory1") var atScreenCountDefault: Int = 0
    @AppStorage("magiaAtScreenCount356Memory1") var atScreenCount356: Int = 0
    @AppStorage("magiaAtScreenCount246Memory1") var atScreenCount246: Int = 0
    @AppStorage("magiaAtScreenCountSumMemory1") var atScreenCountSum: Int = 0
    @AppStorage("magiaMemoMemory1") var memo = ""
    @AppStorage("magiaDateMemory1") var dateDouble = 0.0
}


// //// メモリー2
class MagiaMemory2: ObservableObject {
    @AppStorage("magiaSuikaCzCountSuikaMemory2") var suikaCzCountSuika: Int = 0
    @AppStorage("magiaSuikaCzCountCzMemory2") var suikaCzCountCz: Int = 0
    @AppStorage("magiaBigScreenCountDefaultMemory2") var bigScreenCountDefault: Int = 0
    @AppStorage("magiaBigScreenCount356Memory2") var bigScreenCount356: Int = 0
    @AppStorage("magiaBigScreenCount246Memory2") var bigScreenCount246: Int = 0
    @AppStorage("magiaBigScreenCountHigh1Memory2") var bigScreenCountHigh1: Int = 0
    @AppStorage("magiaBigScreenCountHigh2Memory2") var bigScreenCountHigh2: Int = 0
    @AppStorage("magiaBigScreenCountSumMemory2") var bigScreenCountSum: Int = 0
    @AppStorage("magiaNormalPlayGameMemory2") var normalPlayGame: Int = 0
    @AppStorage("magiaBonusCountBigMemory2") var bonusCountBig : Int = 0
    @AppStorage("magiaBonusCountMitamaMemory2") var bonusCountMitama : Int = 0
    @AppStorage("magiaBonusCountEpisodeMemory2") var bonusCountEpisode : Int = 0
    @AppStorage("magiaBonusCountSumMemory2") var bonusCountSum : Int = 0
    @AppStorage("magiaAtCountMemory2") var atCount : Int = 0
    @AppStorage("magiaAtScreenCountDefaultMemory2") var atScreenCountDefault: Int = 0
    @AppStorage("magiaAtScreenCount356Memory2") var atScreenCount356: Int = 0
    @AppStorage("magiaAtScreenCount246Memory2") var atScreenCount246: Int = 0
    @AppStorage("magiaAtScreenCountSumMemory2") var atScreenCountSum: Int = 0
    @AppStorage("magiaMemoMemory2") var memo = ""
    @AppStorage("magiaDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class MagiaMemory3: ObservableObject {
    @AppStorage("magiaSuikaCzCountSuikaMemory3") var suikaCzCountSuika: Int = 0
    @AppStorage("magiaSuikaCzCountCzMemory3") var suikaCzCountCz: Int = 0
    @AppStorage("magiaBigScreenCountDefaultMemory3") var bigScreenCountDefault: Int = 0
    @AppStorage("magiaBigScreenCount356Memory3") var bigScreenCount356: Int = 0
    @AppStorage("magiaBigScreenCount246Memory3") var bigScreenCount246: Int = 0
    @AppStorage("magiaBigScreenCountHigh1Memory3") var bigScreenCountHigh1: Int = 0
    @AppStorage("magiaBigScreenCountHigh2Memory3") var bigScreenCountHigh2: Int = 0
    @AppStorage("magiaBigScreenCountSumMemory3") var bigScreenCountSum: Int = 0
    @AppStorage("magiaNormalPlayGameMemory3") var normalPlayGame: Int = 0
    @AppStorage("magiaBonusCountBigMemory3") var bonusCountBig : Int = 0
    @AppStorage("magiaBonusCountMitamaMemory3") var bonusCountMitama : Int = 0
    @AppStorage("magiaBonusCountEpisodeMemory3") var bonusCountEpisode : Int = 0
    @AppStorage("magiaBonusCountSumMemory3") var bonusCountSum : Int = 0
    @AppStorage("magiaAtCountMemory3") var atCount : Int = 0
    @AppStorage("magiaAtScreenCountDefaultMemory3") var atScreenCountDefault: Int = 0
    @AppStorage("magiaAtScreenCount356Memory3") var atScreenCount356: Int = 0
    @AppStorage("magiaAtScreenCount246Memory3") var atScreenCount246: Int = 0
    @AppStorage("magiaAtScreenCountSumMemory3") var atScreenCountSum: Int = 0
    @AppStorage("magiaMemoMemory3") var memo = ""
    @AppStorage("magiaDateMemory3") var dateDouble = 0.0
}
