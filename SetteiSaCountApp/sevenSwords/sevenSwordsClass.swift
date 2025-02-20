//
//  sevenSwordsClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/13.
//

import Foundation
import SwiftUI

class SevenSwords: ObservableObject {
    // ////////////////////////
    // ボーナス、ST初当り
    // ////////////////////////
    @AppStorage("sevenSwordsG250CountNoHit") var g250CountNoHit: Int = 0 {
        didSet {
            g250CountSum = countSum(g250CountHit, g250CountNoHit)
        }
    }
        @AppStorage("sevenSwordsG250CountHit") var g250CountHit: Int = 0 {
            didSet {
                g250CountSum = countSum(g250CountHit, g250CountNoHit)
            }
        }
    @AppStorage("sevenSwordsG250CountSum") var g250CountSum: Int = 0
    @AppStorage("sevenSwordsInputNormalGame") var inputNormalGame: Int = 0
    @AppStorage("sevenSwordsInputBonusCountProloge") var inputBonusCountProloge: Int = 0 {
        didSet {
            inputBonusCountSum = countSum(inputBonusCountProloge, inputBonusCountKimbary)
        }
    }
        @AppStorage("sevenSwordsInputBonusCountKimbary") var inputBonusCountKimbary: Int = 0 {
            didSet {
                inputBonusCountSum = countSum(inputBonusCountProloge, inputBonusCountKimbary)
            }
        }
    @AppStorage("sevenSwordsInputBonusCountSum") var inputBonusCountSum: Int = 0
    @AppStorage("sevenSwordsInputStCount") var inputStCount: Int = 0
    
    func resetBonusSt() {
        g250CountNoHit = 0
        g250CountHit = 0
        inputNormalGame = 0
        inputBonusCountProloge = 0
        inputBonusCountKimbary = 0
        inputStCount = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // キンバリーBONUS中のキャラ
    // ////////////////////////
    let selectListKimbaryCharacter: [String] = [
        "青背景キャラ",
        "ダリウス＝グレンヴィル",
        "エスメラルダ",
        "テレサ＝カルステ",
        "アルヴィン＝ゴッドフレイ",
        "カルロス＝ウィットロウ",
        "オフィーリア＝サルヴァドーリ"
    ]
    @AppStorage("sevenSwordsSelectedKimbaryCharacter") var selectedKimbaryCharacter: String = "青背景キャラ"
    @AppStorage("sevenSwordsKimbaryCharacterCountDefault") var kimbaryCharacterCountDefault: Int = 0 {
        didSet {
            kimbaryCharacterCountSum = countSum(kimbaryCharacterCountDefault, kimbaryCharacterCountKisu, kimbaryCharacterCountGusu, kimbaryCharacterCountHigh, kimbaryCharacterCountKisuHigh, kimbaryCharacterCountGusuHigh, kimbaryCharacterCountHighKyo)
        }
    }
    @AppStorage("sevenSwordsKimbaryCharacterCountKisu") var kimbaryCharacterCountKisu: Int = 0 {
        didSet {
            kimbaryCharacterCountSum = countSum(kimbaryCharacterCountDefault, kimbaryCharacterCountKisu, kimbaryCharacterCountGusu, kimbaryCharacterCountHigh, kimbaryCharacterCountKisuHigh, kimbaryCharacterCountGusuHigh, kimbaryCharacterCountHighKyo)
        }
    }
        @AppStorage("sevenSwordsKimbaryCharacterCountGusu") var kimbaryCharacterCountGusu: Int = 0 {
            didSet {
                kimbaryCharacterCountSum = countSum(kimbaryCharacterCountDefault, kimbaryCharacterCountKisu, kimbaryCharacterCountGusu, kimbaryCharacterCountHigh, kimbaryCharacterCountKisuHigh, kimbaryCharacterCountGusuHigh, kimbaryCharacterCountHighKyo)
            }
        }
            @AppStorage("sevenSwordsKimbaryCharacterCountHigh") var kimbaryCharacterCountHigh: Int = 0 {
                didSet {
                    kimbaryCharacterCountSum = countSum(kimbaryCharacterCountDefault, kimbaryCharacterCountKisu, kimbaryCharacterCountGusu, kimbaryCharacterCountHigh, kimbaryCharacterCountKisuHigh, kimbaryCharacterCountGusuHigh, kimbaryCharacterCountHighKyo)
                }
            }
                @AppStorage("sevenSwordsKimbaryCharacterCountKisuHigh") var kimbaryCharacterCountKisuHigh: Int = 0 {
                    didSet {
                        kimbaryCharacterCountSum = countSum(kimbaryCharacterCountDefault, kimbaryCharacterCountKisu, kimbaryCharacterCountGusu, kimbaryCharacterCountHigh, kimbaryCharacterCountKisuHigh, kimbaryCharacterCountGusuHigh, kimbaryCharacterCountHighKyo)
                    }
                }
                    @AppStorage("sevenSwordsKimbaryCharacterCountGusuHigh") var kimbaryCharacterCountGusuHigh: Int = 0 {
                        didSet {
                            kimbaryCharacterCountSum = countSum(kimbaryCharacterCountDefault, kimbaryCharacterCountKisu, kimbaryCharacterCountGusu, kimbaryCharacterCountHigh, kimbaryCharacterCountKisuHigh, kimbaryCharacterCountGusuHigh, kimbaryCharacterCountHighKyo)
                        }
                    }
                        @AppStorage("sevenSwordsKimbaryCharacterCountHighKyo") var kimbaryCharacterCountHighKyo: Int = 0 {
                            didSet {
                                kimbaryCharacterCountSum = countSum(kimbaryCharacterCountDefault, kimbaryCharacterCountKisu, kimbaryCharacterCountGusu, kimbaryCharacterCountHigh, kimbaryCharacterCountKisuHigh, kimbaryCharacterCountGusuHigh, kimbaryCharacterCountHighKyo)
                            }
                        }
    @AppStorage("sevenSwordsKimbaryCharacterCountSum") var kimbaryCharacterCountSum: Int = 0
    
    func resetKimbaryCharacter() {
        kimbaryCharacterCountDefault = 0
        kimbaryCharacterCountKisu = 0
        kimbaryCharacterCountGusu = 0
        kimbaryCharacterCountHigh = 0
        kimbaryCharacterCountKisuHigh = 0
        kimbaryCharacterCountGusuHigh = 0
        kimbaryCharacterCountHighKyo = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // プロローグボーナス終了画面
    // ////////////////////////
    let bonusScreenKeywordList: [String] = [
        "sevenSwordsBonusScreenDefaultA",
        "sevenSwordsBonusScreenDefaultB",
        "sevenSwordsBonusScreenDefaultC",
        "sevenSwordsBonusScreenOliverNanaoA",
        "sevenSwordsBonusScreenOliverNanaoB",
        "sevenSwordsBonusScreenNanaoHohki",
        "sevenSwordsBonusScreenOliverNanaoC",
        "sevenSwordsBonusScreenKenkadan"
    ]
    @AppStorage("sevenSwordsBonusScreenCurrentKeyword") var bonusScreenCurrentKeyword: String = ""
    @AppStorage("sevenSwordsBonusScreenCountDefault") var bonusScreenCountDefault: Int = 0 {
        didSet {
            bonusScreenCountSum = countSum(bonusScreenCountDefault, bonusScreenCountGusu, bonusScreenCountOver2, bonusScreenCountOver3, bonusScreenCountOver4, bonusScreenCountOver6)
        }
    }
        @AppStorage("sevenSwordsBonusScreenCountGusu") var bonusScreenCountGusu: Int = 0 {
            didSet {
                bonusScreenCountSum = countSum(bonusScreenCountDefault, bonusScreenCountGusu, bonusScreenCountOver2, bonusScreenCountOver3, bonusScreenCountOver4, bonusScreenCountOver6)
            }
        }
            @AppStorage("sevenSwordsBonusScreenCountOver2") var bonusScreenCountOver2: Int = 0 {
                didSet {
                    bonusScreenCountSum = countSum(bonusScreenCountDefault, bonusScreenCountGusu, bonusScreenCountOver2, bonusScreenCountOver3, bonusScreenCountOver4, bonusScreenCountOver6)
                }
            }
                @AppStorage("sevenSwordsBonusScreenCountOver3") var bonusScreenCountOver3: Int = 0 {
                    didSet {
                        bonusScreenCountSum = countSum(bonusScreenCountDefault, bonusScreenCountGusu, bonusScreenCountOver2, bonusScreenCountOver3, bonusScreenCountOver4, bonusScreenCountOver6)
                    }
                }
                    @AppStorage("sevenSwordsBonusScreenCountOver4") var bonusScreenCountOver4: Int = 0 {
                        didSet {
                            bonusScreenCountSum = countSum(bonusScreenCountDefault, bonusScreenCountGusu, bonusScreenCountOver2, bonusScreenCountOver3, bonusScreenCountOver4, bonusScreenCountOver6)
                        }
                    }
                        @AppStorage("sevenSwordsBonusScreenCountOver6") var bonusScreenCountOver6: Int = 0 {
                            didSet {
                                bonusScreenCountSum = countSum(bonusScreenCountDefault, bonusScreenCountGusu, bonusScreenCountOver2, bonusScreenCountOver3, bonusScreenCountOver4, bonusScreenCountOver6)
                            }
                        }
    @AppStorage("sevenSwordsBonusScreenCountSum") var bonusScreenCountSum: Int = 0
    
    func resetBonusScreen() {
        bonusScreenCurrentKeyword = ""
        bonusScreenCountDefault = 0
        bonusScreenCountGusu = 0
        bonusScreenCountOver2 = 0
        bonusScreenCountOver3 = 0
        bonusScreenCountOver4 = 0
        bonusScreenCountOver6 = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // ST終了画面
    // ////////////////////////
    let stScreenKeywordList: [String] = [
        "sevenSwordsStScreenNanao",
        "sevenSwordsStScreenTsukiyo",
        "sevenSwordsStScreenOliverGrainvel"
    ]
    @AppStorage("sevenSwordsStScreenCurrentKeyword") var stScreenCurrentKeyword: String = ""
    @AppStorage("sevenSwordsStScreenCountDefault") var stScreenCountDefault: Int = 0 {
        didSet {
            stScreenCountSum = countSum(stScreenCountDefault, stScreenCountKisu, stScreenCountGusu)
        }
    }
        @AppStorage("sevenSwordsStScreenCountKisu") var stScreenCountKisu: Int = 0 {
            didSet {
                stScreenCountSum = countSum(stScreenCountDefault, stScreenCountKisu, stScreenCountGusu)
            }
        }
            @AppStorage("sevenSwordsStScreenCountGusu") var stScreenCountGusu: Int = 0 {
                didSet {
                    stScreenCountSum = countSum(stScreenCountDefault, stScreenCountKisu, stScreenCountGusu)
                }
            }
    @AppStorage("sevenSwordsStScreenCountSum") var stScreenCountSum: Int = 0
    
    func resetStScreen() {
        stScreenCurrentKeyword = ""
        stScreenCountDefault = 0
        stScreenCountKisu = 0
        stScreenCountGusu = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // エンディング中のボイス
    // ////////////////////////
    let selectListVoice: [String] = [
        "やったな",
        "やるじゃないか",
        "いいぞ",
        "やったね",
        "やりますわね",
        "あっぱれ"
    ]
    @AppStorage("sevenSwordsSelectedVoice") var selectedVoice: String = "やったな"
    @AppStorage("sevenSwordsVoiceCountDefault") var voiceCountDefault: Int = 0 {
        didSet {
            voiceCountSum = countSum(voiceCountDefault, voiceCountKisu, voiceCountGusu, voiceCountOver2, voiceCountOver4, voiceCountOver6)
        }
    }
        @AppStorage("sevenSwordsVoiceCountKisu") var voiceCountKisu: Int = 0 {
            didSet {
                voiceCountSum = countSum(voiceCountDefault, voiceCountKisu, voiceCountGusu, voiceCountOver2, voiceCountOver4, voiceCountOver6)
            }
        }
            @AppStorage("sevenSwordsVoiceCountGusu") var voiceCountGusu: Int = 0 {
                didSet {
                    voiceCountSum = countSum(voiceCountDefault, voiceCountKisu, voiceCountGusu, voiceCountOver2, voiceCountOver4, voiceCountOver6)
                }
            }
                @AppStorage("sevenSwordsVoiceCountOver2") var voiceCountOver2: Int = 0 {
                    didSet {
                        voiceCountSum = countSum(voiceCountDefault, voiceCountKisu, voiceCountGusu, voiceCountOver2, voiceCountOver4, voiceCountOver6)
                    }
                }
                    @AppStorage("sevenSwordsVoiceCountOver4") var voiceCountOver4: Int = 0 {
                        didSet {
                            voiceCountSum = countSum(voiceCountDefault, voiceCountKisu, voiceCountGusu, voiceCountOver2, voiceCountOver4, voiceCountOver6)
                        }
                    }
                        @AppStorage("sevenSwordsVoiceCountOver6") var voiceCountOver6: Int = 0 {
                            didSet {
                                voiceCountSum = countSum(voiceCountDefault, voiceCountKisu, voiceCountGusu, voiceCountOver2, voiceCountOver4, voiceCountOver6)
                            }
                        }
    @AppStorage("sevenSwordsVoiceCountSum") var voiceCountSum: Int = 0
    
    func resetVoice() {
        voiceCountDefault = 0
        voiceCountKisu = 0
        voiceCountGusu = 0
        voiceCountOver2 = 0
        voiceCountOver4 = 0
        voiceCountOver6 = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("sevenSwordsMinusCheck") var minusCheck: Bool = false
    @AppStorage("sevenSwordsSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetBonusSt()
        resetKimbaryCharacter()
        resetBonusScreen()
        resetStScreen()
        resetVoice()
    }
}

// //// メモリー1
class SevenSwordsMemory1: ObservableObject {
    @AppStorage("sevenSwordsG250CountNoHitMemory1") var g250CountNoHit: Int = 0
    @AppStorage("sevenSwordsG250CountHitMemory1") var g250CountHit: Int = 0
    @AppStorage("sevenSwordsG250CountSumMemory1") var g250CountSum: Int = 0
    @AppStorage("sevenSwordsInputNormalGameMemory1") var inputNormalGame: Int = 0
    @AppStorage("sevenSwordsInputBonusCountPrologeMemory1") var inputBonusCountProloge: Int = 0
    @AppStorage("sevenSwordsInputBonusCountKimbaryMemory1") var inputBonusCountKimbary: Int = 0
    @AppStorage("sevenSwordsInputBonusCountSumMemory1") var inputBonusCountSum: Int = 0
    @AppStorage("sevenSwordsInputStCountMemory1") var inputStCount: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountDefaultMemory1") var kimbaryCharacterCountDefault: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountKisuMemory1") var kimbaryCharacterCountKisu: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountGusuMemory1") var kimbaryCharacterCountGusu: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountHighMemory1") var kimbaryCharacterCountHigh: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountKisuHighMemory1") var kimbaryCharacterCountKisuHigh: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountGusuHighMemory1") var kimbaryCharacterCountGusuHigh: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountHighKyoMemory1") var kimbaryCharacterCountHighKyo: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountSumMemory1") var kimbaryCharacterCountSum: Int = 0
    @AppStorage("sevenSwordsBonusScreenCountDefaultMemory1") var bonusScreenCountDefault: Int = 0
    @AppStorage("sevenSwordsBonusScreenCountGusuMemory1") var bonusScreenCountGusu: Int = 0
    @AppStorage("sevenSwordsBonusScreenCountOver2Memory1") var bonusScreenCountOver2: Int = 0
    @AppStorage("sevenSwordsBonusScreenCountOver3Memory1") var bonusScreenCountOver3: Int = 0
    @AppStorage("sevenSwordsBonusScreenCountOver4Memory1") var bonusScreenCountOver4: Int = 0
    @AppStorage("sevenSwordsBonusScreenCountOver6Memory1") var bonusScreenCountOver6: Int = 0
    @AppStorage("sevenSwordsBonusScreenCountSumMemory1") var bonusScreenCountSum: Int = 0
    @AppStorage("sevenSwordsStScreenCountDefaultMemory1") var stScreenCountDefault: Int = 0
    @AppStorage("sevenSwordsStScreenCountKisuMemory1") var stScreenCountKisu: Int = 0
    @AppStorage("sevenSwordsStScreenCountGusuMemory1") var stScreenCountGusu: Int = 0
    @AppStorage("sevenSwordsStScreenCountSumMemory1") var stScreenCountSum: Int = 0
    @AppStorage("sevenSwordsVoiceCountDefaultMemory1") var voiceCountDefault: Int = 0
    @AppStorage("sevenSwordsVoiceCountKisuMemory1") var voiceCountKisu: Int = 0
    @AppStorage("sevenSwordsVoiceCountGusuMemory1") var voiceCountGusu: Int = 0
    @AppStorage("sevenSwordsVoiceCountOver2Memory1") var voiceCountOver2: Int = 0
    @AppStorage("sevenSwordsVoiceCountOver4Memory1") var voiceCountOver4: Int = 0
    @AppStorage("sevenSwordsVoiceCountOver6Memory1") var voiceCountOver6: Int = 0
    @AppStorage("sevenSwordsVoiceCountSumMemory1") var voiceCountSum: Int = 0
    @AppStorage("sevenSwordsMemoMemory1") var memo = ""
    @AppStorage("sevenSwordsDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class SevenSwordsMemory2: ObservableObject {
    @AppStorage("sevenSwordsG250CountNoHitMemory2") var g250CountNoHit: Int = 0
    @AppStorage("sevenSwordsG250CountHitMemory2") var g250CountHit: Int = 0
    @AppStorage("sevenSwordsG250CountSumMemory2") var g250CountSum: Int = 0
    @AppStorage("sevenSwordsInputNormalGameMemory2") var inputNormalGame: Int = 0
    @AppStorage("sevenSwordsInputBonusCountPrologeMemory2") var inputBonusCountProloge: Int = 0
    @AppStorage("sevenSwordsInputBonusCountKimbaryMemory2") var inputBonusCountKimbary: Int = 0
    @AppStorage("sevenSwordsInputBonusCountSumMemory2") var inputBonusCountSum: Int = 0
    @AppStorage("sevenSwordsInputStCountMemory2") var inputStCount: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountDefaultMemory2") var kimbaryCharacterCountDefault: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountKisuMemory2") var kimbaryCharacterCountKisu: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountGusuMemory2") var kimbaryCharacterCountGusu: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountHighMemory2") var kimbaryCharacterCountHigh: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountKisuHighMemory2") var kimbaryCharacterCountKisuHigh: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountGusuHighMemory2") var kimbaryCharacterCountGusuHigh: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountHighKyoMemory2") var kimbaryCharacterCountHighKyo: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountSumMemory2") var kimbaryCharacterCountSum: Int = 0
    @AppStorage("sevenSwordsBonusScreenCountDefaultMemory2") var bonusScreenCountDefault: Int = 0
    @AppStorage("sevenSwordsBonusScreenCountGusuMemory2") var bonusScreenCountGusu: Int = 0
    @AppStorage("sevenSwordsBonusScreenCountOver2Memory2") var bonusScreenCountOver2: Int = 0
    @AppStorage("sevenSwordsBonusScreenCountOver3Memory2") var bonusScreenCountOver3: Int = 0
    @AppStorage("sevenSwordsBonusScreenCountOver4Memory2") var bonusScreenCountOver4: Int = 0
    @AppStorage("sevenSwordsBonusScreenCountOver6Memory2") var bonusScreenCountOver6: Int = 0
    @AppStorage("sevenSwordsBonusScreenCountSumMemory2") var bonusScreenCountSum: Int = 0
    @AppStorage("sevenSwordsStScreenCountDefaultMemory2") var stScreenCountDefault: Int = 0
    @AppStorage("sevenSwordsStScreenCountKisuMemory2") var stScreenCountKisu: Int = 0
    @AppStorage("sevenSwordsStScreenCountGusuMemory2") var stScreenCountGusu: Int = 0
    @AppStorage("sevenSwordsStScreenCountSumMemory2") var stScreenCountSum: Int = 0
    @AppStorage("sevenSwordsVoiceCountDefaultMemory2") var voiceCountDefault: Int = 0
    @AppStorage("sevenSwordsVoiceCountKisuMemory2") var voiceCountKisu: Int = 0
    @AppStorage("sevenSwordsVoiceCountGusuMemory2") var voiceCountGusu: Int = 0
    @AppStorage("sevenSwordsVoiceCountOver2Memory2") var voiceCountOver2: Int = 0
    @AppStorage("sevenSwordsVoiceCountOver4Memory2") var voiceCountOver4: Int = 0
    @AppStorage("sevenSwordsVoiceCountOver6Memory2") var voiceCountOver6: Int = 0
    @AppStorage("sevenSwordsVoiceCountSumMemory2") var voiceCountSum: Int = 0
    @AppStorage("sevenSwordsMemoMemory2") var memo = ""
    @AppStorage("sevenSwordsDateMemory2") var dateDouble = 0.0
}


// //// メモリー3
class SevenSwordsMemory3: ObservableObject {
    @AppStorage("sevenSwordsG250CountNoHitMemory3") var g250CountNoHit: Int = 0
    @AppStorage("sevenSwordsG250CountHitMemory3") var g250CountHit: Int = 0
    @AppStorage("sevenSwordsG250CountSumMemory3") var g250CountSum: Int = 0
    @AppStorage("sevenSwordsInputNormalGameMemory3") var inputNormalGame: Int = 0
    @AppStorage("sevenSwordsInputBonusCountPrologeMemory3") var inputBonusCountProloge: Int = 0
    @AppStorage("sevenSwordsInputBonusCountKimbaryMemory3") var inputBonusCountKimbary: Int = 0
    @AppStorage("sevenSwordsInputBonusCountSumMemory3") var inputBonusCountSum: Int = 0
    @AppStorage("sevenSwordsInputStCountMemory3") var inputStCount: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountDefaultMemory3") var kimbaryCharacterCountDefault: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountKisuMemory3") var kimbaryCharacterCountKisu: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountGusuMemory3") var kimbaryCharacterCountGusu: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountHighMemory3") var kimbaryCharacterCountHigh: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountKisuHighMemory3") var kimbaryCharacterCountKisuHigh: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountGusuHighMemory3") var kimbaryCharacterCountGusuHigh: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountHighKyoMemory3") var kimbaryCharacterCountHighKyo: Int = 0
    @AppStorage("sevenSwordsKimbaryCharacterCountSumMemory3") var kimbaryCharacterCountSum: Int = 0
    @AppStorage("sevenSwordsBonusScreenCountDefaultMemory3") var bonusScreenCountDefault: Int = 0
    @AppStorage("sevenSwordsBonusScreenCountGusuMemory3") var bonusScreenCountGusu: Int = 0
    @AppStorage("sevenSwordsBonusScreenCountOver2Memory3") var bonusScreenCountOver2: Int = 0
    @AppStorage("sevenSwordsBonusScreenCountOver3Memory3") var bonusScreenCountOver3: Int = 0
    @AppStorage("sevenSwordsBonusScreenCountOver4Memory3") var bonusScreenCountOver4: Int = 0
    @AppStorage("sevenSwordsBonusScreenCountOver6Memory3") var bonusScreenCountOver6: Int = 0
    @AppStorage("sevenSwordsBonusScreenCountSumMemory3") var bonusScreenCountSum: Int = 0
    @AppStorage("sevenSwordsStScreenCountDefaultMemory3") var stScreenCountDefault: Int = 0
    @AppStorage("sevenSwordsStScreenCountKisuMemory3") var stScreenCountKisu: Int = 0
    @AppStorage("sevenSwordsStScreenCountGusuMemory3") var stScreenCountGusu: Int = 0
    @AppStorage("sevenSwordsStScreenCountSumMemory3") var stScreenCountSum: Int = 0
    @AppStorage("sevenSwordsVoiceCountDefaultMemory3") var voiceCountDefault: Int = 0
    @AppStorage("sevenSwordsVoiceCountKisuMemory3") var voiceCountKisu: Int = 0
    @AppStorage("sevenSwordsVoiceCountGusuMemory3") var voiceCountGusu: Int = 0
    @AppStorage("sevenSwordsVoiceCountOver2Memory3") var voiceCountOver2: Int = 0
    @AppStorage("sevenSwordsVoiceCountOver4Memory3") var voiceCountOver4: Int = 0
    @AppStorage("sevenSwordsVoiceCountOver6Memory3") var voiceCountOver6: Int = 0
    @AppStorage("sevenSwordsVoiceCountSumMemory3") var voiceCountSum: Int = 0
    @AppStorage("sevenSwordsMemoMemory3") var memo = ""
    @AppStorage("sevenSwordsDateMemory3") var dateDouble = 0.0
}
