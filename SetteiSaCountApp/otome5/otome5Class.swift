//
//  otome5Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/06/02.
//

import Foundation
import SwiftUI
import Combine

class Otome5: ObservableObject {
    // ----------
    // 通常時
    // ----------
    // 乙女アタック
    let ratioOtomeAttack: [Double] = [20.3,21.4,23.2,24.7,25.2,25.7]
    @AppStorage("otome5OtomeAttackCountMiss") var otomeAttackMiss: Int = 0
    @AppStorage("otome5OtomeAttackCountHit") var otomeAttackHit: Int = 0
    @AppStorage("otome5OtomeAttackCountSum") var otomeAttackSum: Int = 0
    
    func attackSumFunc() {
        otomeAttackSum = otomeAttackHit + otomeAttackMiss
    }
    
    func resetNormal() {
        otomeAttackMiss = 0
        otomeAttackHit = 0
        otomeAttackSum = 0
        minusCheck = false
    }
    
    // -----------
    // 周期履歴
    // -----------
    // 選択肢
    let cycleList: [Int] = [1,2,3,4,5,6]
    let kindList: [String] = ["焔舞", "紫炎"]
    
    // 選択結果
    @AppStorage("otome5InputGame") var inputGame: Int = 0
    @AppStorage("otome5SelectedCycle") var selectedCycle: Int = 1
    @AppStorage("otome5SelectedKind") var selectedKind: String = "焔舞"
    
    // ゲーム数配列
    let gameArrayKey: String = "otome5GameArrayKey"
    @AppStorage("otome5GameArrayKey") var gameArrayData: Data?
    // 周期配列
    let cycleArrayKey: String = "otome5CycleArrayKey"
    @AppStorage("otome5CycleArrayKey") var cycleArrayData: Data?
    // 種類配列
    let kindArrayKey: String = "otome5KindArrayKey"
    @AppStorage("otome5KindArrayKey") var kindArrayData: Data?
    
    // データ登録
    func addHistory() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
        arrayIntAddData(arrayData: cycleArrayData, addData: selectedCycle, key: cycleArrayKey)
        arrayStringAddData(arrayData: kindArrayData, addData: selectedKind, key: kindArrayKey)
        addRemoveCommon()
    }
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
        arrayIntRemoveLast(arrayData: cycleArrayData, key: cycleArrayKey)
        arrayStringRemoveLast(arrayData: kindArrayData, key: kindArrayKey)
        addRemoveCommon()
    }
    
    func resetHistory() {
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
        arrayIntRemoveAll(arrayData: cycleArrayData, key: cycleArrayKey)
        arrayStringRemoveAll(arrayData: kindArrayData, key: kindArrayKey)
        addRemoveCommon()
        inputGame = 0
        minusCheck = false
    }
    
    func addRemoveCommon() {
        
    }
    
    // --------
    // 初当り
    // --------
    let ratioFirstHitAt: [Double] = [359.5,350.8,332.5,302.8,281.0,262.9]
    let ratioFirstHitDirect: [Double] = [21206.7,15648.9,13143.5,8143.4,6427.6,5502.7]
    @AppStorage("otome5NormalGame") var normalGame: Int = 0
    @AppStorage("otome5FirstHitCountAt") var firstHitCountAt: Int = 0
    @AppStorage("otome5FirstHitCountDirect") var firstHitCountDirect: Int = 0
    
    func resetFirstHit() {
        normalGame = 0
        firstHitCountAt = 0
        firstHitCountDirect = 0
        minusCheck = false
    }
    
    // --------
    // 終了画面スタンプ
    // --------
    @AppStorage("otome5ScreenCountDefaut") var screenCountDefaut: Int = 0
    @AppStorage("otome5ScreenCountOver2") var screenCountOver2: Int = 0
    @AppStorage("otome5ScreenCountOver3") var screenCountOver3: Int = 0
    @AppStorage("otome5ScreenCountOver4") var screenCountOver4: Int = 0
    @AppStorage("otome5ScreenCountOver5") var screenCountOver5: Int = 0
    @AppStorage("otome5ScreenCountOver6") var screenCountOver6: Int = 0
    @AppStorage("otome5ScreenCountSum") var screenCountSum: Int = 0
    
    func screenSumFunc() {
        screenCountSum = countSum(
            screenCountDefaut,
            screenCountOver2,
            screenCountOver3,
            screenCountOver4,
            screenCountOver5,
            screenCountOver6,
        )
    }
    
    func resetScreen() {
        screenCountDefaut = 0
        screenCountOver2 = 0
        screenCountOver3 = 0
        screenCountOver4 = 0
        screenCountOver5 = 0
        screenCountOver6 = 0
        screenCountSum = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "戦国乙女5"
    @AppStorage("otome5MinusCheck") var minusCheck: Bool = false
    @AppStorage("otome5SelectedMemory") var selectedMemory = "メモリー1"
    
    // -------
    // ボイス選択
    // -------
    let ratioEndingVoiceOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioEndingVoiceOver3: [Double] = [0,0,0.1,0.1,0.1,0.1,]
    let ratioEndingVoiceOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioEndingVoiceOver5: [Double] = [0,0,0,0,0.1,0.1,]
    let ratioEndingVoiceOver6: [Double] = [0,0,0,0,0,0.1,]
    let ratioEndingVoiceNegate2: [Double] = [0.1,0,0.1,0.1,0.1,0.1,]
    let ratioEndingVoiceNegate3: [Double] = [0.1,0.1,0,0.1,0.1,0.1,]
    @AppStorage("otome5VoiceCount1") var voiceCount1: Int = 0
    @AppStorage("otome5VoiceCount2") var voiceCount2: Int = 0
    @AppStorage("otome5VoiceCount3") var voiceCount3: Int = 0
    @AppStorage("otome5VoiceCount4") var voiceCount4: Int = 0
    @AppStorage("otome5VoiceCount5") var voiceCount5: Int = 0
    @AppStorage("otome5VoiceCount6") var voiceCount6: Int = 0
    @AppStorage("otome5VoiceCount7") var voiceCount7: Int = 0
    @AppStorage("otome5VoiceCount8") var voiceCount8: Int = 0
    @AppStorage("otome5VoiceCount9") var voiceCount9: Int = 0
    @AppStorage("otome5VoiceCount10") var voiceCount10: Int = 0
    @AppStorage("otome5VoiceCount11") var voiceCount11: Int = 0
    @AppStorage("otome5VoiceCount12") var voiceCount12: Int = 0
    @AppStorage("otome5VoiceCountSum") var voiceCountSum: Int = 0

    func voiceSumFunc() {
        voiceCountSum = countSum(
            voiceCount1,
            voiceCount2,
            voiceCount3,
            voiceCount4,
            voiceCount5,
            voiceCount6,
            voiceCount7,
            voiceCount8,
            voiceCount9,
            voiceCount10,
            voiceCount11,
            voiceCount12,
        )
    }

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
        voiceCount10 = 0
        voiceCount11 = 0
        voiceCount12 = 0
        voiceCountSum = 0
        minusCheck = false
    }

    func resetAll() {
        resetNormal()
        resetHistory()
        resetFirstHit()
        resetScreen()
        resetVoice()
    }
}


class Otome5Memory1: ObservableObject {
    @AppStorage("otome5OtomeAttackCountMissMemory1") var otomeAttackMiss: Int = 0
    @AppStorage("otome5OtomeAttackCountHitMemory1") var otomeAttackHit: Int = 0
    @AppStorage("otome5OtomeAttackCountSumMemory1") var otomeAttackSum: Int = 0
    @AppStorage("otome5GameArrayKeyMemory1") var gameArrayData: Data?
    @AppStorage("otome5CycleArrayKeyMemory1") var cycleArrayData: Data?
    @AppStorage("otome5KindArrayKeyMemory1") var kindArrayData: Data?
    @AppStorage("otome5NormalGameMemory1") var normalGame: Int = 0
    @AppStorage("otome5FirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("otome5FirstHitCountDirectMemory1") var firstHitCountDirect: Int = 0
    @AppStorage("otome5ScreenCountDefautMemory1") var screenCountDefaut: Int = 0
    @AppStorage("otome5ScreenCountOver2Memory1") var screenCountOver2: Int = 0
    @AppStorage("otome5ScreenCountOver3Memory1") var screenCountOver3: Int = 0
    @AppStorage("otome5ScreenCountOver4Memory1") var screenCountOver4: Int = 0
    @AppStorage("otome5ScreenCountOver5Memory1") var screenCountOver5: Int = 0
    @AppStorage("otome5ScreenCountOver6Memory1") var screenCountOver6: Int = 0
    @AppStorage("otome5ScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("otome5VoiceCount1Memory1") var voiceCount1: Int = 0
    @AppStorage("otome5VoiceCount2Memory1") var voiceCount2: Int = 0
    @AppStorage("otome5VoiceCount3Memory1") var voiceCount3: Int = 0
    @AppStorage("otome5VoiceCount4Memory1") var voiceCount4: Int = 0
    @AppStorage("otome5VoiceCount5Memory1") var voiceCount5: Int = 0
    @AppStorage("otome5VoiceCount6Memory1") var voiceCount6: Int = 0
    @AppStorage("otome5VoiceCount7Memory1") var voiceCount7: Int = 0
    @AppStorage("otome5VoiceCount8Memory1") var voiceCount8: Int = 0
    @AppStorage("otome5VoiceCount9Memory1") var voiceCount9: Int = 0
    @AppStorage("otome5VoiceCount10Memory1") var voiceCount10: Int = 0
    @AppStorage("otome5VoiceCount11Memory1") var voiceCount11: Int = 0
    @AppStorage("otome5VoiceCount12Memory1") var voiceCount12: Int = 0
    @AppStorage("otome5VoiceCountSumMemory1") var voiceCountSum: Int = 0
    @AppStorage("otome5MemoMemory1") var memo = ""
    @AppStorage("otome5DateMemory1") var dateDouble = 0.0
}


class Otome5Memory2: ObservableObject {
    @AppStorage("otome5OtomeAttackCountMissMemory2") var otomeAttackMiss: Int = 0
    @AppStorage("otome5OtomeAttackCountHitMemory2") var otomeAttackHit: Int = 0
    @AppStorage("otome5OtomeAttackCountSumMemory2") var otomeAttackSum: Int = 0
    @AppStorage("otome5GameArrayKeyMemory2") var gameArrayData: Data?
    @AppStorage("otome5CycleArrayKeyMemory2") var cycleArrayData: Data?
    @AppStorage("otome5KindArrayKeyMemory2") var kindArrayData: Data?
    @AppStorage("otome5NormalGameMemory2") var normalGame: Int = 0
    @AppStorage("otome5FirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("otome5FirstHitCountDirectMemory2") var firstHitCountDirect: Int = 0
    @AppStorage("otome5ScreenCountDefautMemory2") var screenCountDefaut: Int = 0
    @AppStorage("otome5ScreenCountOver2Memory2") var screenCountOver2: Int = 0
    @AppStorage("otome5ScreenCountOver3Memory2") var screenCountOver3: Int = 0
    @AppStorage("otome5ScreenCountOver4Memory2") var screenCountOver4: Int = 0
    @AppStorage("otome5ScreenCountOver5Memory2") var screenCountOver5: Int = 0
    @AppStorage("otome5ScreenCountOver6Memory2") var screenCountOver6: Int = 0
    @AppStorage("otome5ScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("otome5VoiceCount1Memory2") var voiceCount1: Int = 0
    @AppStorage("otome5VoiceCount2Memory2") var voiceCount2: Int = 0
    @AppStorage("otome5VoiceCount3Memory2") var voiceCount3: Int = 0
    @AppStorage("otome5VoiceCount4Memory2") var voiceCount4: Int = 0
    @AppStorage("otome5VoiceCount5Memory2") var voiceCount5: Int = 0
    @AppStorage("otome5VoiceCount6Memory2") var voiceCount6: Int = 0
    @AppStorage("otome5VoiceCount7Memory2") var voiceCount7: Int = 0
    @AppStorage("otome5VoiceCount8Memory2") var voiceCount8: Int = 0
    @AppStorage("otome5VoiceCount9Memory2") var voiceCount9: Int = 0
    @AppStorage("otome5VoiceCount10Memory2") var voiceCount10: Int = 0
    @AppStorage("otome5VoiceCount11Memory2") var voiceCount11: Int = 0
    @AppStorage("otome5VoiceCount12Memory2") var voiceCount12: Int = 0
    @AppStorage("otome5VoiceCountSumMemory2") var voiceCountSum: Int = 0
    @AppStorage("otome5MemoMemory2") var memo = ""
    @AppStorage("otome5DateMemory2") var dateDouble = 0.0
}


class Otome5Memory3: ObservableObject {
    @AppStorage("otome5OtomeAttackCountMissMemory3") var otomeAttackMiss: Int = 0
    @AppStorage("otome5OtomeAttackCountHitMemory3") var otomeAttackHit: Int = 0
    @AppStorage("otome5OtomeAttackCountSumMemory3") var otomeAttackSum: Int = 0
    @AppStorage("otome5GameArrayKeyMemory3") var gameArrayData: Data?
    @AppStorage("otome5CycleArrayKeyMemory3") var cycleArrayData: Data?
    @AppStorage("otome5KindArrayKeyMemory3") var kindArrayData: Data?
    @AppStorage("otome5NormalGameMemory3") var normalGame: Int = 0
    @AppStorage("otome5FirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("otome5FirstHitCountDirectMemory3") var firstHitCountDirect: Int = 0
    @AppStorage("otome5ScreenCountDefautMemory3") var screenCountDefaut: Int = 0
    @AppStorage("otome5ScreenCountOver2Memory3") var screenCountOver2: Int = 0
    @AppStorage("otome5ScreenCountOver3Memory3") var screenCountOver3: Int = 0
    @AppStorage("otome5ScreenCountOver4Memory3") var screenCountOver4: Int = 0
    @AppStorage("otome5ScreenCountOver5Memory3") var screenCountOver5: Int = 0
    @AppStorage("otome5ScreenCountOver6Memory3") var screenCountOver6: Int = 0
    @AppStorage("otome5ScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("otome5VoiceCount1Memory3") var voiceCount1: Int = 0
    @AppStorage("otome5VoiceCount2Memory3") var voiceCount2: Int = 0
    @AppStorage("otome5VoiceCount3Memory3") var voiceCount3: Int = 0
    @AppStorage("otome5VoiceCount4Memory3") var voiceCount4: Int = 0
    @AppStorage("otome5VoiceCount5Memory3") var voiceCount5: Int = 0
    @AppStorage("otome5VoiceCount6Memory3") var voiceCount6: Int = 0
    @AppStorage("otome5VoiceCount7Memory3") var voiceCount7: Int = 0
    @AppStorage("otome5VoiceCount8Memory3") var voiceCount8: Int = 0
    @AppStorage("otome5VoiceCount9Memory3") var voiceCount9: Int = 0
    @AppStorage("otome5VoiceCount10Memory3") var voiceCount10: Int = 0
    @AppStorage("otome5VoiceCount11Memory3") var voiceCount11: Int = 0
    @AppStorage("otome5VoiceCount12Memory3") var voiceCount12: Int = 0
    @AppStorage("otome5VoiceCountSumMemory3") var voiceCountSum: Int = 0
    @AppStorage("otome5MemoMemory3") var memo = ""
    @AppStorage("otome5DateMemory3") var dateDouble = 0.0
}
