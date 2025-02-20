//
//  kabaneriViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/29.
//

import SwiftUI
import TipKit


// ///////////////////////
// 変数
// ///////////////////////
class Kabaneri: ObservableObject {
    // //////////////////
    // チャンス目発光率
    // //////////////////
    @AppStorage("kabaneriChanceWithoutFlushCount") var chanceWithoutFlushCount = 0 {
        didSet {
            chanceCountSum = countSum(chanceWithoutFlushCount, chanceWithFlushCount)
        }
    }
    @AppStorage("kabaneriChanceWithFlushCount") var chanceWithFlushCount = 0 {
        didSet {
            chanceCountSum = countSum(chanceWithoutFlushCount, chanceWithFlushCount)
        }
    }
    @AppStorage("kabaneriChanceCountSum") var chanceCountSum = 0
    // 共通ベル
    @AppStorage("kabaneriBellCount") var bellCount = 0
    @AppStorage("kabaneriStartGame") var startGame = 0 {
        didSet {
            let games = currentGame - startGame
            playGame = games > 0 ? games : 0
        }
    }
        @AppStorage("kabaneriCurrentGame") var currentGame = 0 {
            didSet {
                let games = currentGame - startGame
                playGame = games > 0 ? games : 0
            }
        }
    @AppStorage("kabaneriPlayGame") var playGame = 0
    
    func resetChance() {
        chanceWithoutFlushCount = 0
        chanceWithFlushCount = 0
        bellCount = 0
        startGame = 0
        currentGame = 0
        minusCheck = false
    }
    
    // ////////////////////
    // 当選履歴
    // ////////////////////
    // 選択肢の設定
    @Published var selectListBonus = ["CZ", "駿城", "エピボ", "現在"]
    @Published var selectListCzTrigger = ["-"]
    @Published var selectListCzType = ["無名", "生駒", "美馬"]
    @Published var selectListBonusTrigger = ["ゲーム数", "CZ", "天井", "その他"]
    @Published var selectListHayajiroStHit = ["ST当選", "STなし"]
    @Published var selectListEpiboStHit = ["ST当選"]
    @Published var selectListCurrentTrigger = ["-"]
    @Published var selectListCurrentRemarks = ["-"]
    // 選択結果の設定
    @Published var inputGame = 0
    @Published var selectedBonus = "CZ"
    @Published var selectedCzTrigger = "-"
    @Published var selectedCzType = "生駒"
    @Published var selectedBonusTrigger = "CZ"
    @Published var selectedHayajiroStHit = "STなし"
    @Published var selectedEpiboStHit = "ST当選"
    @Published var selectedCurrentTrigger = "-"
    @Published var selectedCurrentRemarks = "-"
    // //// 配列の設定
    // 当選ゲーム数配列
    let gameArrayKey = "kabaneriGameArrayKey"
    @AppStorage("kabaneriGameArrayKey") var gameArrayData: Data?
    // ボーナス種類配列
    let bonusArrayKey = "kabaneriBonusArrayKey"
    @AppStorage("kabaneriBonusArrayKey") var bonusArrayData: Data?
    // 当選契機配列
    let triggerArrayKey = "kabaneriTriggerArrayKey"
    @AppStorage("kabaneriTriggerArrayKey") var triggerArrayData: Data?
    // 備考配列
    let remarksArrayKey = "kabaneriRemarksArrayKey"
    @AppStorage("kabaneriRemarksArrayKey") var remarksArrayData: Data?
    // 集計結果の変数設定
    @AppStorage("kabaneriCzHitCount") var czHitCount = 0
    @AppStorage("kabaneriHistoryPlayGame") var historyPlayGame = 0
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: bonusArrayData, key: bonusArrayKey)
        arrayStringRemoveLast(arrayData: triggerArrayData, key: triggerArrayKey)
        arrayStringRemoveLast(arrayData: remarksArrayData, key: remarksArrayKey)
        czHitCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "CZ")
        historyPlayGame = arraySumPlayGameResetWordOne(gameArrayData: gameArrayData, bonusArrayData: remarksArrayData, resetWord: "ST当選")
        inputGame = 0
        selectedBonus = "CZ"
        selectedCzTrigger = "-"
        selectedCzType = "生駒"
        selectedBonusTrigger = "CZ"
        selectedHayajiroStHit = "STなし"
        selectedEpiboStHit = "ST当選"
        selectedCurrentTrigger = "-"
        selectedCurrentRemarks = "-"
    }
    
    // データ追加 CZ
    func addDataHistoryCz() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: bonusArrayData, addData: selectedBonus, key: bonusArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedCzTrigger, key: triggerArrayKey)
        arrayStringAddData(arrayData: remarksArrayData, addData: selectedCzType, key: remarksArrayKey)
        czHitCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "CZ")
        historyPlayGame = arraySumPlayGameResetWordOne(gameArrayData: gameArrayData, bonusArrayData: remarksArrayData, resetWord: "ST当選")
        inputGame = 0
        selectedBonus = "CZ"
        selectedCzTrigger = "-"
        selectedCzType = "生駒"
        selectedBonusTrigger = "CZ"
        selectedHayajiroStHit = "STなし"
        selectedEpiboStHit = "ST当選"
        selectedCurrentTrigger = "-"
        selectedCurrentRemarks = "-"
    }
    
    // データ追加 駿城
    func addDataHistoryHayajiro() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: bonusArrayData, addData: selectedBonus, key: bonusArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedBonusTrigger, key: triggerArrayKey)
        arrayStringAddData(arrayData: remarksArrayData, addData: selectedHayajiroStHit, key: remarksArrayKey)
        czHitCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "CZ")
        historyPlayGame = arraySumPlayGameResetWordOne(gameArrayData: gameArrayData, bonusArrayData: remarksArrayData, resetWord: "ST当選")
        inputGame = 0
        selectedBonus = "CZ"
        selectedCzTrigger = "-"
        selectedCzType = "生駒"
        selectedBonusTrigger = "CZ"
        selectedHayajiroStHit = "STなし"
        selectedEpiboStHit = "ST当選"
        selectedCurrentTrigger = "-"
        selectedCurrentRemarks = "-"
    }
    
    // データ追加 エピボ
    func addDataHistoryEpibo() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: bonusArrayData, addData: selectedBonus, key: bonusArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedBonusTrigger, key: triggerArrayKey)
        arrayStringAddData(arrayData: remarksArrayData, addData: selectedEpiboStHit, key: remarksArrayKey)
        czHitCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "CZ")
        historyPlayGame = arraySumPlayGameResetWordOne(gameArrayData: gameArrayData, bonusArrayData: remarksArrayData, resetWord: "ST当選")
        inputGame = 0
        selectedBonus = "CZ"
        selectedCzTrigger = "-"
        selectedCzType = "生駒"
        selectedBonusTrigger = "CZ"
        selectedHayajiroStHit = "STなし"
        selectedEpiboStHit = "ST当選"
        selectedCurrentTrigger = "-"
        selectedCurrentRemarks = "-"
    }
    
    // データ追加 現在
    func addDataHistoryCurrent() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: bonusArrayData, addData: selectedBonus, key: bonusArrayKey)
        arrayStringAddData(arrayData: triggerArrayData, addData: selectedCurrentTrigger, key: triggerArrayKey)
        arrayStringAddData(arrayData: remarksArrayData, addData: selectedCurrentRemarks, key: remarksArrayKey)
        czHitCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "CZ")
        historyPlayGame = arraySumPlayGameResetWordOne(gameArrayData: gameArrayData, bonusArrayData: remarksArrayData, resetWord: "ST当選")
        inputGame = 0
        selectedBonus = "CZ"
        selectedCzTrigger = "-"
        selectedCzType = "生駒"
        selectedBonusTrigger = "CZ"
        selectedHayajiroStHit = "STなし"
        selectedEpiboStHit = "ST当選"
        selectedCurrentTrigger = "-"
        selectedCurrentRemarks = "-"
    }
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: bonusArrayData, key: bonusArrayKey)
        arrayStringRemoveAll(arrayData: triggerArrayData, key: triggerArrayKey)
        arrayStringRemoveAll(arrayData: remarksArrayData, key: remarksArrayKey)
        czHitCount = arrayStringDataCount(arrayData: bonusArrayData, countString: "CZ")
        historyPlayGame = arraySumPlayGameResetWordOne(gameArrayData: gameArrayData, bonusArrayData: remarksArrayData, resetWord: "ST当選")
        inputGame = 0
        selectedBonus = "CZ"
        selectedCzTrigger = "-"
        selectedCzType = "生駒"
        selectedBonusTrigger = "CZ"
        selectedHayajiroStHit = "STなし"
        selectedEpiboStHit = "ST当選"
        selectedCurrentTrigger = "-"
        selectedCurrentRemarks = "-"
    }
    
    // ////////////////////
    // 規定ゲーム数での当選
    // ////////////////////
    // ピッカー用
//    @Published var bonusGameSelected = ""
//    @Published var bonusGameSelectList = ["100G", "250G", "450G", "650G"]
    // 100G
    @AppStorage("kabaneriBonus100LoseCount") var bonus100LoseCount = 0 {
        didSet {
            bonus100CountSum = countSum(bonus100LoseCount + bonus100WinCount)
        }
    }
        @AppStorage("kabaneriBonus100WinCount") var bonus100WinCount = 0 {
            didSet {
                bonus100CountSum = countSum(bonus100LoseCount + bonus100WinCount)
            }
        }
    @AppStorage("kabaneriBonus100CountSum") var bonus100CountSum = 0
    // 250G
    @AppStorage("kabaneriBonus250LoseCount") var bonus250LoseCount = 0 {
        didSet {
            bonus250CountSum = countSum(bonus250LoseCount + bonus250WinCount)
        }
    }
        @AppStorage("kabaneriBonus250WinCount") var bonus250WinCount = 0 {
            didSet {
                bonus250CountSum = countSum(bonus250LoseCount + bonus250WinCount)
            }
        }
    @AppStorage("kabaneriBonus250CountSum") var bonus250CountSum = 0
    // 450G
    @AppStorage("kabaneriBonus450LoseCount") var bonus450LoseCount = 0 {
        didSet {
            bonus450CountSum = countSum(bonus450LoseCount + bonus450WinCount)
        }
    }
        @AppStorage("kabaneriBonus450WinCount") var bonus450WinCount = 0 {
            didSet {
                bonus450CountSum = countSum(bonus450LoseCount + bonus450WinCount)
            }
        }
    @AppStorage("kabaneriBonus450CountSum") var bonus450CountSum = 0
    // 650G
    @AppStorage("kabaneriBonus650LoseCount") var bonus650LoseCount = 0 {
        didSet {
            bonus650CountSum = countSum(bonus650LoseCount + bonus650WinCount)
        }
    }
        @AppStorage("kabaneriBonus650WinCount") var bonus650WinCount = 0 {
            didSet {
                bonus650CountSum = countSum(bonus650LoseCount + bonus650WinCount)
            }
        }
    @AppStorage("kabaneriBonus650CountSum") var bonus650CountSum = 0
    
    func resetBonus() {
        bonus100LoseCount = 0
        bonus100WinCount = 0
        bonus250LoseCount = 0
        bonus250WinCount = 0
        bonus450LoseCount = 0
        bonus450WinCount = 0
        bonus650LoseCount = 0
        bonus650WinCount = 0
        minusCheck = false
        resetHistory()
    }
    
    // /////////////////
    // 無名CZ
    // /////////////////
    @AppStorage("kabaneriMumeiNaviNoneCount") var mumeiNaviNoneCount = 0 {
        didSet {
            mumeiNaviCountSum = countSum(mumeiNaviNoneCount, mumeiNaviCount)
        }
    }
        @AppStorage("kabaneriMumeiNaviCount") var mumeiNaviCount = 0 {
            didSet {
                mumeiNaviCountSum = countSum(mumeiNaviNoneCount, mumeiNaviCount)
            }
        }
    @AppStorage("kabaneriMumeiNaviCountSum") var mumeiNaviCountSum = 0
    // ３連撃
    @AppStorage("kabaneriMumei3renLoseCount") var mumei3renLoseCount = 0 {
        didSet {
            mumei3renCountSum = countSum(mumei3renLoseCount, mumei3renWinCount)
        }
    }
        @AppStorage("kabaneriMumei3renWinCount") var mumei3renWinCount = 0 {
            didSet {
                mumei3renCountSum = countSum(mumei3renLoseCount, mumei3renWinCount)
            }
        }
    @AppStorage("kabaneriMumei3renCountSum") var mumei3renCountSum = 0
    
    func resetMumei() {
        mumeiNaviNoneCount = 0
        mumeiNaviCount = 0
        mumei3renLoseCount = 0
        mumei3renWinCount = 0
    }
    
    // /////////////////
    // 生駒CZ
    // /////////////////
    // ライフ３
    @AppStorage("kabaneriIcomaLife3DamageCount") var icomaLife3DamageCount = 0 {
        didSet {
            icomaLife3CountSum = countSum(icomaLife3DamageCount, icomaLife3NoDamageCount)
        }
    }
        @AppStorage("kabaneriIcomaLife3NoDamageCount") var icomaLife3NoDamageCount = 0 {
            didSet {
                icomaLife3CountSum = countSum(icomaLife3DamageCount, icomaLife3NoDamageCount)
            }
        }
    @AppStorage("kabaneriIcomaLife3CountSum") var icomaLife3CountSum = 0
    // ライフ２
    @AppStorage("kabaneriIcomaLife2DamageCount") var icomaLife2DamageCount = 0 {
        didSet {
            icomaLife2CountSum = countSum(icomaLife2DamageCount, icomaLife2NoDamageCount)
        }
    }
        @AppStorage("kabaneriIcomaLife2NoDamageCount") var icomaLife2NoDamageCount = 0 {
            didSet {
                icomaLife2CountSum = countSum(icomaLife2DamageCount, icomaLife2NoDamageCount)
            }
        }
    @AppStorage("kabaneriIcomaLife2CountSum") var icomaLife2CountSum = 0
    // ライフ1
    @AppStorage("kabaneriIcomaLife1DamageCount") var icomaLife1DamageCount = 0 {
        didSet {
            icomaLife1CountSum = countSum(icomaLife1DamageCount, icomaLife1NoDamageCount)
        }
    }
        @AppStorage("kabaneriIcomaLife1NoDamageCount") var icomaLife1NoDamageCount = 0 {
            didSet {
                icomaLife1CountSum = countSum(icomaLife1DamageCount, icomaLife1NoDamageCount)
            }
        }
    @AppStorage("kabaneriIcomaLife1CountSum") var icomaLife1CountSum = 0
    
    func resetIcoma() {
        icomaLife3DamageCount = 0
        icomaLife3NoDamageCount = 0
        icomaLife2DamageCount = 0
        icomaLife2NoDamageCount = 0
        icomaLife1DamageCount = 0
        icomaLife1NoDamageCount = 0
        minusCheck = false
    }
    
    // //////////////////////
    // カバネリボーナス中の示唆
    // //////////////////////
    @AppStorage("kabaneriSexMaleCount") var sexMaleCount = 0 {
        didSet {
            sexCountSum = countSum(sexMaleCount, sexFemaleCount)
        }
    }
        @AppStorage("kabaneriSexFemaleCount") var sexFemaleCount = 0 {
            didSet {
                sexCountSum = countSum(sexMaleCount, sexFemaleCount)
            }
        }
    @AppStorage("kabaneriSexCountSum") var sexCountSum = 0
    
    
    func resetHintDuringBonus() {
        sexMaleCount = 0
        sexFemaleCount = 0
        minusCheck = false
    }
    
    // /////////////////
    // 共通
    // /////////////////
    @AppStorage("kabaneriMinusCheck") var minusCheck = false
    @AppStorage("kabaneriSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetChance()
        resetBonus()
        resetMumei()
        resetIcoma()
        resetHintDuringBonus()
        minusCheck = false
    }
    
}


// //// メモリー1
class KabaneriMemory1: ObservableObject {
    @AppStorage("kabaneriChanceWithoutFlushCountMemory1") var chanceWithoutFlushCount = 0
    @AppStorage("kabaneriChanceWithFlushCountMemory1") var chanceWithFlushCount = 0
    @AppStorage("kabaneriChanceCountSumMemory1") var chanceCountSum = 0
    @AppStorage("kabaneriBellCountMemory1") var bellCount = 0
    @AppStorage("kabaneriStartGameMemory1") var startGame = 0
    @AppStorage("kabaneriCurrentGameMemory1") var currentGame = 0
    @AppStorage("kabaneriPlayGameMemory1") var playGame = 0
    @AppStorage("kabaneriGameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("kabaneriBonusArrayKeyMemory1") var bonusArrayData: Data?
    @AppStorage("kabaneriTriggerArrayKeyMemory1") var triggerArrayData: Data?
    @AppStorage("kabaneriRemarksArrayKeyMemory1") var remarksArrayData: Data?
    @AppStorage("kabaneriCzHitCountMemory1") var czHitCount = 0
    @AppStorage("kabaneriHistoryPlayGameMemory1") var historyPlayGame = 0
    @AppStorage("kabaneriBonus100LoseCountMemory1") var bonus100LoseCount = 0
    @AppStorage("kabaneriBonus100WinCountMemory1") var bonus100WinCount = 0
    @AppStorage("kabaneriBonus100CountSumMemory1") var bonus100CountSum = 0
    @AppStorage("kabaneriBonus250LoseCountMemory1") var bonus250LoseCount = 0
    @AppStorage("kabaneriBonus250WinCountMemory1") var bonus250WinCount = 0
    @AppStorage("kabaneriBonus250CountSumMemory1") var bonus250CountSum = 0
    @AppStorage("kabaneriBonus450LoseCountMemory1") var bonus450LoseCount = 0
    @AppStorage("kabaneriBonus450WinCountMemory1") var bonus450WinCount = 0
    @AppStorage("kabaneriBonus450CountSumMemory1") var bonus450CountSum = 0
    @AppStorage("kabaneriBonus650LoseCountMemory1") var bonus650LoseCount = 0
    @AppStorage("kabaneriBonus650WinCountMemory1") var bonus650WinCount = 0
    @AppStorage("kabaneriBonus650CountSumMemory1") var bonus650CountSum = 0
    @AppStorage("kabaneriMumeiNaviNoneCountMemory1") var mumeiNaviNoneCount = 0
    @AppStorage("kabaneriMumeiNaviCountMemory1") var mumeiNaviCount = 0
    @AppStorage("kabaneriMumeiNaviCountSumMemory1") var mumeiNaviCountSum = 0
    @AppStorage("kabaneriMumei3renLoseCountMemory1") var mumei3renLoseCount = 0
    @AppStorage("kabaneriMumei3renWinCountMemory1") var mumei3renWinCount = 0
    @AppStorage("kabaneriMumei3renCountSumMemory1") var mumei3renCountSum = 0
    @AppStorage("kabaneriIcomaLife3DamageCountMemory1") var icomaLife3DamageCount = 0
    @AppStorage("kabaneriIcomaLife3NoDamageCountMemory1") var icomaLife3NoDamageCount = 0
    @AppStorage("kabaneriIcomaLife3CountSumMemory1") var icomaLife3CountSum = 0
    @AppStorage("kabaneriIcomaLife2DamageCountMemory1") var icomaLife2DamageCount = 0
    @AppStorage("kabaneriIcomaLife2NoDamageCountMemory1") var icomaLife2NoDamageCount = 0
    @AppStorage("kabaneriIcomaLife2CountSumMemory1") var icomaLife2CountSum = 0
    @AppStorage("kabaneriIcomaLife1DamageCountMemory1") var icomaLife1DamageCount = 0
    @AppStorage("kabaneriIcomaLife1NoDamageCountMemory1") var icomaLife1NoDamageCount = 0
    @AppStorage("kabaneriIcomaLife1CountSumMemory1") var icomaLife1CountSum = 0
    @AppStorage("kabaneriSexMaleCountMemory1") var sexMaleCount = 0
    @AppStorage("kabaneriSexFemaleCountMemory1") var sexFemaleCount = 0
    @AppStorage("kabaneriSexCountSumMemory1") var sexCountSum = 0
    @AppStorage("kabaneriMemoMemory1") var memo = ""
    @AppStorage("kabaneriDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class KabaneriMemory2: ObservableObject {
    @AppStorage("kabaneriChanceWithoutFlushCountMemory2") var chanceWithoutFlushCount = 0
    @AppStorage("kabaneriChanceWithFlushCountMemory2") var chanceWithFlushCount = 0
    @AppStorage("kabaneriChanceCountSumMemory2") var chanceCountSum = 0
    @AppStorage("kabaneriBellCountMemory2") var bellCount = 0
    @AppStorage("kabaneriStartGameMemory2") var startGame = 0
    @AppStorage("kabaneriCurrentGameMemory2") var currentGame = 0
    @AppStorage("kabaneriPlayGameMemory2") var playGame = 0
    @AppStorage("kabaneriGameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("kabaneriBonusArrayKeyMemory2") var bonusArrayData: Data?
    @AppStorage("kabaneriTriggerArrayKeyMemory2") var triggerArrayData: Data?
    @AppStorage("kabaneriRemarksArrayKeyMemory2") var remarksArrayData: Data?
    @AppStorage("kabaneriCzHitCountMemory2") var czHitCount = 0
    @AppStorage("kabaneriHistoryPlayGameMemory2") var historyPlayGame = 0
    @AppStorage("kabaneriBonus100LoseCountMemory2") var bonus100LoseCount = 0
    @AppStorage("kabaneriBonus100WinCountMemory2") var bonus100WinCount = 0
    @AppStorage("kabaneriBonus100CountSumMemory2") var bonus100CountSum = 0
    @AppStorage("kabaneriBonus250LoseCountMemory2") var bonus250LoseCount = 0
    @AppStorage("kabaneriBonus250WinCountMemory2") var bonus250WinCount = 0
    @AppStorage("kabaneriBonus250CountSumMemory2") var bonus250CountSum = 0
    @AppStorage("kabaneriBonus450LoseCountMemory2") var bonus450LoseCount = 0
    @AppStorage("kabaneriBonus450WinCountMemory2") var bonus450WinCount = 0
    @AppStorage("kabaneriBonus450CountSumMemory2") var bonus450CountSum = 0
    @AppStorage("kabaneriBonus650LoseCountMemory2") var bonus650LoseCount = 0
    @AppStorage("kabaneriBonus650WinCountMemory2") var bonus650WinCount = 0
    @AppStorage("kabaneriBonus650CountSumMemory2") var bonus650CountSum = 0
    @AppStorage("kabaneriMumeiNaviNoneCountMemory2") var mumeiNaviNoneCount = 0
    @AppStorage("kabaneriMumeiNaviCountMemory2") var mumeiNaviCount = 0
    @AppStorage("kabaneriMumeiNaviCountSumMemory2") var mumeiNaviCountSum = 0
    @AppStorage("kabaneriMumei3renLoseCountMemory2") var mumei3renLoseCount = 0
    @AppStorage("kabaneriMumei3renWinCountMemory2") var mumei3renWinCount = 0
    @AppStorage("kabaneriMumei3renCountSumMemory2") var mumei3renCountSum = 0
    @AppStorage("kabaneriIcomaLife3DamageCountMemory2") var icomaLife3DamageCount = 0
    @AppStorage("kabaneriIcomaLife3NoDamageCountMemory2") var icomaLife3NoDamageCount = 0
    @AppStorage("kabaneriIcomaLife3CountSumMemory2") var icomaLife3CountSum = 0
    @AppStorage("kabaneriIcomaLife2DamageCountMemory2") var icomaLife2DamageCount = 0
    @AppStorage("kabaneriIcomaLife2NoDamageCountMemory2") var icomaLife2NoDamageCount = 0
    @AppStorage("kabaneriIcomaLife2CountSumMemory2") var icomaLife2CountSum = 0
    @AppStorage("kabaneriIcomaLife1DamageCountMemory2") var icomaLife1DamageCount = 0
    @AppStorage("kabaneriIcomaLife1NoDamageCountMemory2") var icomaLife1NoDamageCount = 0
    @AppStorage("kabaneriIcomaLife1CountSumMemory2") var icomaLife1CountSum = 0
    @AppStorage("kabaneriSexMaleCountMemory2") var sexMaleCount = 0
    @AppStorage("kabaneriSexFemaleCountMemory2") var sexFemaleCount = 0
    @AppStorage("kabaneriSexCountSumMemory2") var sexCountSum = 0
    @AppStorage("kabaneriMemoMemory2") var memo = ""
    @AppStorage("kabaneriDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class KabaneriMemory3: ObservableObject {
    @AppStorage("kabaneriChanceWithoutFlushCountMemory3") var chanceWithoutFlushCount = 0
    @AppStorage("kabaneriChanceWithFlushCountMemory3") var chanceWithFlushCount = 0
    @AppStorage("kabaneriChanceCountSumMemory3") var chanceCountSum = 0
    @AppStorage("kabaneriBellCountMemory3") var bellCount = 0
    @AppStorage("kabaneriStartGameMemory3") var startGame = 0
    @AppStorage("kabaneriCurrentGameMemory3") var currentGame = 0
    @AppStorage("kabaneriPlayGameMemory3") var playGame = 0
    @AppStorage("kabaneriGameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("kabaneriBonusArrayKeyMemory3") var bonusArrayData: Data?
    @AppStorage("kabaneriTriggerArrayKeyMemory3") var triggerArrayData: Data?
    @AppStorage("kabaneriRemarksArrayKeyMemory3") var remarksArrayData: Data?
    @AppStorage("kabaneriCzHitCountMemory3") var czHitCount = 0
    @AppStorage("kabaneriHistoryPlayGameMemory3") var historyPlayGame = 0
    @AppStorage("kabaneriBonus100LoseCountMemory3") var bonus100LoseCount = 0
    @AppStorage("kabaneriBonus100WinCountMemory3") var bonus100WinCount = 0
    @AppStorage("kabaneriBonus100CountSumMemory3") var bonus100CountSum = 0
    @AppStorage("kabaneriBonus250LoseCountMemory3") var bonus250LoseCount = 0
    @AppStorage("kabaneriBonus250WinCountMemory3") var bonus250WinCount = 0
    @AppStorage("kabaneriBonus250CountSumMemory3") var bonus250CountSum = 0
    @AppStorage("kabaneriBonus450LoseCountMemory3") var bonus450LoseCount = 0
    @AppStorage("kabaneriBonus450WinCountMemory3") var bonus450WinCount = 0
    @AppStorage("kabaneriBonus450CountSumMemory3") var bonus450CountSum = 0
    @AppStorage("kabaneriBonus650LoseCountMemory3") var bonus650LoseCount = 0
    @AppStorage("kabaneriBonus650WinCountMemory3") var bonus650WinCount = 0
    @AppStorage("kabaneriBonus650CountSumMemory3") var bonus650CountSum = 0
    @AppStorage("kabaneriMumeiNaviNoneCountMemory3") var mumeiNaviNoneCount = 0
    @AppStorage("kabaneriMumeiNaviCountMemory3") var mumeiNaviCount = 0
    @AppStorage("kabaneriMumeiNaviCountSumMemory3") var mumeiNaviCountSum = 0
    @AppStorage("kabaneriMumei3renLoseCountMemory3") var mumei3renLoseCount = 0
    @AppStorage("kabaneriMumei3renWinCountMemory3") var mumei3renWinCount = 0
    @AppStorage("kabaneriMumei3renCountSumMemory3") var mumei3renCountSum = 0
    @AppStorage("kabaneriIcomaLife3DamageCountMemory3") var icomaLife3DamageCount = 0
    @AppStorage("kabaneriIcomaLife3NoDamageCountMemory3") var icomaLife3NoDamageCount = 0
    @AppStorage("kabaneriIcomaLife3CountSumMemory3") var icomaLife3CountSum = 0
    @AppStorage("kabaneriIcomaLife2DamageCountMemory3") var icomaLife2DamageCount = 0
    @AppStorage("kabaneriIcomaLife2NoDamageCountMemory3") var icomaLife2NoDamageCount = 0
    @AppStorage("kabaneriIcomaLife2CountSumMemory3") var icomaLife2CountSum = 0
    @AppStorage("kabaneriIcomaLife1DamageCountMemory3") var icomaLife1DamageCount = 0
    @AppStorage("kabaneriIcomaLife1NoDamageCountMemory3") var icomaLife1NoDamageCount = 0
    @AppStorage("kabaneriIcomaLife1CountSumMemory3") var icomaLife1CountSum = 0
    @AppStorage("kabaneriSexMaleCountMemory3") var sexMaleCount = 0
    @AppStorage("kabaneriSexFemaleCountMemory3") var sexFemaleCount = 0
    @AppStorage("kabaneriSexCountSumMemory3") var sexCountSum = 0
    @AppStorage("kabaneriMemoMemory3") var memo = ""
    @AppStorage("kabaneriDateMemory3") var dateDouble = 0.0
}

struct kabaneriViewTop: View {
    @ObservedObject var kabaneri = Kabaneri()
    @State var isShowAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // チャンス目発光率
                    NavigationLink(destination: kabaneriViewChance()) {
                        unitLabelMenu(imageSystemName: "sun.min", textBody: "通常時子役")
                    }
                    // CZ、ボーナス初当たり
                    NavigationLink(destination: kabaneriViewCzBonus()) {
                        unitLabelMenu(imageSystemName: "pencil.and.list.clipboard", textBody: "CZ,ボーナス初当り履歴")
                    }
                    // 無名CZ
                    NavigationLink(destination: kabaneriMumei()) {
                        unitLabelMenu(imageSystemName: "figure.kickboxing", textBody: "無名CZ")
                    }
                    // 生駒CZ
                    NavigationLink(destination: kabaneriViewIkoma()) {
                        unitLabelMenu(imageSystemName: "circle.grid.2x1.left.filled", textBody: "生駒CZ")
                    }
                    // カバネリボーナス中の示唆
                    NavigationLink(destination: kabaneriViewHintDuringBonus()) {
                        unitLabelMenu(imageSystemName: "figure.dress.line.vertical.figure", textBody: "カバネリボーナス中の示唆")
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "甲鉄城のカバネリ")
                }
                // 設定推測グラフ
                NavigationLink(destination: kabaneriView95Ci()) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4160")
                    .popoverTip(tipVer220AddLink())
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    HStack {
                        // //// データ読み出し
                        unitButtonLoadMemory(loadView: AnyView(kabaneriViewLoadMemory()))
                        // //// データ保存
                        unitButtonSaveMemory(saveView: AnyView(kabaneriViewSaveMemory()))
                    }
                    .popoverTip(tipUnitButtonMemory())
                    unitButtonReset(isShowAlert: $isShowAlert, action: kabaneri.resetAll, message: "この機種のデータを全てリセットします")
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}


// /////////////////////////////
// メモリーセーブ画面
// /////////////////////////////
struct kabaneriViewSaveMemory: View {
    @ObservedObject var kabaneri = Kabaneri()
    @ObservedObject var kabaneriMemory1 = KabaneriMemory1()
    @ObservedObject var kabaneriMemory2 = KabaneriMemory2()
    @ObservedObject var kabaneriMemory3 = KabaneriMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "甲鉄城のカバネリ",
            selectedMemory: $kabaneri.selectedMemory,
            memoMemory1: $kabaneriMemory1.memo,
            dateDoubleMemory1: $kabaneriMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $kabaneriMemory2.memo,
            dateDoubleMemory2: $kabaneriMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $kabaneriMemory3.memo,
            dateDoubleMemory3: $kabaneriMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        kabaneriMemory1.chanceWithoutFlushCount = kabaneri.chanceWithoutFlushCount
        kabaneriMemory1.chanceWithFlushCount = kabaneri.chanceWithFlushCount
        kabaneriMemory1.chanceCountSum = kabaneri.chanceCountSum
        kabaneriMemory1.bellCount = kabaneri.bellCount
        kabaneriMemory1.startGame = kabaneri.startGame
        kabaneriMemory1.currentGame = kabaneri.currentGame
        kabaneriMemory1.playGame = kabaneri.playGame
        kabaneriMemory1.gameArrayData = kabaneri.gameArrayData
        kabaneriMemory1.bonusArrayData = kabaneri.bonusArrayData
        kabaneriMemory1.triggerArrayData = kabaneri.triggerArrayData
        kabaneriMemory1.remarksArrayData = kabaneri.remarksArrayData
        kabaneriMemory1.czHitCount = kabaneri.czHitCount
        kabaneriMemory1.historyPlayGame = kabaneri.historyPlayGame
        kabaneriMemory1.bonus100LoseCount = kabaneri.bonus100LoseCount
        kabaneriMemory1.bonus100WinCount = kabaneri.bonus100WinCount
        kabaneriMemory1.bonus100CountSum = kabaneri.bonus100CountSum
        kabaneriMemory1.bonus250LoseCount = kabaneri.bonus250LoseCount
        kabaneriMemory1.bonus250WinCount = kabaneri.bonus250WinCount
        kabaneriMemory1.bonus250CountSum = kabaneri.bonus250CountSum
        kabaneriMemory1.bonus450LoseCount = kabaneri.bonus450LoseCount
        kabaneriMemory1.bonus450WinCount = kabaneri.bonus450WinCount
        kabaneriMemory1.bonus450CountSum = kabaneri.bonus450CountSum
        kabaneriMemory1.bonus650LoseCount = kabaneri.bonus650LoseCount
        kabaneriMemory1.bonus650WinCount = kabaneri.bonus650WinCount
        kabaneriMemory1.bonus650CountSum = kabaneri.bonus650CountSum
        kabaneriMemory1.mumeiNaviNoneCount = kabaneri.mumeiNaviNoneCount
        kabaneriMemory1.mumeiNaviCount = kabaneri.mumeiNaviCount
        kabaneriMemory1.mumeiNaviCountSum = kabaneri.mumeiNaviCountSum
        kabaneriMemory1.mumei3renLoseCount = kabaneri.mumei3renLoseCount
        kabaneriMemory1.mumei3renWinCount = kabaneri.mumei3renWinCount
        kabaneriMemory1.mumei3renCountSum = kabaneri.mumei3renCountSum
        kabaneriMemory1.icomaLife3DamageCount = kabaneri.icomaLife3DamageCount
        kabaneriMemory1.icomaLife3NoDamageCount = kabaneri.icomaLife3NoDamageCount
        kabaneriMemory1.icomaLife3CountSum = kabaneri.icomaLife3CountSum
        kabaneriMemory1.icomaLife2DamageCount = kabaneri.icomaLife2DamageCount
        kabaneriMemory1.icomaLife2NoDamageCount = kabaneri.icomaLife2NoDamageCount
        kabaneriMemory1.icomaLife2CountSum = kabaneri.icomaLife2CountSum
        kabaneriMemory1.icomaLife1DamageCount = kabaneri.icomaLife1DamageCount
        kabaneriMemory1.icomaLife1NoDamageCount = kabaneri.icomaLife1NoDamageCount
        kabaneriMemory1.icomaLife1CountSum = kabaneri.icomaLife1CountSum
        kabaneriMemory1.sexMaleCount = kabaneri.sexMaleCount
        kabaneriMemory1.sexFemaleCount = kabaneri.sexFemaleCount
        kabaneriMemory1.sexCountSum = kabaneri.sexCountSum
    }
    func saveMemory2() {
        kabaneriMemory2.chanceWithoutFlushCount = kabaneri.chanceWithoutFlushCount
        kabaneriMemory2.chanceWithFlushCount = kabaneri.chanceWithFlushCount
        kabaneriMemory2.chanceCountSum = kabaneri.chanceCountSum
        kabaneriMemory2.bellCount = kabaneri.bellCount
        kabaneriMemory2.startGame = kabaneri.startGame
        kabaneriMemory2.currentGame = kabaneri.currentGame
        kabaneriMemory2.playGame = kabaneri.playGame
        kabaneriMemory2.gameArrayData = kabaneri.gameArrayData
        kabaneriMemory2.bonusArrayData = kabaneri.bonusArrayData
        kabaneriMemory2.triggerArrayData = kabaneri.triggerArrayData
        kabaneriMemory2.remarksArrayData = kabaneri.remarksArrayData
        kabaneriMemory2.czHitCount = kabaneri.czHitCount
        kabaneriMemory2.historyPlayGame = kabaneri.historyPlayGame
        kabaneriMemory2.bonus100LoseCount = kabaneri.bonus100LoseCount
        kabaneriMemory2.bonus100WinCount = kabaneri.bonus100WinCount
        kabaneriMemory2.bonus100CountSum = kabaneri.bonus100CountSum
        kabaneriMemory2.bonus250LoseCount = kabaneri.bonus250LoseCount
        kabaneriMemory2.bonus250WinCount = kabaneri.bonus250WinCount
        kabaneriMemory2.bonus250CountSum = kabaneri.bonus250CountSum
        kabaneriMemory2.bonus450LoseCount = kabaneri.bonus450LoseCount
        kabaneriMemory2.bonus450WinCount = kabaneri.bonus450WinCount
        kabaneriMemory2.bonus450CountSum = kabaneri.bonus450CountSum
        kabaneriMemory2.bonus650LoseCount = kabaneri.bonus650LoseCount
        kabaneriMemory2.bonus650WinCount = kabaneri.bonus650WinCount
        kabaneriMemory2.bonus650CountSum = kabaneri.bonus650CountSum
        kabaneriMemory2.mumeiNaviNoneCount = kabaneri.mumeiNaviNoneCount
        kabaneriMemory2.mumeiNaviCount = kabaneri.mumeiNaviCount
        kabaneriMemory2.mumeiNaviCountSum = kabaneri.mumeiNaviCountSum
        kabaneriMemory2.mumei3renLoseCount = kabaneri.mumei3renLoseCount
        kabaneriMemory2.mumei3renWinCount = kabaneri.mumei3renWinCount
        kabaneriMemory2.mumei3renCountSum = kabaneri.mumei3renCountSum
        kabaneriMemory2.icomaLife3DamageCount = kabaneri.icomaLife3DamageCount
        kabaneriMemory2.icomaLife3NoDamageCount = kabaneri.icomaLife3NoDamageCount
        kabaneriMemory2.icomaLife3CountSum = kabaneri.icomaLife3CountSum
        kabaneriMemory2.icomaLife2DamageCount = kabaneri.icomaLife2DamageCount
        kabaneriMemory2.icomaLife2NoDamageCount = kabaneri.icomaLife2NoDamageCount
        kabaneriMemory2.icomaLife2CountSum = kabaneri.icomaLife2CountSum
        kabaneriMemory2.icomaLife1DamageCount = kabaneri.icomaLife1DamageCount
        kabaneriMemory2.icomaLife1NoDamageCount = kabaneri.icomaLife1NoDamageCount
        kabaneriMemory2.icomaLife1CountSum = kabaneri.icomaLife1CountSum
        kabaneriMemory2.sexMaleCount = kabaneri.sexMaleCount
        kabaneriMemory2.sexFemaleCount = kabaneri.sexFemaleCount
        kabaneriMemory2.sexCountSum = kabaneri.sexCountSum
    }
    func saveMemory3() {
        kabaneriMemory3.chanceWithoutFlushCount = kabaneri.chanceWithoutFlushCount
        kabaneriMemory3.chanceWithFlushCount = kabaneri.chanceWithFlushCount
        kabaneriMemory3.chanceCountSum = kabaneri.chanceCountSum
        kabaneriMemory3.bellCount = kabaneri.bellCount
        kabaneriMemory3.startGame = kabaneri.startGame
        kabaneriMemory3.currentGame = kabaneri.currentGame
        kabaneriMemory3.playGame = kabaneri.playGame
        kabaneriMemory3.gameArrayData = kabaneri.gameArrayData
        kabaneriMemory3.bonusArrayData = kabaneri.bonusArrayData
        kabaneriMemory3.triggerArrayData = kabaneri.triggerArrayData
        kabaneriMemory3.remarksArrayData = kabaneri.remarksArrayData
        kabaneriMemory3.czHitCount = kabaneri.czHitCount
        kabaneriMemory3.historyPlayGame = kabaneri.historyPlayGame
        kabaneriMemory3.bonus100LoseCount = kabaneri.bonus100LoseCount
        kabaneriMemory3.bonus100WinCount = kabaneri.bonus100WinCount
        kabaneriMemory3.bonus100CountSum = kabaneri.bonus100CountSum
        kabaneriMemory3.bonus250LoseCount = kabaneri.bonus250LoseCount
        kabaneriMemory3.bonus250WinCount = kabaneri.bonus250WinCount
        kabaneriMemory3.bonus250CountSum = kabaneri.bonus250CountSum
        kabaneriMemory3.bonus450LoseCount = kabaneri.bonus450LoseCount
        kabaneriMemory3.bonus450WinCount = kabaneri.bonus450WinCount
        kabaneriMemory3.bonus450CountSum = kabaneri.bonus450CountSum
        kabaneriMemory3.bonus650LoseCount = kabaneri.bonus650LoseCount
        kabaneriMemory3.bonus650WinCount = kabaneri.bonus650WinCount
        kabaneriMemory3.bonus650CountSum = kabaneri.bonus650CountSum
        kabaneriMemory3.mumeiNaviNoneCount = kabaneri.mumeiNaviNoneCount
        kabaneriMemory3.mumeiNaviCount = kabaneri.mumeiNaviCount
        kabaneriMemory3.mumeiNaviCountSum = kabaneri.mumeiNaviCountSum
        kabaneriMemory3.mumei3renLoseCount = kabaneri.mumei3renLoseCount
        kabaneriMemory3.mumei3renWinCount = kabaneri.mumei3renWinCount
        kabaneriMemory3.mumei3renCountSum = kabaneri.mumei3renCountSum
        kabaneriMemory3.icomaLife3DamageCount = kabaneri.icomaLife3DamageCount
        kabaneriMemory3.icomaLife3NoDamageCount = kabaneri.icomaLife3NoDamageCount
        kabaneriMemory3.icomaLife3CountSum = kabaneri.icomaLife3CountSum
        kabaneriMemory3.icomaLife2DamageCount = kabaneri.icomaLife2DamageCount
        kabaneriMemory3.icomaLife2NoDamageCount = kabaneri.icomaLife2NoDamageCount
        kabaneriMemory3.icomaLife2CountSum = kabaneri.icomaLife2CountSum
        kabaneriMemory3.icomaLife1DamageCount = kabaneri.icomaLife1DamageCount
        kabaneriMemory3.icomaLife1NoDamageCount = kabaneri.icomaLife1NoDamageCount
        kabaneriMemory3.icomaLife1CountSum = kabaneri.icomaLife1CountSum
        kabaneriMemory3.sexMaleCount = kabaneri.sexMaleCount
        kabaneriMemory3.sexFemaleCount = kabaneri.sexFemaleCount
        kabaneriMemory3.sexCountSum = kabaneri.sexCountSum
    }
}


// /////////////////////////////
// メモリーロード画面
// /////////////////////////////
struct kabaneriViewLoadMemory: View {
    @ObservedObject var kabaneri = Kabaneri()
    @ObservedObject var kabaneriMemory1 = KabaneriMemory1()
    @ObservedObject var kabaneriMemory2 = KabaneriMemory2()
    @ObservedObject var kabaneriMemory3 = KabaneriMemory3()
    @State var isShowLoadAlert: Bool = false
    var body: some View {
        unitViewLoadMemory(
            machineName: "甲鉄城のカバネリ",
            selectedMemory: $kabaneri.selectedMemory,
            memoMemory1: kabaneriMemory1.memo,
            dateDoubleMemory1: kabaneriMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: kabaneriMemory2.memo,
            dateDoubleMemory2: kabaneriMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: kabaneriMemory3.memo,
            dateDoubleMemory3: kabaneriMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowLoadAlert
        )
    }
    func loadMemory1() {
        kabaneri.chanceWithoutFlushCount = kabaneriMemory1.chanceWithoutFlushCount
        kabaneri.chanceWithFlushCount = kabaneriMemory1.chanceWithFlushCount
        kabaneri.chanceCountSum = kabaneriMemory1.chanceCountSum
        kabaneri.bellCount = kabaneriMemory1.bellCount
        kabaneri.startGame = kabaneriMemory1.startGame
        kabaneri.currentGame = kabaneriMemory1.currentGame
        kabaneri.playGame = kabaneriMemory1.playGame
        kabaneri.gameArrayData = kabaneriMemory1.gameArrayData
        kabaneri.bonusArrayData = kabaneriMemory1.bonusArrayData
        kabaneri.triggerArrayData = kabaneriMemory1.triggerArrayData
        kabaneri.remarksArrayData = kabaneriMemory1.remarksArrayData
        kabaneri.czHitCount = kabaneriMemory1.czHitCount
        kabaneri.historyPlayGame = kabaneriMemory1.historyPlayGame
        kabaneri.bonus100LoseCount = kabaneriMemory1.bonus100LoseCount
        kabaneri.bonus100WinCount = kabaneriMemory1.bonus100WinCount
        kabaneri.bonus100CountSum = kabaneriMemory1.bonus100CountSum
        kabaneri.bonus250LoseCount = kabaneriMemory1.bonus250LoseCount
        kabaneri.bonus250WinCount = kabaneriMemory1.bonus250WinCount
        kabaneri.bonus250CountSum = kabaneriMemory1.bonus250CountSum
        kabaneri.bonus450LoseCount = kabaneriMemory1.bonus450LoseCount
        kabaneri.bonus450WinCount = kabaneriMemory1.bonus450WinCount
        kabaneri.bonus450CountSum = kabaneriMemory1.bonus450CountSum
        kabaneri.bonus650LoseCount = kabaneriMemory1.bonus650LoseCount
        kabaneri.bonus650WinCount = kabaneriMemory1.bonus650WinCount
        kabaneri.bonus650CountSum = kabaneriMemory1.bonus650CountSum
        kabaneri.mumeiNaviNoneCount = kabaneriMemory1.mumeiNaviNoneCount
        kabaneri.mumeiNaviCount = kabaneriMemory1.mumeiNaviCount
        kabaneri.mumeiNaviCountSum = kabaneriMemory1.mumeiNaviCountSum
        kabaneri.mumei3renLoseCount = kabaneriMemory1.mumei3renLoseCount
        kabaneri.mumei3renWinCount = kabaneriMemory1.mumei3renWinCount
        kabaneri.mumei3renCountSum = kabaneriMemory1.mumei3renCountSum
        kabaneri.icomaLife3DamageCount = kabaneriMemory1.icomaLife3DamageCount
        kabaneri.icomaLife3NoDamageCount = kabaneriMemory1.icomaLife3NoDamageCount
        kabaneri.icomaLife3CountSum = kabaneriMemory1.icomaLife3CountSum
        kabaneri.icomaLife2DamageCount = kabaneriMemory1.icomaLife2DamageCount
        kabaneri.icomaLife2NoDamageCount = kabaneriMemory1.icomaLife2NoDamageCount
        kabaneri.icomaLife2CountSum = kabaneriMemory1.icomaLife2CountSum
        kabaneri.icomaLife1DamageCount = kabaneriMemory1.icomaLife1DamageCount
        kabaneri.icomaLife1NoDamageCount = kabaneriMemory1.icomaLife1NoDamageCount
        kabaneri.icomaLife1CountSum = kabaneriMemory1.icomaLife1CountSum
        kabaneri.sexMaleCount = kabaneriMemory1.sexMaleCount
        kabaneri.sexFemaleCount = kabaneriMemory1.sexFemaleCount
        kabaneri.sexCountSum = kabaneriMemory1.sexCountSum
    }
    func loadMemory2() {
        kabaneri.chanceWithoutFlushCount = kabaneriMemory2.chanceWithoutFlushCount
        kabaneri.chanceWithFlushCount = kabaneriMemory2.chanceWithFlushCount
        kabaneri.chanceCountSum = kabaneriMemory2.chanceCountSum
        kabaneri.bellCount = kabaneriMemory2.bellCount
        kabaneri.startGame = kabaneriMemory2.startGame
        kabaneri.currentGame = kabaneriMemory2.currentGame
        kabaneri.playGame = kabaneriMemory2.playGame
        kabaneri.gameArrayData = kabaneriMemory2.gameArrayData
        kabaneri.bonusArrayData = kabaneriMemory2.bonusArrayData
        kabaneri.triggerArrayData = kabaneriMemory2.triggerArrayData
        kabaneri.remarksArrayData = kabaneriMemory2.remarksArrayData
        kabaneri.czHitCount = kabaneriMemory2.czHitCount
        kabaneri.historyPlayGame = kabaneriMemory2.historyPlayGame
        kabaneri.bonus100LoseCount = kabaneriMemory2.bonus100LoseCount
        kabaneri.bonus100WinCount = kabaneriMemory2.bonus100WinCount
        kabaneri.bonus100CountSum = kabaneriMemory2.bonus100CountSum
        kabaneri.bonus250LoseCount = kabaneriMemory2.bonus250LoseCount
        kabaneri.bonus250WinCount = kabaneriMemory2.bonus250WinCount
        kabaneri.bonus250CountSum = kabaneriMemory2.bonus250CountSum
        kabaneri.bonus450LoseCount = kabaneriMemory2.bonus450LoseCount
        kabaneri.bonus450WinCount = kabaneriMemory2.bonus450WinCount
        kabaneri.bonus450CountSum = kabaneriMemory2.bonus450CountSum
        kabaneri.bonus650LoseCount = kabaneriMemory2.bonus650LoseCount
        kabaneri.bonus650WinCount = kabaneriMemory2.bonus650WinCount
        kabaneri.bonus650CountSum = kabaneriMemory2.bonus650CountSum
        kabaneri.mumeiNaviNoneCount = kabaneriMemory2.mumeiNaviNoneCount
        kabaneri.mumeiNaviCount = kabaneriMemory2.mumeiNaviCount
        kabaneri.mumeiNaviCountSum = kabaneriMemory2.mumeiNaviCountSum
        kabaneri.mumei3renLoseCount = kabaneriMemory2.mumei3renLoseCount
        kabaneri.mumei3renWinCount = kabaneriMemory2.mumei3renWinCount
        kabaneri.mumei3renCountSum = kabaneriMemory2.mumei3renCountSum
        kabaneri.icomaLife3DamageCount = kabaneriMemory2.icomaLife3DamageCount
        kabaneri.icomaLife3NoDamageCount = kabaneriMemory2.icomaLife3NoDamageCount
        kabaneri.icomaLife3CountSum = kabaneriMemory2.icomaLife3CountSum
        kabaneri.icomaLife2DamageCount = kabaneriMemory2.icomaLife2DamageCount
        kabaneri.icomaLife2NoDamageCount = kabaneriMemory2.icomaLife2NoDamageCount
        kabaneri.icomaLife2CountSum = kabaneriMemory2.icomaLife2CountSum
        kabaneri.icomaLife1DamageCount = kabaneriMemory2.icomaLife1DamageCount
        kabaneri.icomaLife1NoDamageCount = kabaneriMemory2.icomaLife1NoDamageCount
        kabaneri.icomaLife1CountSum = kabaneriMemory2.icomaLife1CountSum
        kabaneri.sexMaleCount = kabaneriMemory2.sexMaleCount
        kabaneri.sexFemaleCount = kabaneriMemory2.sexFemaleCount
        kabaneri.sexCountSum = kabaneriMemory2.sexCountSum
    }
    func loadMemory3() {
        kabaneri.chanceWithoutFlushCount = kabaneriMemory3.chanceWithoutFlushCount
        kabaneri.chanceWithFlushCount = kabaneriMemory3.chanceWithFlushCount
        kabaneri.chanceCountSum = kabaneriMemory3.chanceCountSum
        kabaneri.bellCount = kabaneriMemory3.bellCount
        kabaneri.startGame = kabaneriMemory3.startGame
        kabaneri.currentGame = kabaneriMemory3.currentGame
        kabaneri.playGame = kabaneriMemory3.playGame
        kabaneri.gameArrayData = kabaneriMemory3.gameArrayData
        kabaneri.bonusArrayData = kabaneriMemory3.bonusArrayData
        kabaneri.triggerArrayData = kabaneriMemory3.triggerArrayData
        kabaneri.remarksArrayData = kabaneriMemory3.remarksArrayData
        kabaneri.czHitCount = kabaneriMemory3.czHitCount
        kabaneri.historyPlayGame = kabaneriMemory3.historyPlayGame
        kabaneri.bonus100LoseCount = kabaneriMemory3.bonus100LoseCount
        kabaneri.bonus100WinCount = kabaneriMemory3.bonus100WinCount
        kabaneri.bonus100CountSum = kabaneriMemory3.bonus100CountSum
        kabaneri.bonus250LoseCount = kabaneriMemory3.bonus250LoseCount
        kabaneri.bonus250WinCount = kabaneriMemory3.bonus250WinCount
        kabaneri.bonus250CountSum = kabaneriMemory3.bonus250CountSum
        kabaneri.bonus450LoseCount = kabaneriMemory3.bonus450LoseCount
        kabaneri.bonus450WinCount = kabaneriMemory3.bonus450WinCount
        kabaneri.bonus450CountSum = kabaneriMemory3.bonus450CountSum
        kabaneri.bonus650LoseCount = kabaneriMemory3.bonus650LoseCount
        kabaneri.bonus650WinCount = kabaneriMemory3.bonus650WinCount
        kabaneri.bonus650CountSum = kabaneriMemory3.bonus650CountSum
        kabaneri.mumeiNaviNoneCount = kabaneriMemory3.mumeiNaviNoneCount
        kabaneri.mumeiNaviCount = kabaneriMemory3.mumeiNaviCount
        kabaneri.mumeiNaviCountSum = kabaneriMemory3.mumeiNaviCountSum
        kabaneri.mumei3renLoseCount = kabaneriMemory3.mumei3renLoseCount
        kabaneri.mumei3renWinCount = kabaneriMemory3.mumei3renWinCount
        kabaneri.mumei3renCountSum = kabaneriMemory3.mumei3renCountSum
        kabaneri.icomaLife3DamageCount = kabaneriMemory3.icomaLife3DamageCount
        kabaneri.icomaLife3NoDamageCount = kabaneriMemory3.icomaLife3NoDamageCount
        kabaneri.icomaLife3CountSum = kabaneriMemory3.icomaLife3CountSum
        kabaneri.icomaLife2DamageCount = kabaneriMemory3.icomaLife2DamageCount
        kabaneri.icomaLife2NoDamageCount = kabaneriMemory3.icomaLife2NoDamageCount
        kabaneri.icomaLife2CountSum = kabaneriMemory3.icomaLife2CountSum
        kabaneri.icomaLife1DamageCount = kabaneriMemory3.icomaLife1DamageCount
        kabaneri.icomaLife1NoDamageCount = kabaneriMemory3.icomaLife1NoDamageCount
        kabaneri.icomaLife1CountSum = kabaneriMemory3.icomaLife1CountSum
        kabaneri.sexMaleCount = kabaneriMemory3.sexMaleCount
        kabaneri.sexFemaleCount = kabaneriMemory3.sexFemaleCount
        kabaneri.sexCountSum = kabaneriMemory3.sexCountSum
    }
}


#Preview {
    kabaneriViewTop()
}
