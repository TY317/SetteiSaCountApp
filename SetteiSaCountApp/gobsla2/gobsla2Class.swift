//
//  gobsla2Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/02/23.
//

import Foundation
import SwiftUI
import Combine

class Gobsla2: ObservableObject {
    // --------
    // 通常時
    // --------
    // 弱レア役からのCZ
    let ratioJakuRareCZ: [Double] = [0.4,0.8,1.2,1.6,2.0,2.3]
    @AppStorage("gobsla2JakuRareCountJakuCherry") var jakuRareCountJakuCherry: Int = 0
    @AppStorage("gobsla2JakuRareCountSuika") var jakuRareCountSuika: Int = 0
    @AppStorage("gobsla2JakuRareCountSum") var jakuRareCountSum: Int = 0
    @AppStorage("gobsla2JakuRareCountHit") var jakuRareCountHit: Int = 0
    
    func normalSumFunc() {
        jakuRareCountSum = jakuRareCountJakuCherry + jakuRareCountSuika
    }
    
    // 300or500での当選
    let ratio35Hit: [Double] = [5.1,5.9,7,8.6,9.4,10.2]
    @AppStorage("gobsla2game35CountMiss") var game35HitCountMiss: Int = 0
    @AppStorage("gobsla2game35CountHit") var game35HitCountHit: Int = 0
    @AppStorage("gobsla2game35CountSum") var game35HitCountSum: Int = 0
    
    func game35SumFunc() {
        game35HitCountSum = game35HitCountMiss + game35HitCountHit
    }
    
    func resetNormal() {
        jakuRareCountJakuCherry = 0
        jakuRareCountSuika = 0
        jakuRareCountSum = 0
        jakuRareCountHit = 0
        game35HitCountMiss = 0
        game35HitCountHit = 0
        game35HitCountSum = 0
        minusCheck = false
    }
    
    // --------
    // 兜pt
    // --------
    let ratioPt10: [Double] = [18,18.4,19.6,22.9,23.7,23.9]
    let ratioPt20: [Double] = [8.8,9.1,10.1,12.7,13.3,13.4]
    let ratioPt30: [Double] = [18.5,18.6,18.9,19.6,19.7,19.8]
    let ratioPt40: [Double] = [8.7,8.6,8.2,7.1,6.9,6.8]
    let ratioPt50: [Double] = [6.8,6.7,6.4,5.6,5.4,5.3]
    let ratioPt60: [Double] = [15,14.8,14.1,12.3,11.9,11.8]
    let ratioPt70: [Double] = [4.8,4.8,4.6,4.0,3.8,3.8]
    let ratioPt80: [Double] = [4,3.9,3.7,3.2,3.1,3.1]
    let ratioPt90: [Double] = [11.3,11.1,10.6,9.3,9.0,8.9]
    let ratioPt100: [Double] = [4.1,4,3.9,3.4,3.3,3.2]
    let ratioPtU20: [Double] = [26.8,27.5,29.7,35.6,37,38.3]
    let ratioPtO40: [Double] = [54.7,53.9,51.4,44.8,43.3,42.9]
    @AppStorage("gobsla2PtCount10") var ptCount10: Int = 0
    @AppStorage("gobsla2PtCount20") var ptCount20: Int = 0
    @AppStorage("gobsla2PtCount30") var ptCount30: Int = 0
    @AppStorage("gobsla2PtCount40") var ptCount40: Int = 0
    @AppStorage("gobsla2PtCount50") var ptCount50: Int = 0
    @AppStorage("gobsla2PtCount60") var ptCount60: Int = 0
    @AppStorage("gobsla2PtCount70") var ptCount70: Int = 0
    @AppStorage("gobsla2PtCount80") var ptCount80: Int = 0
    @AppStorage("gobsla2PtCount90") var ptCount90: Int = 0
    @AppStorage("gobsla2PtCount100") var ptCount100: Int = 0
    @AppStorage("gobsla2PtCountSum") var ptCountSum: Int = 0
    @AppStorage("gobsla2PtCountU20") var ptCountU20: Int = 0
    @AppStorage("gobsla2PtCountO40") var ptCountO40: Int = 0
    
    func ptSumFunc() {
        ptCountSum = countSum(
            ptCount10,
            ptCount20,
            ptCount30,
            ptCount40,
            ptCount50,
            ptCount60,
            ptCount70,
            ptCount80,
            ptCount90,
            ptCount100,
        )
        ptCountU20 = countSum(
            ptCount10,
            ptCount20,
        )
        ptCountO40 = countSum(
            ptCount40,
            ptCount50,
            ptCount60,
            ptCount70,
            ptCount80,
            ptCount90,
            ptCount100,
        )
    }
    
    func resetKabuto() {
        ptCount10 = 0
        ptCount20 = 0
        ptCount30 = 0
        ptCount40 = 0
        ptCount50 = 0
        ptCount60 = 0
        ptCount70 = 0
        ptCount80 = 0
        ptCount90 = 0
        ptCount100 = 0
        ptCountSum = 0
        ptCountU20 = 0
        ptCountO40 = 0
        minusCheck = false
    }
    
    // ---------
    // 初あたり
    // ---------
    let ratioFirstHitCz: [Double] = [239.3,232.3,222.9,200.4,187.3,181.9]
    let ratioFirstHitAt: [Double] = [541.6,526.4,506.4,453.2,417.8,402.4]
    // 選択肢の設定
    let selectListKind: [String] = ["CZ", "AT直撃"]
    let selectListAtHit: [String] = ["ハズレ", "当選"]
    // 選択結果
    @AppStorage("gobsla2InputGame") var inputGame: Int = 0
    @AppStorage("gobsla2SelectedKind") var selectedKind: String = "CZ"
    @AppStorage("gobsla2SelectedAtHit") var selectedAtHit: String = "ハズレ"
    // ゲーム数配列
    let gameArrayKey: String = "gobsla2GameArrayKey"
    @AppStorage("gobsla2GameArrayKey") var gameArrayData: Data?
    // 種類配列
    let kindArrayKey: String = "gobsla2KindArrayKey"
    @AppStorage("gobsla2KindArrayKey") var kindArrayData: Data?
    // AT当否契機配列
    let atHitArrayKey: String = "gobsla2AtHitArrayKey"
    @AppStorage("gobsla2AtHitArrayKey") var atHitArrayData: Data?
    
    // 算出結果
    @AppStorage("gobsla2NormalGame") var normalGame: Int = 0
    @AppStorage("gobsla2CzCount") var czCount: Int = 0
    @AppStorage("gobsla2AtCount") var atCount: Int = 0
    
    // データ登録
    func addHistory() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayStringAddData(arrayData: kindArrayData, addData: selectedKind, key: kindArrayKey)
        arrayStringAddData(arrayData: atHitArrayData, addData: selectedAtHit, key: atHitArrayKey)
        addRemoveCommon()
    }
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveLast(arrayData: kindArrayData, key: kindArrayKey)
        arrayStringRemoveLast(arrayData: atHitArrayData, key: atHitArrayKey)
        addRemoveCommon()
    }
    
    func addRemoveCommon() {
        // 通常ゲーム数の算出
        normalGame = arraySumGameNotResetWordOne(
            gameArrayData: gameArrayData,
            bonusArrayData: atHitArrayData,
            notResetWord: selectListAtHit[0]
        )
        // CZ回数算出
        czCount = arrayStringDataCount(arrayData: kindArrayData, countString: selectListKind[0])
        
        // AT回数算出
        atCount = arrayStringDataCount(arrayData: atHitArrayData, countString: selectListAtHit[1])
    }
    
    func resetFirstHit() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayStringRemoveAll(arrayData: kindArrayData, key: kindArrayKey)
        arrayStringRemoveAll(arrayData: atHitArrayData, key: atHitArrayKey)
        addRemoveCommon()
        inputGame = 0
        minusCheck = false
    }
    
    // ----------
    // 終了画面
    // ----------
    @AppStorage("gobsla2ScreenCountDefault") var screenCountDefault: Int = 0
    @AppStorage("gobsla2ScreenCountPtSisa1") var screenCountPtSisa1: Int = 0
    @AppStorage("gobsla2ScreenCountPtSisa2") var screenCountPtSisa2: Int = 0
    @AppStorage("gobsla2ScreenCountPtSisa3") var screenCountPtSisa3: Int = 0
    @AppStorage("gobsla2ScreenCountPtSisa4") var screenCountPtSisa4: Int = 0
    @AppStorage("gobsla2ScreenCountHighJaku") var screenCountHighJaku: Int = 0
    @AppStorage("gobsla2ScreenCountOver2") var screenCountOver2: Int = 0
    @AppStorage("gobsla2ScreenCountGusu") var screenCountGusu: Int = 0
    @AppStorage("gobsla2ScreenCountOver4") var screenCountOver4: Int = 0
    @AppStorage("gobsla2ScreenCountOver6") var screenCountOver6: Int = 0
    @AppStorage("gobsla2ScreenCountSum") var screenCountSum: Int = 0
    
    func screenSumFunc() {
        screenCountSum = countSum(
            screenCountDefault,
            screenCountPtSisa1,
            screenCountPtSisa2,
            screenCountPtSisa3,
            screenCountPtSisa4,
            screenCountHighJaku,
            screenCountOver2,
            screenCountGusu,
            screenCountOver4,
            screenCountOver6,
        )
    }
    
    func resetScreen() {
        screenCountDefault = 0
        screenCountPtSisa1 = 0
        screenCountPtSisa2 = 0
        screenCountPtSisa3 = 0
        screenCountPtSisa4 = 0
        screenCountHighJaku = 0
        screenCountOver2 = 0
        screenCountGusu = 0
        screenCountOver4 = 0
        screenCountOver6 = 0
        screenCountSum = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "ゴブリンスレイヤー2"
    @AppStorage("gobsla2MinusCheck") var minusCheck: Bool = false
    @AppStorage("gobsla2SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetKabuto()
        resetFirstHit()
    }
}


class Gobsla2Memory1: ObservableObject {
    @AppStorage("gobsla2JakuRareCountJakuCherryMemory1") var jakuRareCountJakuCherry: Int = 0
    @AppStorage("gobsla2JakuRareCountSuikaMemory1") var jakuRareCountSuika: Int = 0
    @AppStorage("gobsla2JakuRareCountSumMemory1") var jakuRareCountSum: Int = 0
    @AppStorage("gobsla2JakuRareCountHitMemory1") var jakuRareCountHit: Int = 0
    @AppStorage("gobsla2game35CountMissMemory1") var game35HitCountMiss: Int = 0
    @AppStorage("gobsla2game35CountHitMemory1") var game35HitCountHit: Int = 0
    @AppStorage("gobsla2game35CountSumMemory1") var game35HitCountSum: Int = 0
    @AppStorage("gobsla2PtCount10Memory1") var ptCount10: Int = 0
    @AppStorage("gobsla2PtCount20Memory1") var ptCount20: Int = 0
    @AppStorage("gobsla2PtCount30Memory1") var ptCount30: Int = 0
    @AppStorage("gobsla2PtCount40Memory1") var ptCount40: Int = 0
    @AppStorage("gobsla2PtCount50Memory1") var ptCount50: Int = 0
    @AppStorage("gobsla2PtCount60Memory1") var ptCount60: Int = 0
    @AppStorage("gobsla2PtCount70Memory1") var ptCount70: Int = 0
    @AppStorage("gobsla2PtCount80Memory1") var ptCount80: Int = 0
    @AppStorage("gobsla2PtCount90Memory1") var ptCount90: Int = 0
    @AppStorage("gobsla2PtCount100Memory1") var ptCount100: Int = 0
    @AppStorage("gobsla2PtCountSumMemory1") var ptCountSum: Int = 0
    @AppStorage("gobsla2PtCountU20Memory1") var ptCountU20: Int = 0
    @AppStorage("gobsla2PtCountO40Memory1") var ptCountO40: Int = 0
    @AppStorage("gobsla2InputGameMemory1") var inputGame: Int = 0
    @AppStorage("gobsla2SelectedKindMemory1") var selectedKind: String = "CZ"
    @AppStorage("gobsla2SelectedAtHitMemory1") var selectedAtHit: String = "ハズレ"
    @AppStorage("gobsla2GameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("gobsla2KindArrayKeyMemory1") var kindArrayData: Data?
    @AppStorage("gobsla2AtHitArrayKeyMemory1") var atHitArrayData: Data?
    @AppStorage("gobsla2NormalGameMemory1") var normalGame: Int = 0
    @AppStorage("gobsla2CzCountMemory1") var czCount: Int = 0
    @AppStorage("gobsla2AtCountMemory1") var atCount: Int = 0
    @AppStorage("gobsla2ScreenCountDefaultMemory1") var screenCountDefault: Int = 0
    @AppStorage("gobsla2ScreenCountPtSisa1Memory1") var screenCountPtSisa1: Int = 0
    @AppStorage("gobsla2ScreenCountPtSisa2Memory1") var screenCountPtSisa2: Int = 0
    @AppStorage("gobsla2ScreenCountPtSisa3Memory1") var screenCountPtSisa3: Int = 0
    @AppStorage("gobsla2ScreenCountPtSisa4Memory1") var screenCountPtSisa4: Int = 0
    @AppStorage("gobsla2ScreenCountHighJakuMemory1") var screenCountHighJaku: Int = 0
    @AppStorage("gobsla2ScreenCountOver2Memory1") var screenCountOver2: Int = 0
    @AppStorage("gobsla2ScreenCountGusuMemory1") var screenCountGusu: Int = 0
    @AppStorage("gobsla2ScreenCountOver4Memory1") var screenCountOver4: Int = 0
    @AppStorage("gobsla2ScreenCountOver6Memory1") var screenCountOver6: Int = 0
    @AppStorage("gobsla2ScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("gobsla2MemoMemory1") var memo = ""
    @AppStorage("gobsla2DateMemory1") var dateDouble = 0.0
}

class Gobsla2Memory2: ObservableObject {
    @AppStorage("gobsla2JakuRareCountJakuCherryMemory2") var jakuRareCountJakuCherry: Int = 0
    @AppStorage("gobsla2JakuRareCountSuikaMemory2") var jakuRareCountSuika: Int = 0
    @AppStorage("gobsla2JakuRareCountSumMemory2") var jakuRareCountSum: Int = 0
    @AppStorage("gobsla2JakuRareCountHitMemory2") var jakuRareCountHit: Int = 0
    @AppStorage("gobsla2game35CountMissMemory2") var game35HitCountMiss: Int = 0
    @AppStorage("gobsla2game35CountHitMemory2") var game35HitCountHit: Int = 0
    @AppStorage("gobsla2game35CountSumMemory2") var game35HitCountSum: Int = 0
    @AppStorage("gobsla2PtCount10Memory2") var ptCount10: Int = 0
    @AppStorage("gobsla2PtCount20Memory2") var ptCount20: Int = 0
    @AppStorage("gobsla2PtCount30Memory2") var ptCount30: Int = 0
    @AppStorage("gobsla2PtCount40Memory2") var ptCount40: Int = 0
    @AppStorage("gobsla2PtCount50Memory2") var ptCount50: Int = 0
    @AppStorage("gobsla2PtCount60Memory2") var ptCount60: Int = 0
    @AppStorage("gobsla2PtCount70Memory2") var ptCount70: Int = 0
    @AppStorage("gobsla2PtCount80Memory2") var ptCount80: Int = 0
    @AppStorage("gobsla2PtCount90Memory2") var ptCount90: Int = 0
    @AppStorage("gobsla2PtCount100Memory2") var ptCount100: Int = 0
    @AppStorage("gobsla2PtCountSumMemory2") var ptCountSum: Int = 0
    @AppStorage("gobsla2PtCountU20Memory2") var ptCountU20: Int = 0
    @AppStorage("gobsla2PtCountO40Memory2") var ptCountO40: Int = 0
    @AppStorage("gobsla2InputGameMemory2") var inputGame: Int = 0
    @AppStorage("gobsla2SelectedKindMemory2") var selectedKind: String = "CZ"
    @AppStorage("gobsla2SelectedAtHitMemory2") var selectedAtHit: String = "ハズレ"
    @AppStorage("gobsla2GameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("gobsla2KindArrayKeyMemory2") var kindArrayData: Data?
    @AppStorage("gobsla2AtHitArrayKeyMemory2") var atHitArrayData: Data?
    @AppStorage("gobsla2NormalGameMemory2") var normalGame: Int = 0
    @AppStorage("gobsla2CzCountMemory2") var czCount: Int = 0
    @AppStorage("gobsla2AtCountMemory2") var atCount: Int = 0
    @AppStorage("gobsla2ScreenCountDefaultMemory2") var screenCountDefault: Int = 0
    @AppStorage("gobsla2ScreenCountPtSisa1Memory2") var screenCountPtSisa1: Int = 0
    @AppStorage("gobsla2ScreenCountPtSisa2Memory2") var screenCountPtSisa2: Int = 0
    @AppStorage("gobsla2ScreenCountPtSisa3Memory2") var screenCountPtSisa3: Int = 0
    @AppStorage("gobsla2ScreenCountPtSisa4Memory2") var screenCountPtSisa4: Int = 0
    @AppStorage("gobsla2ScreenCountHighJakuMemory2") var screenCountHighJaku: Int = 0
    @AppStorage("gobsla2ScreenCountOver2Memory2") var screenCountOver2: Int = 0
    @AppStorage("gobsla2ScreenCountGusuMemory2") var screenCountGusu: Int = 0
    @AppStorage("gobsla2ScreenCountOver4Memory2") var screenCountOver4: Int = 0
    @AppStorage("gobsla2ScreenCountOver6Memory2") var screenCountOver6: Int = 0
    @AppStorage("gobsla2ScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("gobsla2MemoMemory2") var memo = ""
    @AppStorage("gobsla2DateMemory2") var dateDouble = 0.0
}


class Gobsla2Memory3: ObservableObject {
    @AppStorage("gobsla2JakuRareCountJakuCherryMemory3") var jakuRareCountJakuCherry: Int = 0
    @AppStorage("gobsla2JakuRareCountSuikaMemory3") var jakuRareCountSuika: Int = 0
    @AppStorage("gobsla2JakuRareCountSumMemory3") var jakuRareCountSum: Int = 0
    @AppStorage("gobsla2JakuRareCountHitMemory3") var jakuRareCountHit: Int = 0
    @AppStorage("gobsla2game35CountMissMemory3") var game35HitCountMiss: Int = 0
    @AppStorage("gobsla2game35CountHitMemory3") var game35HitCountHit: Int = 0
    @AppStorage("gobsla2game35CountSumMemory3") var game35HitCountSum: Int = 0
    @AppStorage("gobsla2PtCount10Memory3") var ptCount10: Int = 0
    @AppStorage("gobsla2PtCount20Memory3") var ptCount20: Int = 0
    @AppStorage("gobsla2PtCount30Memory3") var ptCount30: Int = 0
    @AppStorage("gobsla2PtCount40Memory3") var ptCount40: Int = 0
    @AppStorage("gobsla2PtCount50Memory3") var ptCount50: Int = 0
    @AppStorage("gobsla2PtCount60Memory3") var ptCount60: Int = 0
    @AppStorage("gobsla2PtCount70Memory3") var ptCount70: Int = 0
    @AppStorage("gobsla2PtCount80Memory3") var ptCount80: Int = 0
    @AppStorage("gobsla2PtCount90Memory3") var ptCount90: Int = 0
    @AppStorage("gobsla2PtCount100Memory3") var ptCount100: Int = 0
    @AppStorage("gobsla2PtCountSumMemory3") var ptCountSum: Int = 0
    @AppStorage("gobsla2PtCountU20Memory3") var ptCountU20: Int = 0
    @AppStorage("gobsla2PtCountO40Memory3") var ptCountO40: Int = 0
    @AppStorage("gobsla2InputGameMemory3") var inputGame: Int = 0
    @AppStorage("gobsla2SelectedKindMemory3") var selectedKind: String = "CZ"
    @AppStorage("gobsla2SelectedAtHitMemory3") var selectedAtHit: String = "ハズレ"
    @AppStorage("gobsla2GameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("gobsla2KindArrayKeyMemory3") var kindArrayData: Data?
    @AppStorage("gobsla2AtHitArrayKeyMemory3") var atHitArrayData: Data?
    @AppStorage("gobsla2NormalGameMemory3") var normalGame: Int = 0
    @AppStorage("gobsla2CzCountMemory3") var czCount: Int = 0
    @AppStorage("gobsla2AtCountMemory3") var atCount: Int = 0
    @AppStorage("gobsla2ScreenCountDefaultMemory3") var screenCountDefault: Int = 0
    @AppStorage("gobsla2ScreenCountPtSisa1Memory3") var screenCountPtSisa1: Int = 0
    @AppStorage("gobsla2ScreenCountPtSisa2Memory3") var screenCountPtSisa2: Int = 0
    @AppStorage("gobsla2ScreenCountPtSisa3Memory3") var screenCountPtSisa3: Int = 0
    @AppStorage("gobsla2ScreenCountPtSisa4Memory3") var screenCountPtSisa4: Int = 0
    @AppStorage("gobsla2ScreenCountHighJakuMemory3") var screenCountHighJaku: Int = 0
    @AppStorage("gobsla2ScreenCountOver2Memory3") var screenCountOver2: Int = 0
    @AppStorage("gobsla2ScreenCountGusuMemory3") var screenCountGusu: Int = 0
    @AppStorage("gobsla2ScreenCountOver4Memory3") var screenCountOver4: Int = 0
    @AppStorage("gobsla2ScreenCountOver6Memory3") var screenCountOver6: Int = 0
    @AppStorage("gobsla2ScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("gobsla2MemoMemory3") var memo = ""
    @AppStorage("gobsla2DateMemory3") var dateDouble = 0.0
}
