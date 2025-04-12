//
//  kaijiClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/22.
//

import Foundation
import SwiftUI


class Kaiji: ObservableObject {
    // ////////////////////////
    // ざわ高確
    // ////////////////////////
    @AppStorage("kaijiZawaKokakuCountJakuRare") var zawaKokakuCountJakuRare: Int = 0
    @AppStorage("kaijiZawaKokakuCountMove") var zawaKokakuCountMove: Int = 0
    let zawaKokakuRatio: [Double] = [
        25.0,
        25.0,
        26.6,
        28.9,
        30.1,
        30.9
    ]
    
    func resetZawaKokaku() {
        zawaKokakuCountJakuRare = 0
        zawaKokakuCountMove = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 閃き前兆
    // ////////////////////////
    @AppStorage("kaijiHiramekiCountBlueMiss") var hiramekiCountBlueMiss: Int = 0 {
        didSet {
            hiramekiCountBlueSum = countSum(hiramekiCountBlueMiss, hiramekiCountBlueSuccess)
        }
    }
        @AppStorage("kaijiHiramekiCountBlueSuccess") var hiramekiCountBlueSuccess: Int = 0 {
            didSet {
                hiramekiCountBlueSum = countSum(hiramekiCountBlueMiss, hiramekiCountBlueSuccess)
            }
        }
    @AppStorage("kaijiHiramekiCountBlueSum") var hiramekiCountBlueSum: Int = 0
    @AppStorage("kaijiHiramekiCountYellowMiss") var hiramekiCountYellowMiss: Int = 0 {
        didSet {
            hiramekiCountYellowSum = countSum(hiramekiCountYellowMiss, hiramekiCountYellowSuccess)
        }
    }
        @AppStorage("kaijiHiramekiCountYellowSuccess") var hiramekiCountYellowSuccess: Int = 0 {
            didSet {
                hiramekiCountYellowSum = countSum(hiramekiCountYellowMiss, hiramekiCountYellowSuccess)
            }
        }
    @AppStorage("kaijiHiramekiCountYellowSum") var hiramekiCountYellowSum: Int = 0
    @AppStorage("kaijiHiramekiCountGreenMiss") var hiramekiCountGreenMiss: Int = 0 {
        didSet {
            hiramekiCountGreenSum = countSum(hiramekiCountGreenMiss, hiramekiCountGreenSuccess)
        }
    }
        @AppStorage("kaijiHiramekiCountGreenSuccess") var hiramekiCountGreenSuccess: Int = 0 {
            didSet {
                hiramekiCountGreenSum = countSum(hiramekiCountGreenMiss, hiramekiCountGreenSuccess)
            }
        }
    @AppStorage("kaijiHiramekiCountGreenSum") var hiramekiCountGreenSum: Int = 0
    @AppStorage("kaijiHiramekiCountRedMiss") var hiramekiCountRedMiss: Int = 0 {
        didSet {
            hiramekiCountRedSum = countSum(hiramekiCountRedMiss, hiramekiCountRedSuccess)
        }
    }
        @AppStorage("kaijiHiramekiCountRedSuccess") var hiramekiCountRedSuccess: Int = 0 {
            didSet {
                hiramekiCountRedSum = countSum(hiramekiCountRedMiss, hiramekiCountRedSuccess)
            }
        }
    @AppStorage("kaijiHiramekiCountRedSum") var hiramekiCountRedSum: Int = 0
    
    let ratioHiramekiBlue: [Double] = [
        15,
        -1,
        -1,
        -1,
        -1,
        -1
    ]
    
    let ratioHiramekiYellow: [Double] = [
        30,
        -1,
        -1,
        -1,
        -1,
        -1
    ]
    let ratioHiramekiGreen: [Double] = [
        50,
        -1,
        -1,
        -1,
        -1,
        -1
    ]
    let ratioHiramekiRed: [Double] = [
        85,
        -1,
        -1,
        -1,
        -1,
        -1
    ]
    func resetHirameki() {
        hiramekiCountBlueMiss = 0
        hiramekiCountBlueSuccess = 0
        hiramekiCountYellowMiss = 0
        hiramekiCountYellowSuccess = 0
        hiramekiCountGreenMiss = 0
        hiramekiCountGreenSuccess = 0
        hiramekiCountRedMiss = 0
        hiramekiCountRedSuccess = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // CZ,AT初当り
    // ////////////////////////
    @AppStorage("kaijiPlayNormalGame") var playNormalGame: Int = 0
    @AppStorage("kaijiczCount") var czCount: Int = 0
    @AppStorage("kaijiatCount") var atCount: Int = 0
    
    let ratioCz: [Double] = [
        243.3,
        -1,
        -1,
        -1,
        -1,
        -1
    ]
    let ratioBonus: [Double] = [
        384.9,
        376.0,
        360.0,
        324.6,
        304.2,
        290.6
    ]
    func resetFirstHit() {
        playNormalGame = 0
        czCount = 0
        atCount = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // ボーナス終了画面
    // ////////////////////////
    @AppStorage("kaijiScreenCountDefault") var screenCountDefault: Int = 0 {
        didSet {
            screenCountSum = countSum(screenCountDefault, screenCountGusu, screenCountShower, screenCountOver2, screenCountTonegawa, screenCountHancho, screenCountMikoko, screenCountBunny)
        }
    }
        @AppStorage("kaijiScreenCountGusu") var screenCountGusu: Int = 0 {
            didSet {
                screenCountSum = countSum(screenCountDefault, screenCountGusu, screenCountShower, screenCountOver2, screenCountTonegawa, screenCountHancho, screenCountMikoko, screenCountBunny)
            }
        }
            @AppStorage("kaijiScreenCountShower") var screenCountShower: Int = 0 {
                didSet {
                    screenCountSum = countSum(screenCountDefault, screenCountGusu, screenCountShower, screenCountOver2, screenCountTonegawa, screenCountHancho, screenCountMikoko, screenCountBunny)
                }
            }
                @AppStorage("kaijiScreenCountOver2") var screenCountOver2: Int = 0 {
                    didSet {
                        screenCountSum = countSum(screenCountDefault, screenCountGusu, screenCountShower, screenCountOver2, screenCountTonegawa, screenCountHancho, screenCountMikoko, screenCountBunny)
                    }
                }
                    @AppStorage("kaijiScreenCountTonegawa") var screenCountTonegawa: Int = 0 {
                        didSet {
                            screenCountSum = countSum(screenCountDefault, screenCountGusu, screenCountShower, screenCountOver2, screenCountTonegawa, screenCountHancho, screenCountMikoko, screenCountBunny)
                        }
                    }
                        @AppStorage("kaijiScreenCountHancho") var screenCountHancho: Int = 0 {
                            didSet {
                                screenCountSum = countSum(screenCountDefault, screenCountGusu, screenCountShower, screenCountOver2, screenCountTonegawa, screenCountHancho, screenCountMikoko, screenCountBunny)
                            }
                        }
                            @AppStorage("kaijiScreenCountMikoko") var screenCountMikoko: Int = 0 {
                                didSet {
                                    screenCountSum = countSum(screenCountDefault, screenCountGusu, screenCountShower, screenCountOver2, screenCountTonegawa, screenCountHancho, screenCountMikoko, screenCountBunny)
                                }
                            }
                                @AppStorage("kaijiScreenCountBunny") var screenCountBunny: Int = 0 {
                                    didSet {
                                        screenCountSum = countSum(screenCountDefault, screenCountGusu, screenCountShower, screenCountOver2, screenCountTonegawa, screenCountHancho, screenCountMikoko, screenCountBunny)
                                    }
                                }
    @AppStorage("kaijiScreenCountSenyo") var screenCountSenyo: Int = 0
    @AppStorage("kaijiScreenCountSum") var screenCountSum: Int = 0
    
    func resetScreen() {
        screenCountDefault = 0
        screenCountGusu = 0
        screenCountShower = 0
        screenCountOver2 = 0
        screenCountTonegawa = 0
        screenCountHancho = 0
        screenCountMikoko = 0
        screenCountBunny = 0
        screenCountSenyo = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // エンディング
    // ////////////////////////
    @AppStorage("kaijiEndingCountKisu") var endingCountKisu: Int = 0 {
        didSet {
            endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountMaryoku, endingCountOver4, endingCountTeiai)
        }
    }
        @AppStorage("kaijiEndingCountGusu") var endingCountGusu: Int = 0 {
            didSet {
                endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountMaryoku, endingCountOver4, endingCountTeiai)
            }
        }
            @AppStorage("kaijiEndingCountMaryoku") var endingCountMaryoku: Int = 0 {
                didSet {
                    endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountMaryoku, endingCountOver4, endingCountTeiai)
                }
            }
                @AppStorage("kaijiEndingCountOver4") var endingCountOver4: Int = 0 {
                    didSet {
                        endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountMaryoku, endingCountOver4, endingCountTeiai)
                    }
                }
                    @AppStorage("kaijiEndingCountTeiai") var endingCountTeiai: Int = 0 {
                        didSet {
                            endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountMaryoku, endingCountOver4, endingCountTeiai)
                        }
                    }
    @AppStorage("kaijiEndingCountSum") var endingCountSum: Int = 0
    func resetEnding() {
        endingCountKisu = 0
        endingCountGusu = 0
        endingCountMaryoku = 0
        endingCountOver4 = 0
        endingCountTeiai = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("kaijiMinusCheck") var minusCheck: Bool = false
    @AppStorage("kaijiSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetZawaKokaku()
        resetHirameki()
        resetFirstHit()
        resetScreen()
        resetEnding()
        resetKoyaku()
    }
    
    // /////////////////////
    // 小役、ver271で追加
    // /////////////////////
    @AppStorage("kaijiTotalGame") var totalGame: Int = 0
    @AppStorage("kaijiKoyakuCountSuika") var koyakuCountSuika: Int = 0 {
        didSet {
            koyakuCountSum = countSum(koyakuCountSuika, koyakuCountJakuCherry, koyakuCountJakuChance, koyakuCountKyoCherry)
        }
    }
        @AppStorage("kaijiKoyakuCountJakuCherry") var koyakuCountJakuCherry: Int = 0 {
            didSet {
                koyakuCountSum = countSum(koyakuCountSuika, koyakuCountJakuCherry, koyakuCountJakuChance, koyakuCountKyoCherry)
            }
        }
            @AppStorage("kaijiKoyakuCountJakuChance") var koyakuCountJakuChance: Int = 0 {
                didSet {
                    koyakuCountSum = countSum(koyakuCountSuika, koyakuCountJakuCherry, koyakuCountJakuChance, koyakuCountKyoCherry)
                }
            }
                @AppStorage("kaijiKoyakuCountKyoCherry") var koyakuCountKyoCherry: Int = 0 {
                    didSet {
                        koyakuCountSum = countSum(koyakuCountSuika, koyakuCountJakuCherry, koyakuCountJakuChance, koyakuCountKyoCherry)
                    }
                }
    @AppStorage("kaijiKoyakuCountSum") var koyakuCountSum: Int = 0
    let ratioKoyakuSuika: [Double] = [79.9, 79.0, 78.0, 77.1, 75.3, 72.8]
    let ratioKoyakuJakuCherry: [Double] = [218.5, 211.4, 204.8, 198.6, 187.2, 182.0]
    let ratioKoyakuJakuChance: [Double] = [84.0, 81.9, 79.9, 79.0, 78.0, 77.1]
    let ratioKoyakuKyoCherry: [Double] = [528.5, 512.0, 496.5, 481.9, 468.1, 455.1]
    let ratioKoyakuSum: [Double] = [32.37, 31.69, 31.02, 30.54, 29.78, 29.07]
    
    func resetKoyaku() {
        totalGame = 0
        koyakuCountSuika = 0
        koyakuCountJakuCherry = 0
        koyakuCountJakuChance = 0
        koyakuCountKyoCherry = 0
        minusCheck = false
    }
    
}


// //// メモリー1
class KaijiMemory1: ObservableObject {
    @AppStorage("kaijiZawaKokakuCountJakuRareMemory1") var zawaKokakuCountJakuRare: Int = 0
    @AppStorage("kaijiZawaKokakuCountMoveMemory1") var zawaKokakuCountMove: Int = 0
    @AppStorage("kaijiHiramekiCountBlueMissMemory1") var hiramekiCountBlueMiss: Int = 0
    @AppStorage("kaijiHiramekiCountBlueSuccessMemory1") var hiramekiCountBlueSuccess: Int = 0
    @AppStorage("kaijiHiramekiCountBlueSumMemory1") var hiramekiCountBlueSum: Int = 0
    @AppStorage("kaijiHiramekiCountYellowMissMemory1") var hiramekiCountYellowMiss: Int = 0
    @AppStorage("kaijiHiramekiCountYellowSuccessMemory1") var hiramekiCountYellowSuccess: Int = 0
    @AppStorage("kaijiHiramekiCountYellowSumMemory1") var hiramekiCountYellowSum: Int = 0
    @AppStorage("kaijiHiramekiCountGreenMissMemory1") var hiramekiCountGreenMiss: Int = 0
    @AppStorage("kaijiHiramekiCountGreenSuccessMemory1") var hiramekiCountGreenSuccess: Int = 0
    @AppStorage("kaijiHiramekiCountGreenSumMemory1") var hiramekiCountGreenSum: Int = 0
    @AppStorage("kaijiHiramekiCountRedMissMemory1") var hiramekiCountRedMiss: Int = 0
    @AppStorage("kaijiHiramekiCountRedSuccessMemory1") var hiramekiCountRedSuccess: Int = 0
    @AppStorage("kaijiHiramekiCountRedSumMemory1") var hiramekiCountRedSum: Int = 0
    @AppStorage("kaijiPlayNormalGameMemory1") var playNormalGame: Int = 0
    @AppStorage("kaijiczCountMemory1") var czCount: Int = 0
    @AppStorage("kaijiatCountMemory1") var atCount: Int = 0
    @AppStorage("kaijiScreenCountDefaultMemory1") var screenCountDefault: Int = 0
    @AppStorage("kaijiScreenCountGusuMemory1") var screenCountGusu: Int = 0
    @AppStorage("kaijiScreenCountShowerMemory1") var screenCountShower: Int = 0
    @AppStorage("kaijiScreenCountOver2Memory1") var screenCountOver2: Int = 0
    @AppStorage("kaijiScreenCountTonegawaMemory1") var screenCountTonegawa: Int = 0
    @AppStorage("kaijiScreenCountHanchoMemory1") var screenCountHancho: Int = 0
    @AppStorage("kaijiScreenCountMikokoMemory1") var screenCountMikoko: Int = 0
    @AppStorage("kaijiScreenCountBunnyMemory1") var screenCountBunny: Int = 0
    @AppStorage("kaijiScreenCountSenyoMemory1") var screenCountSenyo: Int = 0
    @AppStorage("kaijiScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("kaijiEndingCountKisuMemory1") var endingCountKisu: Int = 0
    @AppStorage("kaijiEndingCountGusuMemory1") var endingCountGusu: Int = 0
    @AppStorage("kaijiEndingCountMaryokuMemory1") var endingCountMaryoku: Int = 0
    @AppStorage("kaijiEndingCountOver4Memory1") var endingCountOver4: Int = 0
    @AppStorage("kaijiEndingCountTeiaiMemory1") var endingCountTeiai: Int = 0
    @AppStorage("kaijiEndingCountSumMemory1") var endingCountSum: Int = 0
    @AppStorage("kaijiMemoMemory1") var memo = ""
    @AppStorage("kaijiDateMemory1") var dateDouble = 0.0
    
    // /////////////////////
    // 小役、ver271で追加
    // /////////////////////
    @AppStorage("kaijiTotalGameMemory1") var totalGame: Int = 0
    @AppStorage("kaijiKoyakuCountSuikaMemory1") var koyakuCountSuika: Int = 0
    @AppStorage("kaijiKoyakuCountJakuCherryMemory1") var koyakuCountJakuCherry: Int = 0
    @AppStorage("kaijiKoyakuCountJakuChanceMemory1") var koyakuCountJakuChance: Int = 0
    @AppStorage("kaijiKoyakuCountKyoCherryMemory1") var koyakuCountKyoCherry: Int = 0
    @AppStorage("kaijiKoyakuCountSumMemory1") var koyakuCountSum: Int = 0
}

// //// メモリー2
class KaijiMemory2: ObservableObject {
    @AppStorage("kaijiZawaKokakuCountJakuRareMemory2") var zawaKokakuCountJakuRare: Int = 0
    @AppStorage("kaijiZawaKokakuCountMoveMemory2") var zawaKokakuCountMove: Int = 0
    @AppStorage("kaijiHiramekiCountBlueMissMemory2") var hiramekiCountBlueMiss: Int = 0
    @AppStorage("kaijiHiramekiCountBlueSuccessMemory2") var hiramekiCountBlueSuccess: Int = 0
    @AppStorage("kaijiHiramekiCountBlueSumMemory2") var hiramekiCountBlueSum: Int = 0
    @AppStorage("kaijiHiramekiCountYellowMissMemory2") var hiramekiCountYellowMiss: Int = 0
    @AppStorage("kaijiHiramekiCountYellowSuccessMemory2") var hiramekiCountYellowSuccess: Int = 0
    @AppStorage("kaijiHiramekiCountYellowSumMemory2") var hiramekiCountYellowSum: Int = 0
    @AppStorage("kaijiHiramekiCountGreenMissMemory2") var hiramekiCountGreenMiss: Int = 0
    @AppStorage("kaijiHiramekiCountGreenSuccessMemory2") var hiramekiCountGreenSuccess: Int = 0
    @AppStorage("kaijiHiramekiCountGreenSumMemory2") var hiramekiCountGreenSum: Int = 0
    @AppStorage("kaijiHiramekiCountRedMissMemory2") var hiramekiCountRedMiss: Int = 0
    @AppStorage("kaijiHiramekiCountRedSuccessMemory2") var hiramekiCountRedSuccess: Int = 0
    @AppStorage("kaijiHiramekiCountRedSumMemory2") var hiramekiCountRedSum: Int = 0
    @AppStorage("kaijiPlayNormalGameMemory2") var playNormalGame: Int = 0
    @AppStorage("kaijiczCountMemory2") var czCount: Int = 0
    @AppStorage("kaijiatCountMemory2") var atCount: Int = 0
    @AppStorage("kaijiScreenCountDefaultMemory2") var screenCountDefault: Int = 0
    @AppStorage("kaijiScreenCountGusuMemory2") var screenCountGusu: Int = 0
    @AppStorage("kaijiScreenCountShowerMemory2") var screenCountShower: Int = 0
    @AppStorage("kaijiScreenCountOver2Memory2") var screenCountOver2: Int = 0
    @AppStorage("kaijiScreenCountTonegawaMemory2") var screenCountTonegawa: Int = 0
    @AppStorage("kaijiScreenCountHanchoMemory2") var screenCountHancho: Int = 0
    @AppStorage("kaijiScreenCountMikokoMemory2") var screenCountMikoko: Int = 0
    @AppStorage("kaijiScreenCountBunnyMemory2") var screenCountBunny: Int = 0
    @AppStorage("kaijiScreenCountSenyoMemory2") var screenCountSenyo: Int = 0
    @AppStorage("kaijiScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("kaijiEndingCountKisuMemory2") var endingCountKisu: Int = 0
    @AppStorage("kaijiEndingCountGusuMemory2") var endingCountGusu: Int = 0
    @AppStorage("kaijiEndingCountMaryokuMemory2") var endingCountMaryoku: Int = 0
    @AppStorage("kaijiEndingCountOver4Memory2") var endingCountOver4: Int = 0
    @AppStorage("kaijiEndingCountTeiaiMemory2") var endingCountTeiai: Int = 0
    @AppStorage("kaijiEndingCountSumMemory2") var endingCountSum: Int = 0
    @AppStorage("kaijiMemoMemory2") var memo = ""
    @AppStorage("kaijiDateMemory2") var dateDouble = 0.0
    
    // /////////////////////
    // 小役、ver271で追加
    // /////////////////////
    @AppStorage("kaijiTotalGameMemory2") var totalGame: Int = 0
    @AppStorage("kaijiKoyakuCountSuikaMemory2") var koyakuCountSuika: Int = 0
    @AppStorage("kaijiKoyakuCountJakuCherryMemory2") var koyakuCountJakuCherry: Int = 0
    @AppStorage("kaijiKoyakuCountJakuChanceMemory2") var koyakuCountJakuChance: Int = 0
    @AppStorage("kaijiKoyakuCountKyoCherryMemory2") var koyakuCountKyoCherry: Int = 0
    @AppStorage("kaijiKoyakuCountSumMemory2") var koyakuCountSum: Int = 0
}


// //// メモリー3
class KaijiMemory3: ObservableObject {
    @AppStorage("kaijiZawaKokakuCountJakuRareMemory3") var zawaKokakuCountJakuRare: Int = 0
    @AppStorage("kaijiZawaKokakuCountMoveMemory3") var zawaKokakuCountMove: Int = 0
    @AppStorage("kaijiHiramekiCountBlueMissMemory3") var hiramekiCountBlueMiss: Int = 0
    @AppStorage("kaijiHiramekiCountBlueSuccessMemory3") var hiramekiCountBlueSuccess: Int = 0
    @AppStorage("kaijiHiramekiCountBlueSumMemory3") var hiramekiCountBlueSum: Int = 0
    @AppStorage("kaijiHiramekiCountYellowMissMemory3") var hiramekiCountYellowMiss: Int = 0
    @AppStorage("kaijiHiramekiCountYellowSuccessMemory3") var hiramekiCountYellowSuccess: Int = 0
    @AppStorage("kaijiHiramekiCountYellowSumMemory3") var hiramekiCountYellowSum: Int = 0
    @AppStorage("kaijiHiramekiCountGreenMissMemory3") var hiramekiCountGreenMiss: Int = 0
    @AppStorage("kaijiHiramekiCountGreenSuccessMemory3") var hiramekiCountGreenSuccess: Int = 0
    @AppStorage("kaijiHiramekiCountGreenSumMemory3") var hiramekiCountGreenSum: Int = 0
    @AppStorage("kaijiHiramekiCountRedMissMemory3") var hiramekiCountRedMiss: Int = 0
    @AppStorage("kaijiHiramekiCountRedSuccessMemory3") var hiramekiCountRedSuccess: Int = 0
    @AppStorage("kaijiHiramekiCountRedSumMemory3") var hiramekiCountRedSum: Int = 0
    @AppStorage("kaijiPlayNormalGameMemory3") var playNormalGame: Int = 0
    @AppStorage("kaijiczCountMemory3") var czCount: Int = 0
    @AppStorage("kaijiatCountMemory3") var atCount: Int = 0
    @AppStorage("kaijiScreenCountDefaultMemory3") var screenCountDefault: Int = 0
    @AppStorage("kaijiScreenCountGusuMemory3") var screenCountGusu: Int = 0
    @AppStorage("kaijiScreenCountShowerMemory3") var screenCountShower: Int = 0
    @AppStorage("kaijiScreenCountOver2Memory3") var screenCountOver2: Int = 0
    @AppStorage("kaijiScreenCountTonegawaMemory3") var screenCountTonegawa: Int = 0
    @AppStorage("kaijiScreenCountHanchoMemory3") var screenCountHancho: Int = 0
    @AppStorage("kaijiScreenCountMikokoMemory3") var screenCountMikoko: Int = 0
    @AppStorage("kaijiScreenCountBunnyMemory3") var screenCountBunny: Int = 0
    @AppStorage("kaijiScreenCountSenyoMemory3") var screenCountSenyo: Int = 0
    @AppStorage("kaijiScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("kaijiEndingCountKisuMemory3") var endingCountKisu: Int = 0
    @AppStorage("kaijiEndingCountGusuMemory3") var endingCountGusu: Int = 0
    @AppStorage("kaijiEndingCountMaryokuMemory3") var endingCountMaryoku: Int = 0
    @AppStorage("kaijiEndingCountOver4Memory3") var endingCountOver4: Int = 0
    @AppStorage("kaijiEndingCountTeiaiMemory3") var endingCountTeiai: Int = 0
    @AppStorage("kaijiEndingCountSumMemory3") var endingCountSum: Int = 0
    @AppStorage("kaijiMemoMemory3") var memo = ""
    @AppStorage("kaijiDateMemory3") var dateDouble = 0.0
    
    // /////////////////////
    // 小役、ver271で追加
    // /////////////////////
    @AppStorage("kaijiTotalGameMemory3") var totalGame: Int = 0
    @AppStorage("kaijiKoyakuCountSuikaMemory3") var koyakuCountSuika: Int = 0
    @AppStorage("kaijiKoyakuCountJakuCherryMemory3") var koyakuCountJakuCherry: Int = 0
    @AppStorage("kaijiKoyakuCountJakuChanceMemory3") var koyakuCountJakuChance: Int = 0
    @AppStorage("kaijiKoyakuCountKyoCherryMemory3") var koyakuCountKyoCherry: Int = 0
    @AppStorage("kaijiKoyakuCountSumMemory3") var koyakuCountSum: Int = 0
}
