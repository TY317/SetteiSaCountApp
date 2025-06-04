//
//  rslClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/24.
//

import Foundation
import SwiftUI

class Rsl: ObservableObject {
    // //////////////////////
    // 初当り
    // //////////////////////
//    @AppStorage("rslTotalGameStart") var totalGameStart: Int = 0 {
//        didSet {
//            if totalGameCurrent == 0 {
//                totalGameCurrent = totalGameStart
//            } else {
//                totalGamePlay = (totalGameCurrent - totalGameStart)>0 ? (totalGameCurrent - totalGameStart) : 0
//            }
//        }
//    }
//    @AppStorage("rslTotalGameCurrent") var totalGameCurrent: Int = 0 {
//        didSet {
//            totalGamePlay = (totalGameCurrent - totalGameStart)>0 ? (totalGameCurrent - totalGameStart) : 0
//        }
//    }
//    @AppStorage("rslTotalGamePlay") var totalGamePlay: Int = 0
    let settingList: [Int] = [1,2,4,5,6]
    let ratioBigSum: [Double] = [262.9, 260.8, 250.9, 247.2, 245.2]
    let ratioBigRed: [Double] = [583.0, 582.6, 584.0, 583.3, 585.8]
    let ratioBigBlue: [Double] = [479.0, 472.3, 440.0, 428.9, 421.8]
    let ratioReg: [Double] = [621.9, 604.3, 526.3, 499.7, 465.0]
    let ratioCz: [Double] = [265.9, 254.7, 207.6, 190.3, 179.5]
    let ratioAt: [Double] = [359.6, 346.8, 277.1, 255.7, 232.5]
    let ratioRegKirameki: [Double] = [7282, 6554, 4681, 4096, 3449]
    let ratioRegSuika: [Double] = [2731, 2521, 2114, 2048, 1771]
    let ratioRegChance: [Double] = [2341, 2341, 1820, 1638, 1560]
    let ratioReg3YakuSum: [Double] = [1074.5, 1024.1, 808.98, 744.6, 668.6]
    @AppStorage("rslTotalGame") var totalGame: Int = 0
    @AppStorage("rslNormalGame") var normalGame: Int = 0
    @AppStorage("rslBigCount") var bigCount: Int = 0
    @AppStorage("rslRegCount") var regCount: Int = 0
    @AppStorage("rslCzCount") var czCount: Int = 0
    @AppStorage("rslAtCount") var atCount: Int = 0
    @AppStorage("rslRegCountChance") var regCountChance: Int = 0 {
        didSet {
            regCount3YakuSum = countSum(regCountKirameki, regCountSuika, regCountChance)
        }
    }
        @AppStorage("rslRegCountKirameki") var regCountKirameki: Int = 0 {
            didSet {
                regCount3YakuSum = countSum(regCountKirameki, regCountSuika, regCountChance)
            }
        }
            @AppStorage("rslRegCountSuika") var regCountSuika: Int = 0 {
                didSet {
                    regCount3YakuSum = countSum(regCountKirameki, regCountSuika, regCountChance)
                }
            }
    @AppStorage("rslRegCount3YakuSum") var regCount3YakuSum: Int = 0
    
    func resetFirstHit() {
//        totalGameStart = 0
//        totalGameCurrent = 0
        totalGame = 0
        normalGame = 0
        bigCount = 0
        regCount = 0
        czCount = 0
        atCount = 0
        regCountChance = 0
        regCountKirameki = 0
        regCountSuika = 0
        minusCheck = false
    }
    
    
    // ///////////////////////
    // ボーナス終了画面
    // ///////////////////////
    @AppStorage("rslScreenCountDefault") var screenCountDefault: Int = 0 {
        didSet {
            screenCountSum = countSum(screenCountDefault, screenCountHighJaku, screenCountHighKyo, screenCountOver2, screenCountOver4, screenCountOver5, screenCountOver6)
        }
    }
        @AppStorage("rslScreenCountHighJaku") var screenCountHighJaku: Int = 0 {
            didSet {
                screenCountSum = countSum(screenCountDefault, screenCountHighJaku, screenCountHighKyo, screenCountOver2, screenCountOver4, screenCountOver5, screenCountOver6)
            }
        }
            @AppStorage("rslScreenCountHighKyo") var screenCountHighKyo: Int = 0 {
                didSet {
                    screenCountSum = countSum(screenCountDefault, screenCountHighJaku, screenCountHighKyo, screenCountOver2, screenCountOver4, screenCountOver5, screenCountOver6)
                }
            }
                @AppStorage("rslScreenCountOver2") var screenCountOver2: Int = 0 {
                    didSet {
                        screenCountSum = countSum(screenCountDefault, screenCountHighJaku, screenCountHighKyo, screenCountOver2, screenCountOver4, screenCountOver5, screenCountOver6)
                    }
                }
                    @AppStorage("rslScreenCountOver4") var screenCountOver4: Int = 0 {
                        didSet {
                            screenCountSum = countSum(screenCountDefault, screenCountHighJaku, screenCountHighKyo, screenCountOver2, screenCountOver4, screenCountOver5, screenCountOver6)
                        }
                    }
                        @AppStorage("rslScreenCountOver5") var screenCountOver5: Int = 0 {
                            didSet {
                                screenCountSum = countSum(screenCountDefault, screenCountHighJaku, screenCountHighKyo, screenCountOver2, screenCountOver4, screenCountOver5, screenCountOver6)
                            }
                        }
                            @AppStorage("rslScreenCountOver6") var screenCountOver6: Int = 0 {
                                didSet {
                                    screenCountSum = countSum(screenCountDefault, screenCountHighJaku, screenCountHighKyo, screenCountOver2, screenCountOver4, screenCountOver5, screenCountOver6)
                                }
                            }
    @AppStorage("rslScreenCountSum") var screenCountSum: Int = 0
    
    func resetScreen() {
        screenCountDefault = 0
        screenCountHighJaku = 0
        screenCountHighKyo = 0
        screenCountOver2 = 0
        screenCountOver4 = 0
        screenCountOver5 = 0
        screenCountOver6 = 0
        minusCheck = false
    }
    
    // ///////////////////////
    // AT終了後ボイス
    // ///////////////////////
    @AppStorage("rslVoiceCountDefault") var voiceCountDefault: Int = 0 {
        didSet {
            voiceCountSum = countSum(voiceCountDefault, voiceCountHighJaku, voiceCountHighKyo, voiceCountOver2, voiceCountOver4, voiceCountOver6)
        }
    }
        @AppStorage("rslVoiceCountHighJaku") var voiceCountHighJaku: Int = 0 {
            didSet {
                voiceCountSum = countSum(voiceCountDefault, voiceCountHighJaku, voiceCountHighKyo, voiceCountOver2, voiceCountOver4, voiceCountOver6)
            }
        }
            @AppStorage("rslVoiceCountHighKyo") var voiceCountHighKyo: Int = 0 {
                didSet {
                    voiceCountSum = countSum(voiceCountDefault, voiceCountHighJaku, voiceCountHighKyo, voiceCountOver2, voiceCountOver4, voiceCountOver6)
                }
            }
                @AppStorage("rslVoiceCountOver2") var voiceCountOver2: Int = 0 {
                    didSet {
                        voiceCountSum = countSum(voiceCountDefault, voiceCountHighJaku, voiceCountHighKyo, voiceCountOver2, voiceCountOver4, voiceCountOver6)
                    }
                }
                    @AppStorage("rslVoiceCountOver4") var voiceCountOver4: Int = 0 {
                        didSet {
                            voiceCountSum = countSum(voiceCountDefault, voiceCountHighJaku, voiceCountHighKyo, voiceCountOver2, voiceCountOver4, voiceCountOver6)
                        }
                    }
                        @AppStorage("rslVoiceCountOver6") var voiceCountOver6: Int = 0 {
                            didSet {
                                voiceCountSum = countSum(voiceCountDefault, voiceCountHighJaku, voiceCountHighKyo, voiceCountOver2, voiceCountOver4, voiceCountOver6)
                            }
                        }
    @AppStorage("rslVoiceCountSum") var voiceCountSum: Int = 0
    
    func resetVoice() {
        voiceCountDefault = 0
        voiceCountHighJaku = 0
        voiceCountHighKyo = 0
        voiceCountOver2 = 0
        voiceCountOver4 = 0
        voiceCountOver6 = 0
        minusCheck = false
    }
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("rslMinusCheck") var minusCheck: Bool = false
    @AppStorage("rslSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetVoice()
        resetScreen()
        resetFirstHit()
    }
}


class RslMemory1: ObservableObject {
    @AppStorage("rslTotalGameMemory1") var totalGame: Int = 0
    @AppStorage("rslNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("rslBigCountMemory1") var bigCount: Int = 0
    @AppStorage("rslRegCountMemory1") var regCount: Int = 0
    @AppStorage("rslCzCountMemory1") var czCount: Int = 0
    @AppStorage("rslAtCountMemory1") var atCount: Int = 0
    @AppStorage("rslRegCountChanceMemory1") var regCountChance: Int = 0
    @AppStorage("rslRegCountKiramekiMemory1") var regCountKirameki: Int = 0
    @AppStorage("rslRegCountSuikaMemory1") var regCountSuika: Int = 0
    @AppStorage("rslRegCount3YakuSumMemory1") var regCount3YakuSum: Int = 0
    @AppStorage("rslScreenCountDefaultMemory1") var screenCountDefault: Int = 0
    @AppStorage("rslScreenCountHighJakuMemory1") var screenCountHighJaku: Int = 0
    @AppStorage("rslScreenCountHighKyoMemory1") var screenCountHighKyo: Int = 0
    @AppStorage("rslScreenCountOver2Memory1") var screenCountOver2: Int = 0
    @AppStorage("rslScreenCountOver4Memory1") var screenCountOver4: Int = 0
    @AppStorage("rslScreenCountOver5Memory1") var screenCountOver5: Int = 0
    @AppStorage("rslScreenCountOver6Memory1") var screenCountOver6: Int = 0
    @AppStorage("rslScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("rslVoiceCountDefaultMemory1") var voiceCountDefault: Int = 0
    @AppStorage("rslVoiceCountHighJakuMemory1") var voiceCountHighJaku: Int = 0
    @AppStorage("rslVoiceCountHighKyoMemory1") var voiceCountHighKyo: Int = 0
    @AppStorage("rslVoiceCountOver2Memory1") var voiceCountOver2: Int = 0
    @AppStorage("rslVoiceCountOver4Memory1") var voiceCountOver4: Int = 0
    @AppStorage("rslVoiceCountOver6Memory1") var voiceCountOver6: Int = 0
    @AppStorage("rslVoiceCountSumMemory1") var voiceCountSum: Int = 0
    @AppStorage("rslMemoMemory1") var memo = ""
    @AppStorage("rslDateMemory1") var dateDouble = 0.0
}


class RslMemory2: ObservableObject {
    @AppStorage("rslTotalGameMemory2") var totalGame: Int = 0
    @AppStorage("rslNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("rslBigCountMemory2") var bigCount: Int = 0
    @AppStorage("rslRegCountMemory2") var regCount: Int = 0
    @AppStorage("rslCzCountMemory2") var czCount: Int = 0
    @AppStorage("rslAtCountMemory2") var atCount: Int = 0
    @AppStorage("rslRegCountChanceMemory2") var regCountChance: Int = 0
    @AppStorage("rslRegCountKiramekiMemory2") var regCountKirameki: Int = 0
    @AppStorage("rslRegCountSuikaMemory2") var regCountSuika: Int = 0
    @AppStorage("rslRegCount3YakuSumMemory2") var regCount3YakuSum: Int = 0
    @AppStorage("rslScreenCountDefaultMemory2") var screenCountDefault: Int = 0
    @AppStorage("rslScreenCountHighJakuMemory2") var screenCountHighJaku: Int = 0
    @AppStorage("rslScreenCountHighKyoMemory2") var screenCountHighKyo: Int = 0
    @AppStorage("rslScreenCountOver2Memory2") var screenCountOver2: Int = 0
    @AppStorage("rslScreenCountOver4Memory2") var screenCountOver4: Int = 0
    @AppStorage("rslScreenCountOver5Memory2") var screenCountOver5: Int = 0
    @AppStorage("rslScreenCountOver6Memory2") var screenCountOver6: Int = 0
    @AppStorage("rslScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("rslVoiceCountDefaultMemory2") var voiceCountDefault: Int = 0
    @AppStorage("rslVoiceCountHighJakuMemory2") var voiceCountHighJaku: Int = 0
    @AppStorage("rslVoiceCountHighKyoMemory2") var voiceCountHighKyo: Int = 0
    @AppStorage("rslVoiceCountOver2Memory2") var voiceCountOver2: Int = 0
    @AppStorage("rslVoiceCountOver4Memory2") var voiceCountOver4: Int = 0
    @AppStorage("rslVoiceCountOver6Memory2") var voiceCountOver6: Int = 0
    @AppStorage("rslVoiceCountSumMemory2") var voiceCountSum: Int = 0
    @AppStorage("rslMemoMemory2") var memo = ""
    @AppStorage("rslDateMemory2") var dateDouble = 0.0
}


class RslMemory3: ObservableObject {
    @AppStorage("rslTotalGameMemory3") var totalGame: Int = 0
    @AppStorage("rslNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("rslBigCountMemory3") var bigCount: Int = 0
    @AppStorage("rslRegCountMemory3") var regCount: Int = 0
    @AppStorage("rslCzCountMemory3") var czCount: Int = 0
    @AppStorage("rslAtCountMemory3") var atCount: Int = 0
    @AppStorage("rslRegCountChanceMemory3") var regCountChance: Int = 0
    @AppStorage("rslRegCountKiramekiMemory3") var regCountKirameki: Int = 0
    @AppStorage("rslRegCountSuikaMemory3") var regCountSuika: Int = 0
    @AppStorage("rslRegCount3YakuSumMemory3") var regCount3YakuSum: Int = 0
    @AppStorage("rslScreenCountDefaultMemory3") var screenCountDefault: Int = 0
    @AppStorage("rslScreenCountHighJakuMemory3") var screenCountHighJaku: Int = 0
    @AppStorage("rslScreenCountHighKyoMemory3") var screenCountHighKyo: Int = 0
    @AppStorage("rslScreenCountOver2Memory3") var screenCountOver2: Int = 0
    @AppStorage("rslScreenCountOver4Memory3") var screenCountOver4: Int = 0
    @AppStorage("rslScreenCountOver5Memory3") var screenCountOver5: Int = 0
    @AppStorage("rslScreenCountOver6Memory3") var screenCountOver6: Int = 0
    @AppStorage("rslScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("rslVoiceCountDefaultMemory3") var voiceCountDefault: Int = 0
    @AppStorage("rslVoiceCountHighJakuMemory3") var voiceCountHighJaku: Int = 0
    @AppStorage("rslVoiceCountHighKyoMemory3") var voiceCountHighKyo: Int = 0
    @AppStorage("rslVoiceCountOver2Memory3") var voiceCountOver2: Int = 0
    @AppStorage("rslVoiceCountOver4Memory3") var voiceCountOver4: Int = 0
    @AppStorage("rslVoiceCountOver6Memory3") var voiceCountOver6: Int = 0
    @AppStorage("rslVoiceCountSumMemory3") var voiceCountSum: Int = 0
    @AppStorage("rslMemoMemory3") var memo = ""
    @AppStorage("rslDateMemory3") var dateDouble = 0.0
}
