//
//  bioClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/03/11.
//

import Foundation
import SwiftUI

class Bio: ObservableObject {
    // ////////////////////////
    // 各種確率
    // ////////////////////////
    // CZ初当り
    let ratioCz = [
        147.3,
        143.5,
        137.5,
        133.7,
        129.6,
        122.1
    ]
    // AT初当り
    let ratioAt = [
        325.8,
        314.4,
        298.2,
        271.4,
        249.6,
        236.2
    ]
    // PZ初当り
    let ratioPz = [
        152.7,
        148.9,
        142.7,
        138.6,
        134.3,
        126.5
    ]
    // WZ初当り
    let ratioWz = [
        4165.3,
        3956.9,
        3773.3,
        3781.8,
        3703.3,
        3510.4
    ]
    
    // ////////////////////////
    // CZ,AT初当り
    // ////////////////////////
    // 選択肢の設定
    let selectListCzKind: [String] = [
        "パニックゾーン(PZ)",
        "ウェスカーゾーン(WZ)"
    ]
    let selectListAtHit: [String] = [
        "当選",
        "ハズレ"
    ]
    
    // 選択結果
    @AppStorage("bioSelectedCzKind") var selectedCzKind: String = "パニックゾーン(PZ)"
    @AppStorage("bioSelectedAtHit") var selectedAtHit: String = "当選"
    @AppStorage("bioInputGame") var inputGame: Int = 0
    
    // ゲーム数配列
    let gameArrayKey = "bioGameArrayKey"
    @AppStorage("bioGameArrayKey") var gameArrayData: Data?
    // 種類配列
    let kindArrayKey = "bioKindArrayKey"
    @AppStorage("bioKindArrayKey") var kindArrayData: Data?
    // AT当否配列
    let atHitArrayKey = "bioAtHitArrayKey"
    @AppStorage("bioAtHitArrayKey") var atHitArrayData: Data?
    
    // 結果集計用
    @AppStorage("bioPlayGameSum") var playGameSum: Int = 0
    @AppStorage("bioAtCount") var atCount: Int = 0
    @AppStorage("bioCzCount") var czCount: Int = 0
    
    // CZデータ登録
    func addHistoryCz() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: kindArrayData, addData: selectedCzKind, key: kindArrayKey)
        arrayStringAddData(arrayData: atHitArrayData, addData: selectedAtHit, key: atHitArrayKey)
        addRemoveCommon()
    }
    
    // AT直撃データ登録
    func addHistoryAt() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: kindArrayData, addData: "AT直撃", key: kindArrayKey)
        arrayStringAddData(arrayData: atHitArrayData, addData: selectListAtHit[0], key: atHitArrayKey)
        addRemoveCommon()
    }
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: kindArrayData, key: kindArrayKey)
        arrayStringRemoveLast(arrayData: atHitArrayData, key: atHitArrayKey)
        addRemoveCommon()
    }
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: kindArrayData, key: kindArrayKey)
        arrayStringRemoveAll(arrayData: atHitArrayData, key: atHitArrayKey)
        addRemoveCommon()
        inputGame = 0
        minusCheck = false
    }
    
    func addRemoveCommon() {
        playGameSum = arraySumPlayGameResetWordOne(gameArrayData: gameArrayData, bonusArrayData: atHitArrayData, resetWord: selectListAtHit[0])
        let pzCount = arrayStringDataCount(arrayData: kindArrayData, countString: selectListCzKind[0])
        let wzCount = arrayStringDataCount(arrayData: kindArrayData, countString: selectListCzKind[1])
        czCount = pzCount + wzCount
        atCount = arrayStringDataCount(arrayData: atHitArrayData, countString: selectListAtHit[0])
    }
    
    // ////////////////////////
    // 終了画面
    // ////////////////////////
    @AppStorage("bioScreenCountDefault") var screenCountDefault: Int = 0 {
        didSet {
            screenCountSum = countSum(screenCountDefault, screenCountKisu, screenCountGusu, screenCountExcepted1, screenCountExcepted2, screenCountExcepted3, screenCountHighJaku, screenCountHighKyo, screenCountOver3, screenCountOver4, screenCountOver5, screenCountOver6)
        }
    }
        @AppStorage("bioScreenCountKisu") var screenCountKisu: Int = 0 {
            didSet {
                screenCountSum = countSum(screenCountDefault, screenCountKisu, screenCountGusu, screenCountExcepted1, screenCountExcepted2, screenCountExcepted3, screenCountHighJaku, screenCountHighKyo, screenCountOver3, screenCountOver4, screenCountOver5, screenCountOver6)
            }
        }
            @AppStorage("bioScreenCountGusu") var screenCountGusu: Int = 0 {
                didSet {
                    screenCountSum = countSum(screenCountDefault, screenCountKisu, screenCountGusu, screenCountExcepted1, screenCountExcepted2, screenCountExcepted3, screenCountHighJaku, screenCountHighKyo, screenCountOver3, screenCountOver4, screenCountOver5, screenCountOver6)
                }
            }
                @AppStorage("bioScreenCountExcepted1") var screenCountExcepted1: Int = 0 {
                    didSet {
                        screenCountSum = countSum(screenCountDefault, screenCountKisu, screenCountGusu, screenCountExcepted1, screenCountExcepted2, screenCountExcepted3, screenCountHighJaku, screenCountHighKyo, screenCountOver3, screenCountOver4, screenCountOver5, screenCountOver6)
                    }
                }
                    @AppStorage("bioScreenCountExcepted2") var screenCountExcepted2: Int = 0 {
                        didSet {
                            screenCountSum = countSum(screenCountDefault, screenCountKisu, screenCountGusu, screenCountExcepted1, screenCountExcepted2, screenCountExcepted3, screenCountHighJaku, screenCountHighKyo, screenCountOver3, screenCountOver4, screenCountOver5, screenCountOver6)
                        }
                    }
                        @AppStorage("bioScreenCountExcepted3") var screenCountExcepted3: Int = 0 {
                            didSet {
                                screenCountSum = countSum(screenCountDefault, screenCountKisu, screenCountGusu, screenCountExcepted1, screenCountExcepted2, screenCountExcepted3, screenCountHighJaku, screenCountHighKyo, screenCountOver3, screenCountOver4, screenCountOver5, screenCountOver6)
                            }
                        }
                            @AppStorage("bioScreenCountHighJaku") var screenCountHighJaku: Int = 0 {
                                didSet {
                                    screenCountSum = countSum(screenCountDefault, screenCountKisu, screenCountGusu, screenCountExcepted1, screenCountExcepted2, screenCountExcepted3, screenCountHighJaku, screenCountHighKyo, screenCountOver3, screenCountOver4, screenCountOver5, screenCountOver6)
                                }
                            }
                                @AppStorage("bioScreenCountHighKyo") var screenCountHighKyo: Int = 0 {
                                    didSet {
                                        screenCountSum = countSum(screenCountDefault, screenCountKisu, screenCountGusu, screenCountExcepted1, screenCountExcepted2, screenCountExcepted3, screenCountHighJaku, screenCountHighKyo, screenCountOver3, screenCountOver4, screenCountOver5, screenCountOver6)
                                    }
                                }
                                    @AppStorage("bioScreenCountOver3") var screenCountOver3: Int = 0 {
                                        didSet {
                                            screenCountSum = countSum(screenCountDefault, screenCountKisu, screenCountGusu, screenCountExcepted1, screenCountExcepted2, screenCountExcepted3, screenCountHighJaku, screenCountHighKyo, screenCountOver3, screenCountOver4, screenCountOver5, screenCountOver6)
                                        }
                                    }
                                        @AppStorage("bioScreenCountOver4") var screenCountOver4: Int = 0 {
                                            didSet {
                                                screenCountSum = countSum(screenCountDefault, screenCountKisu, screenCountGusu, screenCountExcepted1, screenCountExcepted2, screenCountExcepted3, screenCountHighJaku, screenCountHighKyo, screenCountOver3, screenCountOver4, screenCountOver5, screenCountOver6)
                                            }
                                        }
                                            @AppStorage("bioScreenCountOver5") var screenCountOver5: Int = 0 {
                                                didSet {
                                                    screenCountSum = countSum(screenCountDefault, screenCountKisu, screenCountGusu, screenCountExcepted1, screenCountExcepted2, screenCountExcepted3, screenCountHighJaku, screenCountHighKyo, screenCountOver3, screenCountOver4, screenCountOver5, screenCountOver6)
                                                }
                                            }
                                                @AppStorage("bioScreenCountOver6") var screenCountOver6: Int = 0 {
                                                    didSet {
                                                        screenCountSum = countSum(screenCountDefault, screenCountKisu, screenCountGusu, screenCountExcepted1, screenCountExcepted2, screenCountExcepted3, screenCountHighJaku, screenCountHighKyo, screenCountOver3, screenCountOver4, screenCountOver5, screenCountOver6)
                                                    }
                                                }
    @AppStorage("bioScreenCountSum") var screenCountSum: Int = 0
    func resetScreen() {
        screenCountDefault = 0
        screenCountKisu = 0
        screenCountGusu = 0
        screenCountExcepted1 = 0
        screenCountExcepted2 = 0
        screenCountExcepted3 = 0
        screenCountHighJaku = 0
        screenCountHighKyo = 0
        screenCountOver3 = 0
        screenCountOver4 = 0
        screenCountOver5 = 0
        screenCountOver6 = 0
        minusCheck = false
    }
    
    
    // ////////////////////////
    // エンディング
    // ////////////////////////
    @AppStorage("bioEndingCountDefault") var endingCountDefault: Int = 0 {
        didSet {
            endingCountSum = countSum(endingCountDefault, endingCountKisu, endingCountGusu, endingCountHighJaku, endingCountHighKyo, endingCountOver4, endingCountOver5, endingCountOver6)
        }
    }
        @AppStorage("bioEndingCountKisu") var endingCountKisu: Int = 0 {
            didSet {
                endingCountSum = countSum(endingCountDefault, endingCountKisu, endingCountGusu, endingCountHighJaku, endingCountHighKyo, endingCountOver4, endingCountOver5, endingCountOver6)
            }
        }
            @AppStorage("bioEndingCountGusu") var endingCountGusu: Int = 0 {
                didSet {
                    endingCountSum = countSum(endingCountDefault, endingCountKisu, endingCountGusu, endingCountHighJaku, endingCountHighKyo, endingCountOver4, endingCountOver5, endingCountOver6)
                }
            }
                @AppStorage("bioEndingCountHighJaku") var endingCountHighJaku: Int = 0 {
                    didSet {
                        endingCountSum = countSum(endingCountDefault, endingCountKisu, endingCountGusu, endingCountHighJaku, endingCountHighKyo, endingCountOver4, endingCountOver5, endingCountOver6)
                    }
                }
                    @AppStorage("bioEndingCountHighKyo") var endingCountHighKyo: Int = 0 {
                        didSet {
                            endingCountSum = countSum(endingCountDefault, endingCountKisu, endingCountGusu, endingCountHighJaku, endingCountHighKyo, endingCountOver4, endingCountOver5, endingCountOver6)
                        }
                    }
                        @AppStorage("bioEndingCountOver4") var endingCountOver4: Int = 0 {
                            didSet {
                                endingCountSum = countSum(endingCountDefault, endingCountKisu, endingCountGusu, endingCountHighJaku, endingCountHighKyo, endingCountOver4, endingCountOver5, endingCountOver6)
                            }
                        }
                            @AppStorage("bioEndingCountOver5") var endingCountOver5: Int = 0 {
                                didSet {
                                    endingCountSum = countSum(endingCountDefault, endingCountKisu, endingCountGusu, endingCountHighJaku, endingCountHighKyo, endingCountOver4, endingCountOver5, endingCountOver6)
                                }
                            }
                                @AppStorage("bioEndingCountOver6") var endingCountOver6: Int = 0 {
                                    didSet {
                                        endingCountSum = countSum(endingCountDefault, endingCountKisu, endingCountGusu, endingCountHighJaku, endingCountHighKyo, endingCountOver4, endingCountOver5, endingCountOver6)
                                    }
                                }
    @AppStorage("bioEndingCountSum") var endingCountSum: Int = 0
    
    func resetEnding() {
        endingCountDefault = 0
        endingCountKisu = 0
        endingCountGusu = 0
        endingCountHighJaku = 0
        endingCountHighKyo = 0
        endingCountOver4 = 0
        endingCountOver5 = 0
        endingCountOver6 = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("bioMinusCheck") var minusCheck: Bool = false
    @AppStorage("bioSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetScreen()
        resetEnding()
        resetHistory()
    }
}

// //// メモリー1
class BioMemory1: ObservableObject {
    @AppStorage("bioGameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("bioKindArrayKeyMemory1") var kindArrayData: Data?
    @AppStorage("bioAtHitArrayKeyMemory1") var atHitArrayData: Data?
    @AppStorage("bioPlayGameSumMemory1") var playGameSum: Int = 0
    @AppStorage("bioAtCountMemory1") var atCount: Int = 0
    @AppStorage("bioCzCountMemory1") var czCount: Int = 0
    @AppStorage("bioScreenCountDefaultMemory1") var screenCountDefault: Int = 0
    @AppStorage("bioScreenCountKisuMemory1") var screenCountKisu: Int = 0
    @AppStorage("bioScreenCountGusuMemory1") var screenCountGusu: Int = 0
    @AppStorage("bioScreenCountExcepted1Memory1") var screenCountExcepted1: Int = 0
    @AppStorage("bioScreenCountExcepted2Memory1") var screenCountExcepted2: Int = 0
    @AppStorage("bioScreenCountExcepted3Memory1") var screenCountExcepted3: Int = 0
    @AppStorage("bioScreenCountHighJakuMemory1") var screenCountHighJaku: Int = 0
    @AppStorage("bioScreenCountHighKyoMemory1") var screenCountHighKyo: Int = 0
    @AppStorage("bioScreenCountOver3Memory1") var screenCountOver3: Int = 0
    @AppStorage("bioScreenCountOver4Memory1") var screenCountOver4: Int = 0
    @AppStorage("bioScreenCountOver5Memory1") var screenCountOver5: Int = 0
    @AppStorage("bioScreenCountOver6Memory1") var screenCountOver6: Int = 0
    @AppStorage("bioScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("bioEndingCountDefaultMemory1") var endingCountDefault: Int = 0
    @AppStorage("bioEndingCountKisuMemory1") var endingCountKisu: Int = 0
    @AppStorage("bioEndingCountGusuMemory1") var endingCountGusu: Int = 0
    @AppStorage("bioEndingCountHighJakuMemory1") var endingCountHighJaku: Int = 0
    @AppStorage("bioEndingCountHighKyoMemory1") var endingCountHighKyo: Int = 0
    @AppStorage("bioEndingCountOver4Memory1") var endingCountOver4: Int = 0
    @AppStorage("bioEndingCountOver5Memory1") var endingCountOver5: Int = 0
    @AppStorage("bioEndingCountOver6Memory1") var endingCountOver6: Int = 0
    @AppStorage("bioEndingCountSumMemory1") var endingCountSum: Int = 0
    @AppStorage("bioMemoMemory1") var memo = ""
    @AppStorage("bioDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class BioMemory2: ObservableObject {
    @AppStorage("bioGameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("bioKindArrayKeyMemory2") var kindArrayData: Data?
    @AppStorage("bioAtHitArrayKeyMemory2") var atHitArrayData: Data?
    @AppStorage("bioPlayGameSumMemory2") var playGameSum: Int = 0
    @AppStorage("bioAtCountMemory2") var atCount: Int = 0
    @AppStorage("bioCzCountMemory2") var czCount: Int = 0
    @AppStorage("bioScreenCountDefaultMemory2") var screenCountDefault: Int = 0
    @AppStorage("bioScreenCountKisuMemory2") var screenCountKisu: Int = 0
    @AppStorage("bioScreenCountGusuMemory2") var screenCountGusu: Int = 0
    @AppStorage("bioScreenCountExcepted1Memory2") var screenCountExcepted1: Int = 0
    @AppStorage("bioScreenCountExcepted2Memory2") var screenCountExcepted2: Int = 0
    @AppStorage("bioScreenCountExcepted3Memory2") var screenCountExcepted3: Int = 0
    @AppStorage("bioScreenCountHighJakuMemory2") var screenCountHighJaku: Int = 0
    @AppStorage("bioScreenCountHighKyoMemory2") var screenCountHighKyo: Int = 0
    @AppStorage("bioScreenCountOver3Memory2") var screenCountOver3: Int = 0
    @AppStorage("bioScreenCountOver4Memory2") var screenCountOver4: Int = 0
    @AppStorage("bioScreenCountOver5Memory2") var screenCountOver5: Int = 0
    @AppStorage("bioScreenCountOver6Memory2") var screenCountOver6: Int = 0
    @AppStorage("bioScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("bioEndingCountDefaultMemory2") var endingCountDefault: Int = 0
    @AppStorage("bioEndingCountKisuMemory2") var endingCountKisu: Int = 0
    @AppStorage("bioEndingCountGusuMemory2") var endingCountGusu: Int = 0
    @AppStorage("bioEndingCountHighJakuMemory2") var endingCountHighJaku: Int = 0
    @AppStorage("bioEndingCountHighKyoMemory2") var endingCountHighKyo: Int = 0
    @AppStorage("bioEndingCountOver4Memory2") var endingCountOver4: Int = 0
    @AppStorage("bioEndingCountOver5Memory2") var endingCountOver5: Int = 0
    @AppStorage("bioEndingCountOver6Memory2") var endingCountOver6: Int = 0
    @AppStorage("bioEndingCountSumMemory2") var endingCountSum: Int = 0
    @AppStorage("bioMemoMemory2") var memo = ""
    @AppStorage("bioDateMemory2") var dateDouble = 0.0
}


// //// メモリー3
class BioMemory3: ObservableObject {
    @AppStorage("bioGameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("bioKindArrayKeyMemory3") var kindArrayData: Data?
    @AppStorage("bioAtHitArrayKeyMemory3") var atHitArrayData: Data?
    @AppStorage("bioPlayGameSumMemory3") var playGameSum: Int = 0
    @AppStorage("bioAtCountMemory3") var atCount: Int = 0
    @AppStorage("bioCzCountMemory3") var czCount: Int = 0
    @AppStorage("bioScreenCountDefaultMemory3") var screenCountDefault: Int = 0
    @AppStorage("bioScreenCountKisuMemory3") var screenCountKisu: Int = 0
    @AppStorage("bioScreenCountGusuMemory3") var screenCountGusu: Int = 0
    @AppStorage("bioScreenCountExcepted1Memory3") var screenCountExcepted1: Int = 0
    @AppStorage("bioScreenCountExcepted2Memory3") var screenCountExcepted2: Int = 0
    @AppStorage("bioScreenCountExcepted3Memory3") var screenCountExcepted3: Int = 0
    @AppStorage("bioScreenCountHighJakuMemory3") var screenCountHighJaku: Int = 0
    @AppStorage("bioScreenCountHighKyoMemory3") var screenCountHighKyo: Int = 0
    @AppStorage("bioScreenCountOver3Memory3") var screenCountOver3: Int = 0
    @AppStorage("bioScreenCountOver4Memory3") var screenCountOver4: Int = 0
    @AppStorage("bioScreenCountOver5Memory3") var screenCountOver5: Int = 0
    @AppStorage("bioScreenCountOver6Memory3") var screenCountOver6: Int = 0
    @AppStorage("bioScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("bioEndingCountDefaultMemory3") var endingCountDefault: Int = 0
    @AppStorage("bioEndingCountKisuMemory3") var endingCountKisu: Int = 0
    @AppStorage("bioEndingCountGusuMemory3") var endingCountGusu: Int = 0
    @AppStorage("bioEndingCountHighJakuMemory3") var endingCountHighJaku: Int = 0
    @AppStorage("bioEndingCountHighKyoMemory3") var endingCountHighKyo: Int = 0
    @AppStorage("bioEndingCountOver4Memory3") var endingCountOver4: Int = 0
    @AppStorage("bioEndingCountOver5Memory3") var endingCountOver5: Int = 0
    @AppStorage("bioEndingCountOver6Memory3") var endingCountOver6: Int = 0
    @AppStorage("bioEndingCountSumMemory3") var endingCountSum: Int = 0
    @AppStorage("bioMemoMemory3") var memo = ""
    @AppStorage("bioDateMemory3") var dateDouble = 0.0
}
