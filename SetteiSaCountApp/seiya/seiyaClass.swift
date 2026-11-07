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
    let czKindList: [String] = ["WHO ARE YOU ?", "影ノ襲来", "AT直撃", "その他"]
    let czKindShortList: [String] = ["WHO", "影ノ襲来", "AT直撃", "その他"]   // 履歴表示用
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

    // 入力方式（履歴入力／カウント入力）
    let firstHitInputModeList: [String] = ["履歴入力", "カウント入力"]
    @AppStorage("seiyaFirstHitInputMode") var firstHitInputMode: String = "履歴入力"
    // カウント入力用
    @AppStorage("seiyaManualNormalGame") var manualNormalGame: Int = 0
    @AppStorage("seiyaManualFirstHitCountCz") var manualFirstHitCountCz: Int = 0
    @AppStorage("seiyaManualFirstHitCountAt") var manualFirstHitCountAt: Int = 0
    // 確率算出・95Ci・設定期待値に使う値（選択中の入力方式の値を返す）
    var isHistoryInputMode: Bool {
        firstHitInputMode == firstHitInputModeList[0]
    }
    var activeNormalGame: Int {
        get { isHistoryInputMode ? playGameSum : manualNormalGame }
        set { }
    }
    var activeFirstHitCountCz: Int {
        get { isHistoryInputMode ? firstHitCountCz : manualFirstHitCountCz }
        set { }
    }
    var activeFirstHitCountAt: Int {
        get { isHistoryInputMode ? firstHitCountAt : manualFirstHitCountAt }
        set { }
    }

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
        manualNormalGame = 0
        manualFirstHitCountCz = 0
        manualFirstHitCountAt = 0
        minusCheck = false
    }
    func addRemoveCommon() {
        // ゲーム数は初当りごとにリセットされるので単純合計
        playGameSum = arrayIntAllDataSum(arrayData: gameArrayData)
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

    // -------
    // レア役時のPUSHランプ
    // -------
    let ratioLampOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioLampOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioLampOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("seiyaLampCount1") var lampCount1: Int = 0
    @AppStorage("seiyaLampCount2") var lampCount2: Int = 0
    @AppStorage("seiyaLampCount3") var lampCount3: Int = 0
    @AppStorage("seiyaLampCount4") var lampCount4: Int = 0
    @AppStorage("seiyaLampCount5") var lampCount5: Int = 0
    @AppStorage("seiyaLampCount6") var lampCount6: Int = 0
    @AppStorage("seiyaLampCountSum") var lampCountSum: Int = 0

    func lampSumFunc() {
        lampCountSum = countSum(
            lampCount1,
            lampCount2,
            lampCount3,
            lampCount4,
            lampCount5,
            lampCount6,
        )
    }

    func resetLamp() {
        lampCount1 = 0
        lampCount2 = 0
        lampCount3 = 0
        lampCount4 = 0
        lampCount5 = 0
        lampCount6 = 0
        lampCountSum = 0
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
        resetLamp()
    }
}


class SeiyaMemory1: ObservableObject {
    @AppStorage("seiyaGameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("seiyaCzKindArrayKeyMemory1") var czKindArrayData: Data?
    @AppStorage("seiyaAtResultArrayKeyMemory1") var atResultArrayData: Data?
    @AppStorage("seiyaPlayGameSumMemory1") var playGameSum: Int = 0
    @AppStorage("seiyaFirstHitCountCzMemory1") var firstHitCountCz: Int = 0
    @AppStorage("seiyaFirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("seiyaFirstHitInputModeMemory1") var firstHitInputMode: String = "履歴入力"
    @AppStorage("seiyaManualNormalGameMemory1") var manualNormalGame: Int = 0
    @AppStorage("seiyaManualFirstHitCountCzMemory1") var manualFirstHitCountCz: Int = 0
    @AppStorage("seiyaManualFirstHitCountAtMemory1") var manualFirstHitCountAt: Int = 0
    @AppStorage("seiyaOpponentCount1Memory1") var opponentCount1: Int = 0
    @AppStorage("seiyaOpponentCount2Memory1") var opponentCount2: Int = 0
    @AppStorage("seiyaOpponentCount3Memory1") var opponentCount3: Int = 0
    @AppStorage("seiyaOpponentCountSumMemory1") var opponentCountSum: Int = 0
    @AppStorage("seiyaCharaCount1Memory1") var charaCount1: Int = 0
    @AppStorage("seiyaCharaCount2Memory1") var charaCount2: Int = 0
    @AppStorage("seiyaCharaCount3Memory1") var charaCount3: Int = 0
    @AppStorage("seiyaCharaCountSumMemory1") var charaCountSum: Int = 0
    @AppStorage("seiyaScreenCount1Memory1") var screenCount1: Int = 0
    @AppStorage("seiyaScreenCount2Memory1") var screenCount2: Int = 0
    @AppStorage("seiyaScreenCount3Memory1") var screenCount3: Int = 0
    @AppStorage("seiyaScreenCount4Memory1") var screenCount4: Int = 0
    @AppStorage("seiyaScreenCount5Memory1") var screenCount5: Int = 0
    @AppStorage("seiyaScreenCount6Memory1") var screenCount6: Int = 0
    @AppStorage("seiyaScreenCount7Memory1") var screenCount7: Int = 0
    @AppStorage("seiyaScreenCount8Memory1") var screenCount8: Int = 0
    @AppStorage("seiyaScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("seiyaLampCount1Memory1") var lampCount1: Int = 0
    @AppStorage("seiyaLampCount2Memory1") var lampCount2: Int = 0
    @AppStorage("seiyaLampCount3Memory1") var lampCount3: Int = 0
    @AppStorage("seiyaLampCount4Memory1") var lampCount4: Int = 0
    @AppStorage("seiyaLampCount5Memory1") var lampCount5: Int = 0
    @AppStorage("seiyaLampCount6Memory1") var lampCount6: Int = 0
    @AppStorage("seiyaLampCountSumMemory1") var lampCountSum: Int = 0
    @AppStorage("seiyaMemoMemory1") var memo = ""
    @AppStorage("seiyaDateMemory1") var dateDouble = 0.0
}


class SeiyaMemory2: ObservableObject {
    @AppStorage("seiyaGameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("seiyaCzKindArrayKeyMemory2") var czKindArrayData: Data?
    @AppStorage("seiyaAtResultArrayKeyMemory2") var atResultArrayData: Data?
    @AppStorage("seiyaPlayGameSumMemory2") var playGameSum: Int = 0
    @AppStorage("seiyaFirstHitCountCzMemory2") var firstHitCountCz: Int = 0
    @AppStorage("seiyaFirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("seiyaFirstHitInputModeMemory2") var firstHitInputMode: String = "履歴入力"
    @AppStorage("seiyaManualNormalGameMemory2") var manualNormalGame: Int = 0
    @AppStorage("seiyaManualFirstHitCountCzMemory2") var manualFirstHitCountCz: Int = 0
    @AppStorage("seiyaManualFirstHitCountAtMemory2") var manualFirstHitCountAt: Int = 0
    @AppStorage("seiyaOpponentCount1Memory2") var opponentCount1: Int = 0
    @AppStorage("seiyaOpponentCount2Memory2") var opponentCount2: Int = 0
    @AppStorage("seiyaOpponentCount3Memory2") var opponentCount3: Int = 0
    @AppStorage("seiyaOpponentCountSumMemory2") var opponentCountSum: Int = 0
    @AppStorage("seiyaCharaCount1Memory2") var charaCount1: Int = 0
    @AppStorage("seiyaCharaCount2Memory2") var charaCount2: Int = 0
    @AppStorage("seiyaCharaCount3Memory2") var charaCount3: Int = 0
    @AppStorage("seiyaCharaCountSumMemory2") var charaCountSum: Int = 0
    @AppStorage("seiyaScreenCount1Memory2") var screenCount1: Int = 0
    @AppStorage("seiyaScreenCount2Memory2") var screenCount2: Int = 0
    @AppStorage("seiyaScreenCount3Memory2") var screenCount3: Int = 0
    @AppStorage("seiyaScreenCount4Memory2") var screenCount4: Int = 0
    @AppStorage("seiyaScreenCount5Memory2") var screenCount5: Int = 0
    @AppStorage("seiyaScreenCount6Memory2") var screenCount6: Int = 0
    @AppStorage("seiyaScreenCount7Memory2") var screenCount7: Int = 0
    @AppStorage("seiyaScreenCount8Memory2") var screenCount8: Int = 0
    @AppStorage("seiyaScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("seiyaLampCount1Memory2") var lampCount1: Int = 0
    @AppStorage("seiyaLampCount2Memory2") var lampCount2: Int = 0
    @AppStorage("seiyaLampCount3Memory2") var lampCount3: Int = 0
    @AppStorage("seiyaLampCount4Memory2") var lampCount4: Int = 0
    @AppStorage("seiyaLampCount5Memory2") var lampCount5: Int = 0
    @AppStorage("seiyaLampCount6Memory2") var lampCount6: Int = 0
    @AppStorage("seiyaLampCountSumMemory2") var lampCountSum: Int = 0
    @AppStorage("seiyaMemoMemory2") var memo = ""
    @AppStorage("seiyaDateMemory2") var dateDouble = 0.0
}


class SeiyaMemory3: ObservableObject {
    @AppStorage("seiyaGameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("seiyaCzKindArrayKeyMemory3") var czKindArrayData: Data?
    @AppStorage("seiyaAtResultArrayKeyMemory3") var atResultArrayData: Data?
    @AppStorage("seiyaPlayGameSumMemory3") var playGameSum: Int = 0
    @AppStorage("seiyaFirstHitCountCzMemory3") var firstHitCountCz: Int = 0
    @AppStorage("seiyaFirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("seiyaFirstHitInputModeMemory3") var firstHitInputMode: String = "履歴入力"
    @AppStorage("seiyaManualNormalGameMemory3") var manualNormalGame: Int = 0
    @AppStorage("seiyaManualFirstHitCountCzMemory3") var manualFirstHitCountCz: Int = 0
    @AppStorage("seiyaManualFirstHitCountAtMemory3") var manualFirstHitCountAt: Int = 0
    @AppStorage("seiyaOpponentCount1Memory3") var opponentCount1: Int = 0
    @AppStorage("seiyaOpponentCount2Memory3") var opponentCount2: Int = 0
    @AppStorage("seiyaOpponentCount3Memory3") var opponentCount3: Int = 0
    @AppStorage("seiyaOpponentCountSumMemory3") var opponentCountSum: Int = 0
    @AppStorage("seiyaCharaCount1Memory3") var charaCount1: Int = 0
    @AppStorage("seiyaCharaCount2Memory3") var charaCount2: Int = 0
    @AppStorage("seiyaCharaCount3Memory3") var charaCount3: Int = 0
    @AppStorage("seiyaCharaCountSumMemory3") var charaCountSum: Int = 0
    @AppStorage("seiyaScreenCount1Memory3") var screenCount1: Int = 0
    @AppStorage("seiyaScreenCount2Memory3") var screenCount2: Int = 0
    @AppStorage("seiyaScreenCount3Memory3") var screenCount3: Int = 0
    @AppStorage("seiyaScreenCount4Memory3") var screenCount4: Int = 0
    @AppStorage("seiyaScreenCount5Memory3") var screenCount5: Int = 0
    @AppStorage("seiyaScreenCount6Memory3") var screenCount6: Int = 0
    @AppStorage("seiyaScreenCount7Memory3") var screenCount7: Int = 0
    @AppStorage("seiyaScreenCount8Memory3") var screenCount8: Int = 0
    @AppStorage("seiyaScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("seiyaLampCount1Memory3") var lampCount1: Int = 0
    @AppStorage("seiyaLampCount2Memory3") var lampCount2: Int = 0
    @AppStorage("seiyaLampCount3Memory3") var lampCount3: Int = 0
    @AppStorage("seiyaLampCount4Memory3") var lampCount4: Int = 0
    @AppStorage("seiyaLampCount5Memory3") var lampCount5: Int = 0
    @AppStorage("seiyaLampCount6Memory3") var lampCount6: Int = 0
    @AppStorage("seiyaLampCountSumMemory3") var lampCountSum: Int = 0
    @AppStorage("seiyaMemoMemory3") var memo = ""
    @AppStorage("seiyaDateMemory3") var dateDouble = 0.0
}
