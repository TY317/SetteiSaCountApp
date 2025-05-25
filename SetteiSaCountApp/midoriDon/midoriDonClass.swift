//
//  midoriDonClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/04.
//

import Foundation
import SwiftUI

class MidoriDon: ObservableObject {
    // ///////////////
    // 小役確率
    // ///////////////
    let ratioJakuCherry: [Double] = [72.8,72,71.2,70.5,68.3,66.9]
    let ratioJakuSuika: [Double] = [109.2,107.4,105.7,104.0,102.4,99.3]
    let ratioJakuSum: [Double] = [43.68,43.10,42.54,42.01,40.97,39.97]
    @AppStorage("midoriDonTotalGame") var totalGame: Int = 0
    @AppStorage("midoriDonJakuRareCountCherry") var jakuRareCountCherry: Int = 0 {
        didSet {
            jakuRareCountSum = countSum(jakuRareCountCherry, jakuRareCountSuika)
        }
    }
        @AppStorage("midoriDonJakuRareCountSuika") var jakuRareCountSuika: Int = 0 {
            didSet {
                jakuRareCountSum = countSum(jakuRareCountCherry, jakuRareCountSuika)
            }
        }
    @AppStorage("midoriDonJakuRareCountSum") var jakuRareCountSum: Int = 0
    
    func resetKoyaku() {
        totalGame = 0
        jakuRareCountCherry = 0
        jakuRareCountSuika = 0
        minusCheck = false
    }
    
    // //////////////////
    // 初当り
    // //////////////////
    let ratioFirstHitBonus: [Double] = [275.4,274.0,267.3,251.1,229.9,223.4]
    let ratioFirstHitAt: [Double] = [561.0,555.7,502.0,464.4,424.3,400.8]
    
    
    // //////////////////
    // ボーナス終了画面
    // //////////////////
    @AppStorage("midoriDonBonusScreenCountScreen1") var bonusScreenCountScreen1: Int = 0 {
        didSet {
            bonusScreenCountSum = countSum(bonusScreenCountScreen1, bonusScreenCountScreen2, bonusScreenCountScreen3, bonusScreenCountScreen4, bonusScreenCountScreen5, bonusScreenCountScreen6)
        }
    }
        @AppStorage("midoriDonBonusScreenCountScreen2") var bonusScreenCountScreen2: Int = 0 {
            didSet {
                bonusScreenCountSum = countSum(bonusScreenCountScreen1, bonusScreenCountScreen2, bonusScreenCountScreen3, bonusScreenCountScreen4, bonusScreenCountScreen5, bonusScreenCountScreen6)
            }
        }
            @AppStorage("midoriDonBonusScreenCountScreen3") var bonusScreenCountScreen3: Int = 0 {
                didSet {
                    bonusScreenCountSum = countSum(bonusScreenCountScreen1, bonusScreenCountScreen2, bonusScreenCountScreen3, bonusScreenCountScreen4, bonusScreenCountScreen5, bonusScreenCountScreen6)
                }
            }
                @AppStorage("midoriDonBonusScreenCountScreen4") var bonusScreenCountScreen4: Int = 0 {
                    didSet {
                        bonusScreenCountSum = countSum(bonusScreenCountScreen1, bonusScreenCountScreen2, bonusScreenCountScreen3, bonusScreenCountScreen4, bonusScreenCountScreen5, bonusScreenCountScreen6)
                    }
                }
                    @AppStorage("midoriDonBonusScreenCountScreen5") var bonusScreenCountScreen5: Int = 0 {
                        didSet {
                            bonusScreenCountSum = countSum(bonusScreenCountScreen1, bonusScreenCountScreen2, bonusScreenCountScreen3, bonusScreenCountScreen4, bonusScreenCountScreen5, bonusScreenCountScreen6)
                        }
                    }
                        @AppStorage("midoriDonBonusScreenCountScreen6") var bonusScreenCountScreen6: Int = 0 {
                            didSet {
                                bonusScreenCountSum = countSum(bonusScreenCountScreen1, bonusScreenCountScreen2, bonusScreenCountScreen3, bonusScreenCountScreen4, bonusScreenCountScreen5, bonusScreenCountScreen6)
                            }
                        }
    @AppStorage("midoriDonBonusScreenCountSum") var bonusScreenCountSum: Int = 0
    
    func resetBonusScreen() {
        bonusScreenCountScreen1 = 0
        bonusScreenCountScreen2 = 0
        bonusScreenCountScreen3 = 0
        bonusScreenCountScreen4 = 0
        bonusScreenCountScreen5 = 0
        bonusScreenCountScreen6 = 0
        minusCheck = false
    }
    
    // /////////////////
    // ボイス
    // /////////////////
    @AppStorage("midoriDonVoiceCount1") var voiceCount1: Int = 0 {
        didSet {
            voiceCountSum = countSum(voiceCount1, voiceCount2, voiceCount3, voiceCount4, voiceCount5, voiceCount6, voiceCount7, voiceCount8, voiceCount9)
        }
    }
        @AppStorage("midoriDonVoiceCount2") var voiceCount2: Int = 0 {
            didSet {
                voiceCountSum = countSum(voiceCount1, voiceCount2, voiceCount3, voiceCount4, voiceCount5, voiceCount6, voiceCount7, voiceCount8, voiceCount9)
            }
        }
            @AppStorage("midoriDonVoiceCount3") var voiceCount3: Int = 0 {
                didSet {
                    voiceCountSum = countSum(voiceCount1, voiceCount2, voiceCount3, voiceCount4, voiceCount5, voiceCount6, voiceCount7, voiceCount8, voiceCount9)
                }
            }
                @AppStorage("midoriDonVoiceCount4") var voiceCount4: Int = 0 {
                    didSet {
                        voiceCountSum = countSum(voiceCount1, voiceCount2, voiceCount3, voiceCount4, voiceCount5, voiceCount6, voiceCount7, voiceCount8, voiceCount9)
                    }
                }
                    @AppStorage("midoriDonVoiceCount5") var voiceCount5: Int = 0 {
                        didSet {
                            voiceCountSum = countSum(voiceCount1, voiceCount2, voiceCount3, voiceCount4, voiceCount5, voiceCount6, voiceCount7, voiceCount8, voiceCount9)
                        }
                    }
                        @AppStorage("midoriDonVoiceCount6") var voiceCount6: Int = 0 {
                            didSet {
                                voiceCountSum = countSum(voiceCount1, voiceCount2, voiceCount3, voiceCount4, voiceCount5, voiceCount6, voiceCount7, voiceCount8, voiceCount9)
                            }
                        }
                            @AppStorage("midoriDonVoiceCount7") var voiceCount7: Int = 0 {
                                didSet {
                                    voiceCountSum = countSum(voiceCount1, voiceCount2, voiceCount3, voiceCount4, voiceCount5, voiceCount6, voiceCount7, voiceCount8, voiceCount9)
                                }
                            }
                                @AppStorage("midoriDonVoiceCount8") var voiceCount8: Int = 0 {
                                    didSet {
                                        voiceCountSum = countSum(voiceCount1, voiceCount2, voiceCount3, voiceCount4, voiceCount5, voiceCount6, voiceCount7, voiceCount8, voiceCount9)
                                    }
                                }
                                    @AppStorage("midoriDonVoiceCount9") var voiceCount9: Int = 0 {
                                        didSet {
                                            voiceCountSum = countSum(voiceCount1, voiceCount2, voiceCount3, voiceCount4, voiceCount5, voiceCount6, voiceCount7, voiceCount8, voiceCount9)
                                        }
                                    }
    @AppStorage("midoriDonVoiceCountSum") var voiceCountSum: Int = 0
    func resetVoice() {
        voiceCount1 = 0
        voiceCount2 = 0
        voiceCount3 = 0
        voiceCount4 = 0
        voiceCount5 = 0
        voiceCount6 = 0
        voiceCount7 = 0
        voiceCount8 = 0
        voiceCount9 = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("midoriDonMinusCheck") var minusCheck: Bool = false
    @AppStorage("midoriDonSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetKoyaku()
        resetBonusScreen()
        resetVoice()
        resetKoyakuBonus()
    }
    
    // /////////////////
    // ver3.2.0で追加
    // /////////////////
    @AppStorage("midoriDonNormalRareCountJakuCherry") var normalRareCountJakuCherry: Int = 0
    @AppStorage("midoriDonNormalRareCountJakuSuika") var normalRareCountJakuSuika: Int = 0
    @AppStorage("midoriDonNormalRareCountChance") var normalRareCountChance: Int = 0
    @AppStorage("midoriDonNormalRareCountKyoCherry") var normalRareCountKyoCherry: Int = 0
    @AppStorage("midoriDonNormalRareCountKyoSuika") var normalRareCountKyoSuika: Int = 0
    @AppStorage("midoriDonNormalRareHitCountJakuCherry") var normalRareHitCountJakuCherry: Int = 0
    @AppStorage("midoriDonNormalRareHitCountJakuSuika") var normalRareHitCountJakuSuika: Int = 0
    @AppStorage("midoriDonNormalRareHitCountChance") var normalRareHitCountChance: Int = 0
    @AppStorage("midoriDonNormalRareHitCountKyoCherry") var normalRareHitCountKyoCherry: Int = 0
    @AppStorage("midoriDonNormalRareHitCountKyoSuika") var normalRareHitCountKyoSuika: Int = 0
    
    func resetKoyakuBonus() {
        normalRareCountJakuCherry = 0
        normalRareCountJakuSuika = 0
        normalRareCountChance = 0
        normalRareCountKyoCherry = 0
        normalRareCountKyoSuika = 0
        normalRareHitCountJakuCherry = 0
        normalRareHitCountJakuSuika = 0
        normalRareHitCountChance = 0
        normalRareHitCountKyoCherry = 0
        normalRareHitCountKyoSuika = 0
        minusCheck = false
    }
    
    let ratioKoyakuBonusJakuCherry = [0.4,0.4,0.4,0.4,0.8,0.8]
    let ratioKoyakuBonusJakuSuika = [1.6,1.6,1.6,1.6,2.3,2.3]
    let ratioKoyakuBonusChance = [13.7,13.7,13.7,13.7,15.7,17.2]
    let ratioKoyakuBonusKyoCherry = [19.9,19.9,19.9,25,25,25]
    let ratioKoyakuBonusKyoSuika = [26.6,26.6,26.6,33.2,33.2,33.2]
}

// //// メモリー1
class MidoriDonMemory1: ObservableObject {
    @AppStorage("midoriDonTotalGameMemory1") var totalGame: Int = 0
    @AppStorage("midoriDonJakuRareCountCherryMemory1") var jakuRareCountCherry: Int = 0
    @AppStorage("midoriDonJakuRareCountSuikaMemory1") var jakuRareCountSuika: Int = 0
    @AppStorage("midoriDonJakuRareCountSumMemory1") var jakuRareCountSum: Int = 0
    @AppStorage("midoriDonBonusScreenCountScreen1Memory1") var bonusScreenCountScreen1: Int = 0
    @AppStorage("midoriDonBonusScreenCountScreen2Memory1") var bonusScreenCountScreen2: Int = 0
    @AppStorage("midoriDonBonusScreenCountScreen3Memory1") var bonusScreenCountScreen3: Int = 0
    @AppStorage("midoriDonBonusScreenCountScreen4Memory1") var bonusScreenCountScreen4: Int = 0
    @AppStorage("midoriDonBonusScreenCountScreen5Memory1") var bonusScreenCountScreen5: Int = 0
    @AppStorage("midoriDonBonusScreenCountScreen6Memory1") var bonusScreenCountScreen6: Int = 0
    @AppStorage("midoriDonBonusScreenCountSumMemory1") var bonusScreenCountSum: Int = 0
    @AppStorage("midoriDonVoiceCount1Memory1") var voiceCount1: Int = 0
    @AppStorage("midoriDonVoiceCount2Memory1") var voiceCount2: Int = 0
    @AppStorage("midoriDonVoiceCount3Memory1") var voiceCount3: Int = 0
    @AppStorage("midoriDonVoiceCount4Memory1") var voiceCount4: Int = 0
    @AppStorage("midoriDonVoiceCount5Memory1") var voiceCount5: Int = 0
    @AppStorage("midoriDonVoiceCount6Memory1") var voiceCount6: Int = 0
    @AppStorage("midoriDonVoiceCount7Memory1") var voiceCount7: Int = 0
    @AppStorage("midoriDonVoiceCount8Memory1") var voiceCount8: Int = 0
    @AppStorage("midoriDonVoiceCount9Memory1") var voiceCount9: Int = 0
    @AppStorage("midoriDonVoiceCountSumMemory1") var voiceCountSum: Int = 0
    @AppStorage("midoriDonMemoMemory1") var memo = ""
    @AppStorage("midoriDonDateMemory1") var dateDouble = 0.0
    
    // /////////////////
    // ver3.2.0で追加
    // /////////////////
    @AppStorage("midoriDonNormalRareCountJakuCherryMemory1") var normalRareCountJakuCherry: Int = 0
    @AppStorage("midoriDonNormalRareCountJakuSuikaMemory1") var normalRareCountJakuSuika: Int = 0
    @AppStorage("midoriDonNormalRareCountChanceMemory1") var normalRareCountChance: Int = 0
    @AppStorage("midoriDonNormalRareCountKyoCherryMemory1") var normalRareCountKyoCherry: Int = 0
    @AppStorage("midoriDonNormalRareCountKyoSuikaMemory1") var normalRareCountKyoSuika: Int = 0
    @AppStorage("midoriDonNormalRareHitCountJakuCherryMemory1") var normalRareHitCountJakuCherry: Int = 0
    @AppStorage("midoriDonNormalRareHitCountJakuSuikaMemory1") var normalRareHitCountJakuSuika: Int = 0
    @AppStorage("midoriDonNormalRareHitCountChanceMemory1") var normalRareHitCountChance: Int = 0
    @AppStorage("midoriDonNormalRareHitCountKyoCherryMemory1") var normalRareHitCountKyoCherry: Int = 0
    @AppStorage("midoriDonNormalRareHitCountKyoSuikaMemory1") var normalRareHitCountKyoSuika: Int = 0
}

// //// メモリー2
class MidoriDonMemory2: ObservableObject {
    @AppStorage("midoriDonTotalGameMemory2") var totalGame: Int = 0
    @AppStorage("midoriDonJakuRareCountCherryMemory2") var jakuRareCountCherry: Int = 0
    @AppStorage("midoriDonJakuRareCountSuikaMemory2") var jakuRareCountSuika: Int = 0
    @AppStorage("midoriDonJakuRareCountSumMemory2") var jakuRareCountSum: Int = 0
    @AppStorage("midoriDonBonusScreenCountScreen1Memory2") var bonusScreenCountScreen1: Int = 0
    @AppStorage("midoriDonBonusScreenCountScreen2Memory2") var bonusScreenCountScreen2: Int = 0
    @AppStorage("midoriDonBonusScreenCountScreen3Memory2") var bonusScreenCountScreen3: Int = 0
    @AppStorage("midoriDonBonusScreenCountScreen4Memory2") var bonusScreenCountScreen4: Int = 0
    @AppStorage("midoriDonBonusScreenCountScreen5Memory2") var bonusScreenCountScreen5: Int = 0
    @AppStorage("midoriDonBonusScreenCountScreen6Memory2") var bonusScreenCountScreen6: Int = 0
    @AppStorage("midoriDonBonusScreenCountSumMemory2") var bonusScreenCountSum: Int = 0
    @AppStorage("midoriDonVoiceCount1Memory2") var voiceCount1: Int = 0
    @AppStorage("midoriDonVoiceCount2Memory2") var voiceCount2: Int = 0
    @AppStorage("midoriDonVoiceCount3Memory2") var voiceCount3: Int = 0
    @AppStorage("midoriDonVoiceCount4Memory2") var voiceCount4: Int = 0
    @AppStorage("midoriDonVoiceCount5Memory2") var voiceCount5: Int = 0
    @AppStorage("midoriDonVoiceCount6Memory2") var voiceCount6: Int = 0
    @AppStorage("midoriDonVoiceCount7Memory2") var voiceCount7: Int = 0
    @AppStorage("midoriDonVoiceCount8Memory2") var voiceCount8: Int = 0
    @AppStorage("midoriDonVoiceCount9Memory2") var voiceCount9: Int = 0
    @AppStorage("midoriDonVoiceCountSumMemory2") var voiceCountSum: Int = 0
    @AppStorage("midoriDonMemoMemory2") var memo = ""
    @AppStorage("midoriDonDateMemory2") var dateDouble = 0.0
    
    // /////////////////
    // ver3.2.0で追加
    // /////////////////
    @AppStorage("midoriDonNormalRareCountJakuCherryMemory2") var normalRareCountJakuCherry: Int = 0
    @AppStorage("midoriDonNormalRareCountJakuSuikaMemory2") var normalRareCountJakuSuika: Int = 0
    @AppStorage("midoriDonNormalRareCountChanceMemory2") var normalRareCountChance: Int = 0
    @AppStorage("midoriDonNormalRareCountKyoCherryMemory2") var normalRareCountKyoCherry: Int = 0
    @AppStorage("midoriDonNormalRareCountKyoSuikaMemory2") var normalRareCountKyoSuika: Int = 0
    @AppStorage("midoriDonNormalRareHitCountJakuCherryMemory2") var normalRareHitCountJakuCherry: Int = 0
    @AppStorage("midoriDonNormalRareHitCountJakuSuikaMemory2") var normalRareHitCountJakuSuika: Int = 0
    @AppStorage("midoriDonNormalRareHitCountChanceMemory2") var normalRareHitCountChance: Int = 0
    @AppStorage("midoriDonNormalRareHitCountKyoCherryMemory2") var normalRareHitCountKyoCherry: Int = 0
    @AppStorage("midoriDonNormalRareHitCountKyoSuikaMemory2") var normalRareHitCountKyoSuika: Int = 0
}

// //// メモリー3
class MidoriDonMemory3: ObservableObject {
    @AppStorage("midoriDonTotalGameMemory3") var totalGame: Int = 0
    @AppStorage("midoriDonJakuRareCountCherryMemory3") var jakuRareCountCherry: Int = 0
    @AppStorage("midoriDonJakuRareCountSuikaMemory3") var jakuRareCountSuika: Int = 0
    @AppStorage("midoriDonJakuRareCountSumMemory3") var jakuRareCountSum: Int = 0
    @AppStorage("midoriDonBonusScreenCountScreen1Memory3") var bonusScreenCountScreen1: Int = 0
    @AppStorage("midoriDonBonusScreenCountScreen2Memory3") var bonusScreenCountScreen2: Int = 0
    @AppStorage("midoriDonBonusScreenCountScreen3Memory3") var bonusScreenCountScreen3: Int = 0
    @AppStorage("midoriDonBonusScreenCountScreen4Memory3") var bonusScreenCountScreen4: Int = 0
    @AppStorage("midoriDonBonusScreenCountScreen5Memory3") var bonusScreenCountScreen5: Int = 0
    @AppStorage("midoriDonBonusScreenCountScreen6Memory3") var bonusScreenCountScreen6: Int = 0
    @AppStorage("midoriDonBonusScreenCountSumMemory3") var bonusScreenCountSum: Int = 0
    @AppStorage("midoriDonVoiceCount1Memory3") var voiceCount1: Int = 0
    @AppStorage("midoriDonVoiceCount2Memory3") var voiceCount2: Int = 0
    @AppStorage("midoriDonVoiceCount3Memory3") var voiceCount3: Int = 0
    @AppStorage("midoriDonVoiceCount4Memory3") var voiceCount4: Int = 0
    @AppStorage("midoriDonVoiceCount5Memory3") var voiceCount5: Int = 0
    @AppStorage("midoriDonVoiceCount6Memory3") var voiceCount6: Int = 0
    @AppStorage("midoriDonVoiceCount7Memory3") var voiceCount7: Int = 0
    @AppStorage("midoriDonVoiceCount8Memory3") var voiceCount8: Int = 0
    @AppStorage("midoriDonVoiceCount9Memory3") var voiceCount9: Int = 0
    @AppStorage("midoriDonVoiceCountSumMemory3") var voiceCountSum: Int = 0
    @AppStorage("midoriDonMemoMemory3") var memo = ""
    @AppStorage("midoriDonDateMemory3") var dateDouble = 0.0
    
    // /////////////////
    // ver3.2.0で追加
    // /////////////////
    @AppStorage("midoriDonNormalRareCountJakuCherryMemory3") var normalRareCountJakuCherry: Int = 0
    @AppStorage("midoriDonNormalRareCountJakuSuikaMemory3") var normalRareCountJakuSuika: Int = 0
    @AppStorage("midoriDonNormalRareCountChanceMemory3") var normalRareCountChance: Int = 0
    @AppStorage("midoriDonNormalRareCountKyoCherryMemory3") var normalRareCountKyoCherry: Int = 0
    @AppStorage("midoriDonNormalRareCountKyoSuikaMemory3") var normalRareCountKyoSuika: Int = 0
    @AppStorage("midoriDonNormalRareHitCountJakuCherryMemory3") var normalRareHitCountJakuCherry: Int = 0
    @AppStorage("midoriDonNormalRareHitCountJakuSuikaMemory3") var normalRareHitCountJakuSuika: Int = 0
    @AppStorage("midoriDonNormalRareHitCountChanceMemory3") var normalRareHitCountChance: Int = 0
    @AppStorage("midoriDonNormalRareHitCountKyoCherryMemory3") var normalRareHitCountKyoCherry: Int = 0
    @AppStorage("midoriDonNormalRareHitCountKyoSuikaMemory3") var normalRareHitCountKyoSuika: Int = 0
}
