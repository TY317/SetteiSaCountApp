//
//  shamanKingClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/02/23.
//

import Foundation
import SwiftUI

class ShamanKing: ObservableObject {
    // ////////////////////////
    // 通常時
    // ////////////////////////
    @AppStorage("shamanKingJakuRareCount") var jakuRareCount: Int = 0
    @AppStorage("shamanKingBonusKokakuCount") var bonusKokakuCount: Int = 0
    @AppStorage("shamanKingReplayCounterCountFalse") var replayCounterReplayCount: Int = 0
        @AppStorage("shamanKingReplayCounterCountSuccesss") var replayCounterCountSuccesss: Int = 0
    
    func resetNormal() {
        jakuRareCount = 0
        bonusKokakuCount = 0
        replayCounterReplayCount = 0
        replayCounterCountSuccesss = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 憑依合体バトル
    // ////////////////////////
    @AppStorage("shamanKingHyoiCount78Lose") var hyoiCount78Lose: Int = 0 {
        didSet{
            hyoiCount78Sum = countSum(hyoiCount78Lose, hyoiCount78Win)
        }
    }
        @AppStorage("shamanKingHyoiCount78Win") var hyoiCount78Win: Int = 0 {
            didSet{
                hyoiCount78Sum = countSum(hyoiCount78Lose, hyoiCount78Win)
            }
        }
    @AppStorage("shamanKingHyoiCount78Sum") var hyoiCount78Sum: Int = 0
    @AppStorage("shamanKingHyoiCount56Lose") var hyoiCount56Lose: Int = 0 {
        didSet {
            hyoiCount56Sum = countSum(hyoiCount56Lose, hyoiCount56Win)
        }
    }
        @AppStorage("shamanKingHyoiCount56Win") var hyoiCount56Win: Int = 0 {
            didSet {
                hyoiCount56Sum = countSum(hyoiCount56Lose, hyoiCount56Win)
            }
        }
    @AppStorage("shamanKingHyoiCount56Sum") var hyoiCount56Sum: Int = 0
    @AppStorage("shamanKingHyoiCount4Lose") var hyoiCount4Lose: Int = 0 {
        didSet {
            hyoiCount4Sum = countSum(hyoiCount4Lose, hyoiCount4Win)
        }
    }
        @AppStorage("shamanKingHyoiCount4Win") var hyoiCount4Win: Int = 0 {
            didSet {
                hyoiCount4Sum = countSum(hyoiCount4Lose, hyoiCount4Win)
            }
        }
    @AppStorage("shamanKingHyoiCount4Sum") var hyoiCount4Sum: Int = 0
    @AppStorage("shamanKingHyoiCount3Lose") var hyoiCount3Lose: Int = 0 {
        didSet {
            hyoiCount3Sum = countSum(hyoiCount3Lose, hyoiCount3Win)
        }
    }
        @AppStorage("shamanKingHyoiCount3Win") var hyoiCount3Win: Int = 0 {
            didSet {
                hyoiCount3Sum = countSum(hyoiCount3Lose, hyoiCount3Win)
            }
        }
    @AppStorage("shamanKingHyoiCount3Sum") var hyoiCount3Sum: Int = 0
    
    
    func resetHyoiGattai() {
        hyoiCount78Lose = 0
        hyoiCount78Win = 0
        hyoiCount56Lose = 0
        hyoiCount56Win = 0
        hyoiCount4Lose = 0
        hyoiCount4Win = 0
        hyoiCount3Lose = 0
        hyoiCount3Win = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // ボーナス,AT 初当り
    // ////////////////////////
    @AppStorage("shamanKingInputGame") var inputGame: Int = 0
    @AppStorage("shamanKingInputShamanBonusCount") var inputShamanBonusCount: Int = 0 {
        didSet {
            bonusCountSum = countSum(inputShamanBonusCount, inputEpisodeBonusCount)
        }
    }
        @AppStorage("shamanKingInputEpisodeBonusCount") var inputEpisodeBonusCount: Int = 0 {
            didSet {
                bonusCountSum = countSum(inputShamanBonusCount, inputEpisodeBonusCount)
            }
        }
    @AppStorage("shamanKingBonusCountSum") var bonusCountSum: Int = 0
    @AppStorage("shamanKingInputShamanFightCount") var inputShamanFightCount: Int = 0
    
    func resetHit() {
        inputGame = 0
        inputShamanBonusCount = 0
        inputEpisodeBonusCount = 0
        inputShamanFightCount = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // エンディング
    // ////////////////////////
    let selectListEnding: [String] = [
        "まん太",
        "アンナ",
        "たまお＆アンナ",
        "竜之介",
        "竜之介＆ファウスト",
        "ピリカ",
        "ジャンヌ",
        "ゴルドバ",
        "葉＆アンナ",
        "ハオ",
        "ハオ＆葉"
    ]
    @AppStorage("shamanKingSelectedEnding") var selectedEnding: String = "まん太"
    @AppStorage("shamanKingEndingCountDefault") var endingCountDefault: Int = 0 {
        didSet {
            endingCountSum = countSum(endingCountDefault, endingCountGusuJaku, endingCountGusuKyo, endingCountKisuJaku, endingCountKisuKyo, endingCountOver2Sisa, endingCountOver4Sisa, endingCountOver2, endingCountOver4, endingCountOver5, endingCountOver6)
        }
    }
        @AppStorage("shamanKingEndingCountGusuJaku") var endingCountGusuJaku: Int = 0 {
            didSet {
                endingCountSum = countSum(endingCountDefault, endingCountGusuJaku, endingCountGusuKyo, endingCountKisuJaku, endingCountKisuKyo, endingCountOver2Sisa, endingCountOver4Sisa, endingCountOver2, endingCountOver4, endingCountOver5, endingCountOver6)
            }
        }
            @AppStorage("shamanKingEndingCountGusuKyo") var endingCountGusuKyo: Int = 0 {
                didSet {
                    endingCountSum = countSum(endingCountDefault, endingCountGusuJaku, endingCountGusuKyo, endingCountKisuJaku, endingCountKisuKyo, endingCountOver2Sisa, endingCountOver4Sisa, endingCountOver2, endingCountOver4, endingCountOver5, endingCountOver6)
                }
            }
                @AppStorage("shamanKingEndingCountKisuJaku") var endingCountKisuJaku: Int = 0 {
                    didSet {
                        endingCountSum = countSum(endingCountDefault, endingCountGusuJaku, endingCountGusuKyo, endingCountKisuJaku, endingCountKisuKyo, endingCountOver2Sisa, endingCountOver4Sisa, endingCountOver2, endingCountOver4, endingCountOver5, endingCountOver6)
                    }
                }
                    @AppStorage("shamanKingEndingCountKisuKyo") var endingCountKisuKyo: Int = 0 {
                        didSet {
                            endingCountSum = countSum(endingCountDefault, endingCountGusuJaku, endingCountGusuKyo, endingCountKisuJaku, endingCountKisuKyo, endingCountOver2Sisa, endingCountOver4Sisa, endingCountOver2, endingCountOver4, endingCountOver5, endingCountOver6)
                        }
                    }
                        @AppStorage("shamanKingEndingCountOver2Sisa") var endingCountOver2Sisa: Int = 0 {
                            didSet {
                                endingCountSum = countSum(endingCountDefault, endingCountGusuJaku, endingCountGusuKyo, endingCountKisuJaku, endingCountKisuKyo, endingCountOver2Sisa, endingCountOver4Sisa, endingCountOver2, endingCountOver4, endingCountOver5, endingCountOver6)
                            }
                        }
                            @AppStorage("shamanKingEndingCountOver4Sisa") var endingCountOver4Sisa: Int = 0 {
                                didSet {
                                    endingCountSum = countSum(endingCountDefault, endingCountGusuJaku, endingCountGusuKyo, endingCountKisuJaku, endingCountKisuKyo, endingCountOver2Sisa, endingCountOver4Sisa, endingCountOver2, endingCountOver4, endingCountOver5, endingCountOver6)
                                }
                            }
                                @AppStorage("shamanKingEndingCountOver2") var endingCountOver2: Int = 0 {
                                    didSet {
                                        endingCountSum = countSum(endingCountDefault, endingCountGusuJaku, endingCountGusuKyo, endingCountKisuJaku, endingCountKisuKyo, endingCountOver2Sisa, endingCountOver4Sisa, endingCountOver2, endingCountOver4, endingCountOver5, endingCountOver6)
                                    }
                                }
                                    @AppStorage("shamanKingEndingCountOver4") var endingCountOver4: Int = 0 {
                                        didSet {
                                            endingCountSum = countSum(endingCountDefault, endingCountGusuJaku, endingCountGusuKyo, endingCountKisuJaku, endingCountKisuKyo, endingCountOver2Sisa, endingCountOver4Sisa, endingCountOver2, endingCountOver4, endingCountOver5, endingCountOver6)
                                        }
                                    }
                                        @AppStorage("shamanKingEndingCountOver5") var endingCountOver5: Int = 0 {
                                            didSet {
                                                endingCountSum = countSum(endingCountDefault, endingCountGusuJaku, endingCountGusuKyo, endingCountKisuJaku, endingCountKisuKyo, endingCountOver2Sisa, endingCountOver4Sisa, endingCountOver2, endingCountOver4, endingCountOver5, endingCountOver6)
                                            }
                                        }
                                            @AppStorage("shamanKingEndingCountOver6") var endingCountOver6: Int = 0 {
                                                didSet {
                                                    endingCountSum = countSum(endingCountDefault, endingCountGusuJaku, endingCountGusuKyo, endingCountKisuJaku, endingCountKisuKyo, endingCountOver2Sisa, endingCountOver4Sisa, endingCountOver2, endingCountOver4, endingCountOver5, endingCountOver6)
                                                }
                                            }
    @AppStorage("shamanKingEndingCountSum") var endingCountSum: Int = 0
    
    
    func resetEnding() {
        endingCountDefault = 0
        endingCountGusuJaku = 0
        endingCountGusuKyo = 0
        endingCountKisuJaku = 0
        endingCountKisuKyo = 0
        endingCountOver2Sisa = 0
        endingCountOver4Sisa = 0
        endingCountOver2 = 0
        endingCountOver4 = 0
        endingCountOver5 = 0
        endingCountOver6 = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("shamanKingMinusCheck") var minusCheck: Bool = false
    @AppStorage("shamanKingSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetHyoiGattai()
        resetHit()
        resetEnding()
    }
}

// //// メモリー1
class ShamanKingMemory1: ObservableObject {
    @AppStorage("shamanKingJakuRareCountMemory1") var jakuRareCount: Int = 0
    @AppStorage("shamanKingBonusKokakuCountMemory1") var bonusKokakuCount: Int = 0
    @AppStorage("shamanKingReplayCounterCountFalseMemory1") var replayCounterReplayCount: Int = 0
    @AppStorage("shamanKingReplayCounterCountSuccesssMemory1") var replayCounterCountSuccesss: Int = 0
    @AppStorage("shamanKingHyoiCount78LoseMemory1") var hyoiCount78Lose: Int = 0
    @AppStorage("shamanKingHyoiCount78WinMemory1") var hyoiCount78Win: Int = 0
    @AppStorage("shamanKingHyoiCount78SumMemory1") var hyoiCount78Sum: Int = 0
    @AppStorage("shamanKingHyoiCount56LoseMemory1") var hyoiCount56Lose: Int = 0
    @AppStorage("shamanKingHyoiCount56WinMemory1") var hyoiCount56Win: Int = 0
    @AppStorage("shamanKingHyoiCount56SumMemory1") var hyoiCount56Sum: Int = 0
    @AppStorage("shamanKingHyoiCount4LoseMemory1") var hyoiCount4Lose: Int = 0
    @AppStorage("shamanKingHyoiCount4WinMemory1") var hyoiCount4Win: Int = 0
    @AppStorage("shamanKingHyoiCount4SumMemory1") var hyoiCount4Sum: Int = 0
    @AppStorage("shamanKingHyoiCount3LoseMemory1") var hyoiCount3Lose: Int = 0
    @AppStorage("shamanKingHyoiCount3WinMemory1") var hyoiCount3Win: Int = 0
    @AppStorage("shamanKingHyoiCount3SumMemory1") var hyoiCount3Sum: Int = 0
    @AppStorage("shamanKingInputGameMemory1") var inputGame: Int = 0
    @AppStorage("shamanKingInputShamanBonusCountMemory1") var inputShamanBonusCount: Int = 0
    @AppStorage("shamanKingInputEpisodeBonusCountMemory1") var inputEpisodeBonusCount: Int = 0
    @AppStorage("shamanKingBonusCountSumMemory1") var bonusCountSum: Int = 0
    @AppStorage("shamanKingInputShamanFightCountMemory1") var inputShamanFightCount: Int = 0
    @AppStorage("shamanKingEndingCountDefaultMemory1") var endingCountDefault: Int = 0
    @AppStorage("shamanKingEndingCountGusuJakuMemory1") var endingCountGusuJaku: Int = 0
    @AppStorage("shamanKingEndingCountGusuKyoMemory1") var endingCountGusuKyo: Int = 0
    @AppStorage("shamanKingEndingCountKisuJakuMemory1") var endingCountKisuJaku: Int = 0
    @AppStorage("shamanKingEndingCountKisuKyoMemory1") var endingCountKisuKyo: Int = 0
    @AppStorage("shamanKingEndingCountOver2SisaMemory1") var endingCountOver2Sisa: Int = 0
    @AppStorage("shamanKingEndingCountOver4SisaMemory1") var endingCountOver4Sisa: Int = 0
    @AppStorage("shamanKingEndingCountOver2Memory1") var endingCountOver2: Int = 0
    @AppStorage("shamanKingEndingCountOver4Memory1") var endingCountOver4: Int = 0
    @AppStorage("shamanKingEndingCountOver5Memory1") var endingCountOver5: Int = 0
    @AppStorage("shamanKingEndingCountOver6Memory1") var endingCountOver6: Int = 0
    @AppStorage("shamanKingEndingCountSumMemory1") var endingCountSum: Int = 0
    @AppStorage("shamanKingMemoMemory1") var memo = ""
    @AppStorage("shamanKingDateMemory1") var dateDouble = 0.0
}


// //// メモリー2
class ShamanKingMemory2: ObservableObject {
    @AppStorage("shamanKingJakuRareCountMemory2") var jakuRareCount: Int = 0
    @AppStorage("shamanKingBonusKokakuCountMemory2") var bonusKokakuCount: Int = 0
    @AppStorage("shamanKingReplayCounterCountFalseMemory2") var replayCounterReplayCount: Int = 0
    @AppStorage("shamanKingReplayCounterCountSuccesssMemory2") var replayCounterCountSuccesss: Int = 0
    @AppStorage("shamanKingHyoiCount78LoseMemory2") var hyoiCount78Lose: Int = 0
    @AppStorage("shamanKingHyoiCount78WinMemory2") var hyoiCount78Win: Int = 0
    @AppStorage("shamanKingHyoiCount78SumMemory2") var hyoiCount78Sum: Int = 0
    @AppStorage("shamanKingHyoiCount56LoseMemory2") var hyoiCount56Lose: Int = 0
    @AppStorage("shamanKingHyoiCount56WinMemory2") var hyoiCount56Win: Int = 0
    @AppStorage("shamanKingHyoiCount56SumMemory2") var hyoiCount56Sum: Int = 0
    @AppStorage("shamanKingHyoiCount4LoseMemory2") var hyoiCount4Lose: Int = 0
    @AppStorage("shamanKingHyoiCount4WinMemory2") var hyoiCount4Win: Int = 0
    @AppStorage("shamanKingHyoiCount4SumMemory2") var hyoiCount4Sum: Int = 0
    @AppStorage("shamanKingHyoiCount3LoseMemory2") var hyoiCount3Lose: Int = 0
    @AppStorage("shamanKingHyoiCount3WinMemory2") var hyoiCount3Win: Int = 0
    @AppStorage("shamanKingHyoiCount3SumMemory2") var hyoiCount3Sum: Int = 0
    @AppStorage("shamanKingInputGameMemory2") var inputGame: Int = 0
    @AppStorage("shamanKingInputShamanBonusCountMemory2") var inputShamanBonusCount: Int = 0
    @AppStorage("shamanKingInputEpisodeBonusCountMemory2") var inputEpisodeBonusCount: Int = 0
    @AppStorage("shamanKingBonusCountSumMemory2") var bonusCountSum: Int = 0
    @AppStorage("shamanKingInputShamanFightCountMemory2") var inputShamanFightCount: Int = 0
    @AppStorage("shamanKingEndingCountDefaultMemory2") var endingCountDefault: Int = 0
    @AppStorage("shamanKingEndingCountGusuJakuMemory2") var endingCountGusuJaku: Int = 0
    @AppStorage("shamanKingEndingCountGusuKyoMemory2") var endingCountGusuKyo: Int = 0
    @AppStorage("shamanKingEndingCountKisuJakuMemory2") var endingCountKisuJaku: Int = 0
    @AppStorage("shamanKingEndingCountKisuKyoMemory2") var endingCountKisuKyo: Int = 0
    @AppStorage("shamanKingEndingCountOver2SisaMemory2") var endingCountOver2Sisa: Int = 0
    @AppStorage("shamanKingEndingCountOver4SisaMemory2") var endingCountOver4Sisa: Int = 0
    @AppStorage("shamanKingEndingCountOver2Memory2") var endingCountOver2: Int = 0
    @AppStorage("shamanKingEndingCountOver4Memory2") var endingCountOver4: Int = 0
    @AppStorage("shamanKingEndingCountOver5Memory2") var endingCountOver5: Int = 0
    @AppStorage("shamanKingEndingCountOver6Memory2") var endingCountOver6: Int = 0
    @AppStorage("shamanKingEndingCountSumMemory2") var endingCountSum: Int = 0
    @AppStorage("shamanKingMemoMemory2") var memo = ""
    @AppStorage("shamanKingDateMemory2") var dateDouble = 0.0
}


// //// メモリー3
class ShamanKingMemory3: ObservableObject {
    @AppStorage("shamanKingJakuRareCountMemory3") var jakuRareCount: Int = 0
    @AppStorage("shamanKingBonusKokakuCountMemory3") var bonusKokakuCount: Int = 0
    @AppStorage("shamanKingReplayCounterCountFalseMemory3") var replayCounterReplayCount: Int = 0
    @AppStorage("shamanKingReplayCounterCountSuccesssMemory3") var replayCounterCountSuccesss: Int = 0
    @AppStorage("shamanKingHyoiCount78LoseMemory3") var hyoiCount78Lose: Int = 0
    @AppStorage("shamanKingHyoiCount78WinMemory3") var hyoiCount78Win: Int = 0
    @AppStorage("shamanKingHyoiCount78SumMemory3") var hyoiCount78Sum: Int = 0
    @AppStorage("shamanKingHyoiCount56LoseMemory3") var hyoiCount56Lose: Int = 0
    @AppStorage("shamanKingHyoiCount56WinMemory3") var hyoiCount56Win: Int = 0
    @AppStorage("shamanKingHyoiCount56SumMemory3") var hyoiCount56Sum: Int = 0
    @AppStorage("shamanKingHyoiCount4LoseMemory3") var hyoiCount4Lose: Int = 0
    @AppStorage("shamanKingHyoiCount4WinMemory3") var hyoiCount4Win: Int = 0
    @AppStorage("shamanKingHyoiCount4SumMemory3") var hyoiCount4Sum: Int = 0
    @AppStorage("shamanKingHyoiCount3LoseMemory3") var hyoiCount3Lose: Int = 0
    @AppStorage("shamanKingHyoiCount3WinMemory3") var hyoiCount3Win: Int = 0
    @AppStorage("shamanKingHyoiCount3SumMemory3") var hyoiCount3Sum: Int = 0
    @AppStorage("shamanKingInputGameMemory3") var inputGame: Int = 0
    @AppStorage("shamanKingInputShamanBonusCountMemory3") var inputShamanBonusCount: Int = 0
    @AppStorage("shamanKingInputEpisodeBonusCountMemory3") var inputEpisodeBonusCount: Int = 0
    @AppStorage("shamanKingBonusCountSumMemory3") var bonusCountSum: Int = 0
    @AppStorage("shamanKingInputShamanFightCountMemory3") var inputShamanFightCount: Int = 0
    @AppStorage("shamanKingEndingCountDefaultMemory3") var endingCountDefault: Int = 0
    @AppStorage("shamanKingEndingCountGusuJakuMemory3") var endingCountGusuJaku: Int = 0
    @AppStorage("shamanKingEndingCountGusuKyoMemory3") var endingCountGusuKyo: Int = 0
    @AppStorage("shamanKingEndingCountKisuJakuMemory3") var endingCountKisuJaku: Int = 0
    @AppStorage("shamanKingEndingCountKisuKyoMemory3") var endingCountKisuKyo: Int = 0
    @AppStorage("shamanKingEndingCountOver2SisaMemory3") var endingCountOver2Sisa: Int = 0
    @AppStorage("shamanKingEndingCountOver4SisaMemory3") var endingCountOver4Sisa: Int = 0
    @AppStorage("shamanKingEndingCountOver2Memory3") var endingCountOver2: Int = 0
    @AppStorage("shamanKingEndingCountOver4Memory3") var endingCountOver4: Int = 0
    @AppStorage("shamanKingEndingCountOver5Memory3") var endingCountOver5: Int = 0
    @AppStorage("shamanKingEndingCountOver6Memory3") var endingCountOver6: Int = 0
    @AppStorage("shamanKingEndingCountSumMemory3") var endingCountSum: Int = 0
    @AppStorage("shamanKingMemoMemory3") var memo = ""
    @AppStorage("shamanKingDateMemory3") var dateDouble = 0.0
}
