//
//  seiyaClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Seiya: ObservableObject {
    // -------
    // 通常時
    // -------

    func resetNormal() {
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitCz: [Double] = [214.4,214.1,211.7,202.5,197.2,200.3]
    let ratioFirstHitAt: [Double] = [364.2,356.1,345.6,322.3,313.7,310.5]
    // 選択肢
    let czKindList: [String] = ["WHO ARE YOU ?", "影ノ襲来", "AT直撃"]
    let czKindShortList: [String] = ["WHO", "影ノ襲来", "AT直撃"]   // 履歴表示用
    let atResultList: [String] = ["ハズレ", "当選"]
    // 選択結果
    @AppStorage("seiyaInputGame") var inputGame: Int = 0
    @AppStorage("seiyaSelectedCzKind") var selectedCzKind: String = "WHO ARE YOU ?"
    @AppStorage("seiyaSelectedAtResult") var selectedAtResult: String = "ハズレ"

    // ゲーム数配列
    let gameArrayKey: String = "seiyaGameArrayKey"
    @AppStorage("seiyaGameArrayKey") var gameArrayData: Data?
    // CZ種類配列
    let czKindArrayKey: String = "seiyaCzKindArrayKey"
    @AppStorage("seiyaCzKindArrayKey") var czKindArrayData: Data?
    // AT当否配列
    let atResultArrayKey: String = "seiyaAtResultArrayKey"
    @AppStorage("seiyaAtResultArrayKey") var atResultArrayData: Data?

    // 履歴からの自動算出結果
    @AppStorage("seiyaPlayGameSum") var playGameSum: Int = 0
    @AppStorage("seiyaFirstHitCountCz") var firstHitCountCz: Int = 0
    @AppStorage("seiyaFirstHitCountAt") var firstHitCountAt: Int = 0

    // データ登録
    func addHistory() {
        // AT直撃は当選1択なのでピッカーの選択状態によらず当選で登録
        let atResult = selectedCzKind == czKindList[2] ? atResultList[1] : selectedAtResult
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: czKindArrayData, addData: selectedCzKind, key: czKindArrayKey)
        arrayStringAddData(arrayData: atResultArrayData, addData: atResult, key: atResultArrayKey)
        addRemoveCommon()
    }
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: czKindArrayData, key: czKindArrayKey)
        arrayStringRemoveLast(arrayData: atResultArrayData, key: atResultArrayKey)
        addRemoveCommon()
    }
    func resetFirstHit() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: czKindArrayData, key: czKindArrayKey)
        arrayStringRemoveAll(arrayData: atResultArrayData, key: atResultArrayKey)
        addRemoveCommon()
        inputGame = 0
        minusCheck = false
    }
    func addRemoveCommon() {
        // ゲーム数はAT当選まで累積
        playGameSum = arraySumPlayGameResetWordOne(
            gameArrayData: gameArrayData,
            bonusArrayData: atResultArrayData,
            resetWord: atResultList[1]
        )
        // CZはWHO ARE YOU ?と影ノ襲来の合算
        firstHitCountCz = countSum(
            arrayStringDataCount(arrayData: czKindArrayData, countString: czKindList[0]),
            arrayStringDataCount(arrayData: czKindArrayData, countString: czKindList[1]),
        )
        firstHitCountAt = arrayStringDataCount(arrayData: atResultArrayData, countString: atResultList[1])
    }

    // 履歴表示用のCZ種類名
    func czKindShortName(_ kind: String) -> String {
        guard let index = czKindList.firstIndex(of: kind) else { return kind }
        return czKindShortList[index]
    }

    // AT区間の先頭行かどうか（先頭行、または1つ前がAT当選）
    var atIntervalStartFlagList: [Bool] {
        let atArray = decodeStringArray(from: atResultArrayData)
        return atArray.indices.map { index in
            if index == 0 { return true }
            return atArray[index - 1] == atResultList[1]
        }
    }

    // --------
    // AT中
    // --------
    // エクストララウンド 対戦相手（1:シャカ、2:ジェミニ、3:その他）
    @AppStorage("seiyaOpponentCount1") var opponentCount1: Int = 0
    @AppStorage("seiyaOpponentCount2") var opponentCount2: Int = 0
    @AppStorage("seiyaOpponentCount3") var opponentCount3: Int = 0
    @AppStorage("seiyaOpponentCountSum") var opponentCountSum: Int = 0
    // エクストララウンド キャラ紹介（1:ムウ、2:アイオロス、3:その他）
    @AppStorage("seiyaCharaCount1") var charaCount1: Int = 0
    @AppStorage("seiyaCharaCount2") var charaCount2: Int = 0
    @AppStorage("seiyaCharaCount3") var charaCount3: Int = 0
    @AppStorage("seiyaCharaCountSum") var charaCountSum: Int = 0

    func opponentSumFunc() {
        opponentCountSum = countSum(
            opponentCount1,
            opponentCount2,
            opponentCount3,
        )
    }

    func charaSumFunc() {
        charaCountSum = countSum(
            charaCount1,
            charaCount2,
            charaCount3,
        )
    }

    func resetDuringAt() {
        opponentCount1 = 0
        opponentCount2 = 0
        opponentCount3 = 0
        opponentCountSum = 0
        charaCount1 = 0
        charaCount2 = 0
        charaCount3 = 0
        charaCountSum = 0
        minusCheck = false
    }

    // --------
    // AT終了画面
    // --------
    let ratioScreenOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioScreenOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("seiyaScreenCount1") var screenCount1: Int = 0
    @AppStorage("seiyaScreenCount2") var screenCount2: Int = 0
    @AppStorage("seiyaScreenCount3") var screenCount3: Int = 0
    @AppStorage("seiyaScreenCount4") var screenCount4: Int = 0
    @AppStorage("seiyaScreenCount5") var screenCount5: Int = 0
    @AppStorage("seiyaScreenCount6") var screenCount6: Int = 0
    @AppStorage("seiyaScreenCount7") var screenCount7: Int = 0
    @AppStorage("seiyaScreenCount8") var screenCount8: Int = 0
    @AppStorage("seiyaScreenCountSum") var screenCountSum: Int = 0

    func screenSumFunc() {
        screenCountSum = countSum(
            screenCount1,
            screenCount2,
            screenCount3,
            screenCount4,
            screenCount5,
            screenCount6,
            screenCount7,
            screenCount8,
        )
    }

    func resetScreen() {
        screenCount1 = 0
        screenCount2 = 0
        screenCount3 = 0
        screenCount4 = 0
        screenCount5 = 0
        screenCount6 = 0
        screenCount7 = 0
        screenCount8 = 0
        screenCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "聖闘士星矢 黄金十二宮"
    @AppStorage("seiyaMinusCheck") var minusCheck: Bool = false
    @AppStorage("seiyaSelectedMemory") var selectedMemory = "メモリー1"

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetDuringAt()
        resetScreen()
    }
}


class SeiyaMemory1: ObservableObject {
    @AppStorage("seiyaMemoMemory1") var memo = ""
    @AppStorage("seiyaDateMemory1") var dateDouble = 0.0
}


class SeiyaMemory2: ObservableObject {
    @AppStorage("seiyaMemoMemory2") var memo = ""
    @AppStorage("seiyaDateMemory2") var dateDouble = 0.0
}


class SeiyaMemory3: ObservableObject {
    @AppStorage("seiyaMemoMemory3") var memo = ""
    @AppStorage("seiyaDateMemory3") var dateDouble = 0.0
}
