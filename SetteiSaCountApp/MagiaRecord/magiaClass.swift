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
        resetKokakuStart()
        resetEnding()
    }
    
    // ///////////////////////
    // ver2.8.0で追加
    // ///////////////////////
    
    // //////////////
    // 高確スタート
    // //////////////
    @AppStorage("magiaKokakuStartAfterAtCountNone") var kokakuStartAfterAtCountNone: Int = 0 {
        didSet {
            kokakuStartAfterAtCountSum = countSum(kokakuStartAfterAtCountNone, kokakuStartAfterAtCountHit)
        }
    }
        @AppStorage("magiaKokakuStartAfterAtCountHit") var kokakuStartAfterAtCountHit: Int = 0 {
            didSet {
                kokakuStartAfterAtCountSum = countSum(kokakuStartAfterAtCountNone, kokakuStartAfterAtCountHit)
            }
        }
    @AppStorage("magiaKokakuStartAfterAtCountSum") var kokakuStartAfterAtCountSum: Int = 0
    @AppStorage("magiaKokakuStartAfterBonusCountNone") var kokakuStartAfterBonusCountNone: Int = 0 {
        didSet {
            kokakuStartAfterBonusCountSum = countSum(kokakuStartAfterBonusCountNone, kokakuStartAfterBonusCountHit)
        }
    }
        @AppStorage("magiaKokakuStartAfterBonusCountHit") var kokakuStartAfterBonusCountHit: Int = 0 {
            didSet {
                kokakuStartAfterBonusCountSum = countSum(kokakuStartAfterBonusCountNone, kokakuStartAfterBonusCountHit)
            }
        }
    @AppStorage("magiaKokakuStartAfterBonusCountSum") var kokakuStartAfterBonusCountSum: Int = 0
    
    let ratioKokakuStartAfterAtTotal: [Double] = [25,25,27.7,29.3,30.5,33.7]
    let ratioKokakuStartAfterAt10G: [Double] = [14.1,14.1,15.6,16.4,17.2,18.8]
    let ratioKokakuStartAfterAt20G: [Double] = [7.8,7.8,8.6,9.0,9.4,10.2]
    let ratioKokakuStartAfterAt30G: [Double] = [3.1,3.1,3.5,3.9,3.9,4.7]
    let ratioKokakuStartAfterBonusTotal: [Double] = [33.7,33.7,36.4,40.6,45.3,50.0]
    let ratioKokakuStartAfterBonus10G: [Double] = [18.8,18.8,20.3,22.7,25.0,27.3]
    let ratioKokakuStartAfterBonus20G: [Double] = [13.3,13.3,14.1,15.6,17.2,18.8]
    let ratioKokakuStartAfterBonus30G: [Double] = [1.6,1.6,2.0,2.3,3.1,3.9]
    
    func resetKokakuStart() {
        kokakuStartAfterAtCountNone = 0
        kokakuStartAfterAtCountHit = 0
        kokakuStartAfterBonusCountNone = 0
        kokakuStartAfterBonusCountHit = 0
        minusCheck = false
    }
    
    // ///////////////////
    // エンディング
    // ///////////////////
    @AppStorage("magiaEndingCountKisu") var endingCountKisu: Int = 0 {
        didSet {
            endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountHigh)
        }
    }
        @AppStorage("magiaEndingCountGusu") var endingCountGusu: Int = 0 {
            didSet {
                endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountHigh)
            }
        }
            @AppStorage("magiaEndingCountHigh") var endingCountHigh: Int = 0 {
                didSet {
                    endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountHigh)
                }
            }
    @AppStorage("magiaEndingCountSum") var endingCountSum: Int = 0
    
    func resetEnding() {
        endingCountKisu = 0
        endingCountGusu = 0
        endingCountHigh = 0
        minusCheck = false
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
    
    // ///////////////////////
    // ver2.8.0で追加
    // ///////////////////////
    @AppStorage("magiaKokakuStartAfterAtCountNoneMemory1") var kokakuStartAfterAtCountNone: Int = 0
    @AppStorage("magiaKokakuStartAfterAtCountHitMemory1") var kokakuStartAfterAtCountHit: Int = 0
    @AppStorage("magiaKokakuStartAfterAtCountSumMemory1") var kokakuStartAfterAtCountSum: Int = 0
    @AppStorage("magiaKokakuStartAfterBonusCountNoneMemory1") var kokakuStartAfterBonusCountNone: Int = 0
    @AppStorage("magiaKokakuStartAfterBonusCountHitMemory1") var kokakuStartAfterBonusCountHit: Int = 0
    @AppStorage("magiaKokakuStartAfterBonusCountSumMemory1") var kokakuStartAfterBonusCountSum: Int = 0
    @AppStorage("magiaEndingCountKisuMemory1") var endingCountKisu: Int = 0
    @AppStorage("magiaEndingCountGusuMemory1") var endingCountGusu: Int = 0
    @AppStorage("magiaEndingCountHighMemory1") var endingCountHigh: Int = 0
    @AppStorage("magiaEndingCountSumMemory1") var endingCountSum: Int = 0
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
    
    // ///////////////////////
    // ver2.8.0で追加
    // ///////////////////////
    @AppStorage("magiaKokakuStartAfterAtCountNoneMemory2") var kokakuStartAfterAtCountNone: Int = 0
    @AppStorage("magiaKokakuStartAfterAtCountHitMemory2") var kokakuStartAfterAtCountHit: Int = 0
    @AppStorage("magiaKokakuStartAfterAtCountSumMemory2") var kokakuStartAfterAtCountSum: Int = 0
    @AppStorage("magiaKokakuStartAfterBonusCountNoneMemory2") var kokakuStartAfterBonusCountNone: Int = 0
    @AppStorage("magiaKokakuStartAfterBonusCountHitMemory2") var kokakuStartAfterBonusCountHit: Int = 0
    @AppStorage("magiaKokakuStartAfterBonusCountSumMemory2") var kokakuStartAfterBonusCountSum: Int = 0
    @AppStorage("magiaEndingCountKisuMemory2") var endingCountKisu: Int = 0
    @AppStorage("magiaEndingCountGusuMemory2") var endingCountGusu: Int = 0
    @AppStorage("magiaEndingCountHighMemory2") var endingCountHigh: Int = 0
    @AppStorage("magiaEndingCountSumMemory2") var endingCountSum: Int = 0
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
    
    // ///////////////////////
    // ver2.8.0で追加
    // ///////////////////////
    @AppStorage("magiaKokakuStartAfterAtCountNoneMemory3") var kokakuStartAfterAtCountNone: Int = 0
    @AppStorage("magiaKokakuStartAfterAtCountHitMemory3") var kokakuStartAfterAtCountHit: Int = 0
    @AppStorage("magiaKokakuStartAfterAtCountSumMemory3") var kokakuStartAfterAtCountSum: Int = 0
    @AppStorage("magiaKokakuStartAfterBonusCountNoneMemory3") var kokakuStartAfterBonusCountNone: Int = 0
    @AppStorage("magiaKokakuStartAfterBonusCountHitMemory3") var kokakuStartAfterBonusCountHit: Int = 0
    @AppStorage("magiaKokakuStartAfterBonusCountSumMemory3") var kokakuStartAfterBonusCountSum: Int = 0
    @AppStorage("magiaEndingCountKisuMemory3") var endingCountKisu: Int = 0
    @AppStorage("magiaEndingCountGusuMemory3") var endingCountGusu: Int = 0
    @AppStorage("magiaEndingCountHighMemory3") var endingCountHigh: Int = 0
    @AppStorage("magiaEndingCountSumMemory3") var endingCountSum: Int = 0
}
