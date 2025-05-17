//
//  gundamSeedClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/05/05.
//

import Foundation
import SwiftUI

class GundamSeed: ObservableObject {
    // //////////////
    // 初当り履歴
    // //////////////
    // 選択肢の設定
    let selectListBonusKind: [String] = ["CZ", "AT直撃"]
    let selectListAtHit: [String] = ["当選", "ハズレ"]
    
    // 選択結果
    @AppStorage("gundamSeedSelectedBonusKind") var selectedBonusKind: String = "CZ"
    @AppStorage("gundamSeedSelectedAtHit") var selectedAtHit: String = "当選"
    @AppStorage("gundamSeedInputGame") var inputGame: Int = 0
    
    // ゲーム数配列
    let gameArrayKey: String = "gundamSeedGameArrayKey"
    @AppStorage("gundamSeedGameArrayKey") var gameArrayData: Data?
    // 種類配列
    let bonusKindArrayKey: String = "gundamSeedBonusKindArrayKey"
    @AppStorage("gundamSeedBonusKindArrayKey") var bonusKindArrayData: Data?
    // AT当否配列
    let atHitArrayKey = "gundamSeedAtHitArrayKey"
    @AppStorage("gundamSeedAtHitArrayKey") var atHitArrayData: Data?
    
    // 結果集計用
    @AppStorage("gundamSeedPlayGameSum") var playGameSum: Int = 0
    @AppStorage("gundamSeedAtCount") var atCount: Int = 0
    @AppStorage("gundamSeedCzCount") var czCount: Int = 0
    @AppStorage("gundamSeedUnder100Count49") var under100Count49: Int = 0 {
        didSet {
            under100CountSum = countSum(under100Count49, under100Count99)
        }
    }
        @AppStorage("gundamSeedUnder100Count99") var under100Count99: Int = 0 {
            didSet {
                under100CountSum = countSum(under100Count49, under100Count99)
            }
        }
    @AppStorage("gundamSeedUnder100CountSum") var under100CountSum: Int = 0 {
        didSet {
            underOver100CountSum = countSum(under100CountSum, over100Count)
        }
    }
        @AppStorage("gundamSeedOver100Count") var over100Count: Int = 0 {
            didSet {
                underOver100CountSum = countSum(under100CountSum, over100Count)
            }
        }
    @AppStorage("gundamSeedUnderOver100CountSum") var underOver100CountSum: Int = 0
    
    // データ登録
    func addHistory() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: bonusKindArrayData, addData: selectedBonusKind, key: bonusKindArrayKey)
        arrayStringAddData(arrayData: atHitArrayData, addData: selectedAtHit, key: atHitArrayKey)
        addRemoveCommon()
    }
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: bonusKindArrayData, key: bonusKindArrayKey)
        arrayStringRemoveLast(arrayData: atHitArrayData, key: atHitArrayKey)
        addRemoveCommon()
    }
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: bonusKindArrayData, key: bonusKindArrayKey)
        arrayStringRemoveAll(arrayData: atHitArrayData, key: atHitArrayKey)
        addRemoveCommon()
        inputGame = 0
        minusCheck = false
    }
    
    func addRemoveCommon() {
        playGameSum = arraySumPlayGameResetWordOne(gameArrayData: gameArrayData, bonusArrayData: atHitArrayData, resetWord: selectListAtHit[0])
        czCount = arrayStringDataCount(arrayData: bonusKindArrayData, countString: selectListBonusKind[0])
        atCount = arrayStringDataCount(arrayData: atHitArrayData, countString: selectListAtHit[0])
        
        // //// 100以内の当選率算出用
        let gameArray = decodeIntArray(from: gameArrayData)
        let atHitArray = decodeStringArray(from: atHitArrayData)
        var u100Count49: Int = 0
        var u100Count99: Int = 0
        var o100Count: Int = 0
        
        // 配列の数を確認し0なら0を返す
        if gameArray.count == 0 {
            under100Count49 = 0
            under100Count99 = 0
            over100Count = 0
        }
        // 配列にデータがあれば1個ずつ確認しながらカウント
        else {
            for (index, game) in gameArray.enumerated() {
                // 一番最初のデータ処理
                if index == 0 {
//                    let game = gameArray[index]
                    // 当選ゲーム数が49以下ならカウントアップ
                    if game < 50 {
                        u100Count49 += 1
                    }
                    // 当選ゲーム数が99以下ならカウントアップ
                    else if game < 100 {
                        u100Count99 += 1
                    }
                    // 当選ゲーム数が100以上ならカウントアップ
                    else {
                        o100Count += 1
                    }
                }
                // 一番最初以外のデータ処理
                else {
                    let beforeIndex = index - 1
                    // 1個前のデータがあれば処理継続
                    if gameArray.indices.contains(beforeIndex) && atHitArray.indices.contains(beforeIndex){
                        // 1個前のデータがAT当選であればゲーム数に応じてカウントアップ
                        if atHitArray[beforeIndex] == selectListAtHit[0] {
//                            let hitGame = gameArray[index]
                            // 当選ゲーム数が49以下ならカウントアップ
                            if game < 50 {
                                u100Count49 += 1
                            }
                            // 当選ゲーム数が99以下ならカウントアップ
                            else if game < 100 {
                                u100Count99 += 1
                            }
                            // 当選ゲーム数が100以上ならカウントアップ
                            else {
                                o100Count += 1
                            }
                        }
                    }
                }
            }
            under100Count49 = u100Count49
            under100Count99 = u100Count99
            over100Count = o100Count
        }
    }
    
    let ratioAt: [Double] = [460.1,446.9,411.8,364.5,355.6,318.4]
    let ratioCz: [Double] = [362.2,377.3,349.1,309.7,301.6,266.9]
    let ratio0to49: [Double] = [4.28,4.31,4.47,5.07,5.39,6.91]
    let ratio50to99: [Double] = [27.58,27.73,28.14,29.73,30.07,32.08]
    let ratio0to99: [Double] = [31.86,32.04,32.61,34.80,35.45,38.99]
    
    // //////////////
    // 終了画面
    // //////////////
    @AppStorage("gundamSeedScreenCountDefault") var screenCountDefault: Int = 0 {
        didSet {
            screenCountSum = countSum(screenCountDefault, screenCountRebirth, screenCountKisu, screenCountGusu, screenCountHighJaku, screenCountHighKyo, screenCountChangeHigh, screenCountNegate1, screenCountNegate2, screenCountNegate3High, screenCountOver4, screenCountOver6, screenCountGusuFix)
        }
    }
        @AppStorage("gundamSeedScreenCountRebirth") var screenCountRebirth: Int = 0 {
            didSet {
                screenCountSum = countSum(screenCountDefault, screenCountRebirth, screenCountKisu, screenCountGusu, screenCountHighJaku, screenCountHighKyo, screenCountChangeHigh, screenCountNegate1, screenCountNegate2, screenCountNegate3High, screenCountOver4, screenCountOver6, screenCountGusuFix)
            }
        }
            @AppStorage("gundamSeedScreenCountKisu") var screenCountKisu: Int = 0 {
                didSet {
                    screenCountSum = countSum(screenCountDefault, screenCountRebirth, screenCountKisu, screenCountGusu, screenCountHighJaku, screenCountHighKyo, screenCountChangeHigh, screenCountNegate1, screenCountNegate2, screenCountNegate3High, screenCountOver4, screenCountOver6, screenCountGusuFix)
                }
            }
                @AppStorage("gundamSeedScreenCountGusu") var screenCountGusu: Int = 0 {
                    didSet {
                        screenCountSum = countSum(screenCountDefault, screenCountRebirth, screenCountKisu, screenCountGusu, screenCountHighJaku, screenCountHighKyo, screenCountChangeHigh, screenCountNegate1, screenCountNegate2, screenCountNegate3High, screenCountOver4, screenCountOver6, screenCountGusuFix)
                    }
                }
                    @AppStorage("gundamSeedScreenCountHighJaku") var screenCountHighJaku: Int = 0 {
                        didSet {
                            screenCountSum = countSum(screenCountDefault, screenCountRebirth, screenCountKisu, screenCountGusu, screenCountHighJaku, screenCountHighKyo, screenCountChangeHigh, screenCountNegate1, screenCountNegate2, screenCountNegate3High, screenCountOver4, screenCountOver6, screenCountGusuFix)
                        }
                    }
                        @AppStorage("gundamSeedScreenCountHighKyo") var screenCountHighKyo: Int = 0 {
                            didSet {
                                screenCountSum = countSum(screenCountDefault, screenCountRebirth, screenCountKisu, screenCountGusu, screenCountHighJaku, screenCountHighKyo, screenCountChangeHigh, screenCountNegate1, screenCountNegate2, screenCountNegate3High, screenCountOver4, screenCountOver6, screenCountGusuFix)
                            }
                        }
                            @AppStorage("gundamSeedScreenCountChangeHigh") var screenCountChangeHigh: Int = 0 {
                                didSet {
                                    screenCountSum = countSum(screenCountDefault, screenCountRebirth, screenCountKisu, screenCountGusu, screenCountHighJaku, screenCountHighKyo, screenCountChangeHigh, screenCountNegate1, screenCountNegate2, screenCountNegate3High, screenCountOver4, screenCountOver6, screenCountGusuFix)
                                }
                            }
                                @AppStorage("gundamSeedScreenCountGusuFix") var screenCountGusuFix: Int = 0 {
                                    didSet {
                                        screenCountSum = countSum(screenCountDefault, screenCountRebirth, screenCountKisu, screenCountGusu, screenCountHighJaku, screenCountHighKyo, screenCountChangeHigh, screenCountNegate1, screenCountNegate2, screenCountNegate3High, screenCountOver4, screenCountOver6, screenCountGusuFix)
                                    }
                                }
                                    @AppStorage("gundamSeedScreenCountNegate1") var screenCountNegate1: Int = 0 {
                                        didSet {
                                            screenCountSum = countSum(screenCountDefault, screenCountRebirth, screenCountKisu, screenCountGusu, screenCountHighJaku, screenCountHighKyo, screenCountChangeHigh, screenCountNegate1, screenCountNegate2, screenCountNegate3High, screenCountOver4, screenCountOver6, screenCountGusuFix)
                                        }
                                    }
                                        @AppStorage("gundamSeedScreenCountNegate2") var screenCountNegate2: Int = 0 {
                                            didSet {
                                                screenCountSum = countSum(screenCountDefault, screenCountRebirth, screenCountKisu, screenCountGusu, screenCountHighJaku, screenCountHighKyo, screenCountChangeHigh, screenCountNegate1, screenCountNegate2, screenCountNegate3High, screenCountOver4, screenCountOver6, screenCountGusuFix)
                                            }
                                        }
                                            @AppStorage("gundamSeedScreenCountNegate3High") var screenCountNegate3High: Int = 0 {
                                                didSet {
                                                    screenCountSum = countSum(screenCountDefault, screenCountRebirth, screenCountKisu, screenCountGusu, screenCountHighJaku, screenCountHighKyo, screenCountChangeHigh, screenCountNegate1, screenCountNegate2, screenCountNegate3High, screenCountOver4, screenCountOver6, screenCountGusuFix)
                                                }
                                            }
                                                @AppStorage("gundamSeedScreenCountOver4") var screenCountOver4: Int = 0 {
                                                    didSet {
                                                        screenCountSum = countSum(screenCountDefault, screenCountRebirth, screenCountKisu, screenCountGusu, screenCountHighJaku, screenCountHighKyo, screenCountChangeHigh, screenCountNegate1, screenCountNegate2, screenCountNegate3High, screenCountOver4, screenCountOver6, screenCountGusuFix)
                                                    }
                                                }
                                                    @AppStorage("gundamSeedScreenCountOver6") var screenCountOver6: Int = 0 {
                                                        didSet {
                                                            screenCountSum = countSum(screenCountDefault, screenCountRebirth, screenCountKisu, screenCountGusu, screenCountHighJaku, screenCountHighKyo, screenCountChangeHigh, screenCountNegate1, screenCountNegate2, screenCountNegate3High, screenCountOver4, screenCountOver6, screenCountGusuFix)
                                                        }
                                                    }
    @AppStorage("gundamSeedScreenCountSum") var screenCountSum: Int = 0
    
    func resetScreen() {
        screenCountDefault = 0
        screenCountRebirth = 0
        screenCountKisu = 0
        screenCountGusu = 0
        screenCountHighJaku = 0
        screenCountHighKyo = 0
        screenCountChangeHigh = 0
        screenCountGusuFix = 0
        screenCountNegate1 = 0
        screenCountNegate2 = 0
        screenCountNegate3High = 0
        screenCountOver4 = 0
        screenCountOver6 = 0
        minusCheck = false
    }
    
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("gundamSeedMinusCheck") var minusCheck: Bool = false
    @AppStorage("magiaSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetHistory()
        resetScreen()
    }
}


// メモリー1
class GundamSeedMemory1: ObservableObject {
    @AppStorage("gundamSeedGameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("gundamSeedBonusKindArrayKeyMemory1") var bonusKindArrayData: Data?
    @AppStorage("gundamSeedAtHitArrayKeyMemory1") var atHitArrayData: Data?
    @AppStorage("gundamSeedPlayGameSumMemory1") var playGameSum: Int = 0
    @AppStorage("gundamSeedAtCountMemory1") var atCount: Int = 0
    @AppStorage("gundamSeedCzCountMemory1") var czCount: Int = 0
    @AppStorage("gundamSeedUnder100Count49Memory1") var under100Count49: Int = 0
    @AppStorage("gundamSeedUnder100Count99Memory1") var under100Count99: Int = 0
    @AppStorage("gundamSeedUnder100CountSumMemory1") var under100CountSum: Int = 0
    @AppStorage("gundamSeedOver100CountMemory1") var over100Count: Int = 0
    @AppStorage("gundamSeedUnderOver100CountSumMemory1") var underOver100CountSum: Int = 0
    @AppStorage("gundamSeedScreenCountDefaultMemory1") var screenCountDefault: Int = 0
    @AppStorage("gundamSeedScreenCountRebirthMemory1") var screenCountRebirth: Int = 0
    @AppStorage("gundamSeedScreenCountKisuMemory1") var screenCountKisu: Int = 0
    @AppStorage("gundamSeedScreenCountGusuMemory1") var screenCountGusu: Int = 0
    @AppStorage("gundamSeedScreenCountHighJakuMemory1") var screenCountHighJaku: Int = 0
    @AppStorage("gundamSeedScreenCountHighKyoMemory1") var screenCountHighKyo: Int = 0
    @AppStorage("gundamSeedScreenCountChangeHighMemory1") var screenCountChangeHigh: Int = 0
    @AppStorage("gundamSeedScreenCountGusuFixMemory1") var screenCountGusuFix: Int = 0
    @AppStorage("gundamSeedScreenCountNegate1Memory1") var screenCountNegate1: Int = 0
    @AppStorage("gundamSeedScreenCountNegate2Memory1") var screenCountNegate2: Int = 0
    @AppStorage("gundamSeedScreenCountNegate3HighMemory1") var screenCountNegate3High: Int = 0
    @AppStorage("gundamSeedScreenCountOver4Memory1") var screenCountOver4: Int = 0
    @AppStorage("gundamSeedScreenCountOver6Memory1") var screenCountOver6: Int = 0
    @AppStorage("gundamSeedScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("gundamSeedMemoMemory1") var memo = ""
    @AppStorage("gundamSeedDateMemory1") var dateDouble = 0.0
}

// メモリー2
class GundamSeedMemory2: ObservableObject {
    @AppStorage("gundamSeedGameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("gundamSeedBonusKindArrayKeyMemory2") var bonusKindArrayData: Data?
    @AppStorage("gundamSeedAtHitArrayKeyMemory2") var atHitArrayData: Data?
    @AppStorage("gundamSeedPlayGameSumMemory2") var playGameSum: Int = 0
    @AppStorage("gundamSeedAtCountMemory2") var atCount: Int = 0
    @AppStorage("gundamSeedCzCountMemory2") var czCount: Int = 0
    @AppStorage("gundamSeedUnder100Count49Memory2") var under100Count49: Int = 0
    @AppStorage("gundamSeedUnder100Count99Memory2") var under100Count99: Int = 0
    @AppStorage("gundamSeedUnder100CountSumMemory2") var under100CountSum: Int = 0
    @AppStorage("gundamSeedOver100CountMemory2") var over100Count: Int = 0
    @AppStorage("gundamSeedUnderOver100CountSumMemory2") var underOver100CountSum: Int = 0
    @AppStorage("gundamSeedScreenCountDefaultMemory2") var screenCountDefault: Int = 0
    @AppStorage("gundamSeedScreenCountRebirthMemory2") var screenCountRebirth: Int = 0
    @AppStorage("gundamSeedScreenCountKisuMemory2") var screenCountKisu: Int = 0
    @AppStorage("gundamSeedScreenCountGusuMemory2") var screenCountGusu: Int = 0
    @AppStorage("gundamSeedScreenCountHighJakuMemory2") var screenCountHighJaku: Int = 0
    @AppStorage("gundamSeedScreenCountHighKyoMemory2") var screenCountHighKyo: Int = 0
    @AppStorage("gundamSeedScreenCountChangeHighMemory2") var screenCountChangeHigh: Int = 0
    @AppStorage("gundamSeedScreenCountGusuFixMemory2") var screenCountGusuFix: Int = 0
    @AppStorage("gundamSeedScreenCountNegate1Memory2") var screenCountNegate1: Int = 0
    @AppStorage("gundamSeedScreenCountNegate2Memory2") var screenCountNegate2: Int = 0
    @AppStorage("gundamSeedScreenCountNegate3HighMemory2") var screenCountNegate3High: Int = 0
    @AppStorage("gundamSeedScreenCountOver4Memory2") var screenCountOver4: Int = 0
    @AppStorage("gundamSeedScreenCountOver6Memory2") var screenCountOver6: Int = 0
    @AppStorage("gundamSeedScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("gundamSeedMemoMemory2") var memo = ""
    @AppStorage("gundamSeedDateMemory2") var dateDouble = 0.0
}

// メモリー3
class GundamSeedMemory3: ObservableObject {
    @AppStorage("gundamSeedGameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("gundamSeedBonusKindArrayKeyMemory3") var bonusKindArrayData: Data?
    @AppStorage("gundamSeedAtHitArrayKeyMemory3") var atHitArrayData: Data?
    @AppStorage("gundamSeedPlayGameSumMemory3") var playGameSum: Int = 0
    @AppStorage("gundamSeedAtCountMemory3") var atCount: Int = 0
    @AppStorage("gundamSeedCzCountMemory3") var czCount: Int = 0
    @AppStorage("gundamSeedUnder100Count49Memory3") var under100Count49: Int = 0
    @AppStorage("gundamSeedUnder100Count99Memory3") var under100Count99: Int = 0
    @AppStorage("gundamSeedUnder100CountSumMemory3") var under100CountSum: Int = 0
    @AppStorage("gundamSeedOver100CountMemory3") var over100Count: Int = 0
    @AppStorage("gundamSeedUnderOver100CountSumMemory3") var underOver100CountSum: Int = 0
    @AppStorage("gundamSeedScreenCountDefaultMemory3") var screenCountDefault: Int = 0
    @AppStorage("gundamSeedScreenCountRebirthMemory3") var screenCountRebirth: Int = 0
    @AppStorage("gundamSeedScreenCountKisuMemory3") var screenCountKisu: Int = 0
    @AppStorage("gundamSeedScreenCountGusuMemory3") var screenCountGusu: Int = 0
    @AppStorage("gundamSeedScreenCountHighJakuMemory3") var screenCountHighJaku: Int = 0
    @AppStorage("gundamSeedScreenCountHighKyoMemory3") var screenCountHighKyo: Int = 0
    @AppStorage("gundamSeedScreenCountChangeHighMemory3") var screenCountChangeHigh: Int = 0
    @AppStorage("gundamSeedScreenCountGusuFixMemory3") var screenCountGusuFix: Int = 0
    @AppStorage("gundamSeedScreenCountNegate1Memory3") var screenCountNegate1: Int = 0
    @AppStorage("gundamSeedScreenCountNegate2Memory3") var screenCountNegate2: Int = 0
    @AppStorage("gundamSeedScreenCountNegate3HighMemory3") var screenCountNegate3High: Int = 0
    @AppStorage("gundamSeedScreenCountOver4Memory3") var screenCountOver4: Int = 0
    @AppStorage("gundamSeedScreenCountOver6Memory3") var screenCountOver6: Int = 0
    @AppStorage("gundamSeedScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("gundamSeedMemoMemory3") var memo = ""
    @AppStorage("gundamSeedDateMemory3") var dateDouble = 0.0
}
