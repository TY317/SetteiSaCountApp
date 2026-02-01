//
//  hokutoTenseiClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/12/26.
//

import Foundation
import SwiftUI
import Combine

class HokutoTensei: ObservableObject {
    // ----------
    // 初当り
    // ----------
    let ratioAtFirstHitAt: [Double] = [366,357,336.3,298.7,283.2,273.1]
    let ratioAtFirstHitTenha: [Double] = [100.2,99.4,97.1,91.4,85.8,81.3]
    @AppStorage("hokutoTenseiNormalGame") var normalGame: Int = 0
    @AppStorage("hokutoTenseiFirstHitCountAt") var firstHitCountAt: Int = 0
    @AppStorage("hokutoTenseiFirstHitCountTenha") var firstHitCountTenha: Int = 0
    
    func resetFirstHit() {
        normalGame = 0
        firstHitCountAt = 0
        firstHitCountTenha = 0
        minusCheck = false
        resetHistory()
        tenhaDenoInput = 0.0
        tenhaGame = 0
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "北斗 転生の章2"
    @AppStorage("hokutoTenseiMinusCheck") var minusCheck: Bool = false
    @AppStorage("hokutoTenseiSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetTengeki()
    }
    
    // -----------
    // ver3.17.0で追加
    // -----------
    // 示唆ランプ
    @AppStorage("hokutoTenseiLampCountNone") var lampCountNone: Int = 0
    @AppStorage("hokutoTenseiLampCount24Sisa") var lampCount24Sisa: Int = 0
    @AppStorage("hokutoTenseiLampCount35Sisa") var lampCount35Sisa: Int = 0
    @AppStorage("hokutoTenseiLampCountHighjaku") var lampCountHighjaku: Int = 0
    @AppStorage("hokutoTenseiLampCountHighKyo") var lampCountHighKyo: Int = 0
    @AppStorage("hokutoTenseiLampCountOver2") var lampCountOver2: Int = 0
    @AppStorage("hokutoTenseiLampCountOver4") var lampCountOver4: Int = 0
    @AppStorage("hokutoTenseiLampCountOver6") var lampCountOver6: Int = 0
    @AppStorage("hokutoTenseiLampCountSum") var lampCountSum: Int = 0
    
    func lampSumFunc() {
        lampCountSum = countSum(
            lampCountNone,
            lampCount24Sisa,
            lampCount35Sisa,
            lampCountHighjaku,
            lampCountHighKyo,
            lampCountOver2,
            lampCountOver4,
            lampCountOver6,
        )
    }
    
    func resetNormal() {
        lampCountNone = 0
        lampCount24Sisa = 0
        lampCount35Sisa = 0
        lampCountHighjaku = 0
        lampCountHighKyo = 0
        lampCountOver2 = 0
        lampCountOver4 = 0
        lampCountOver6 = 0
        lampCountSum = 0
        minusCheck = false
        
        lampCountWhiteSum = 0
        koyakuCountJakuCherry = 0
        koyakuCountSuika = 0
        koyakuCountSum = 0
        koyakuCountTenhaHit = 0
    }
    
    // あべし履歴
    @AppStorage("hokutoTenseiInputGame") var inputGame: Int = 0
    // ゲーム数配列
    let gameArrayKey: String = "hokutoTenseiGameArrayKey"
    @AppStorage("hokutoTenseiGameArrayKey") var gameArrayData: Data?
    
    // データ登録
    func addHistory() {
        arrayIntAddData(arrayData: gameArrayData, addData: inputGame, key: gameArrayKey)
    }
    
    // 1行削除
    func removeLastHistory() {
        arrayIntRemoveLast(arrayData: gameArrayData, key: gameArrayKey)
    }
    
    func resetHistory() {
        inputGame = 0
        arrayIntRemoveAll(arrayData: gameArrayData, key: gameArrayKey)
    }
    
    // --------
    // ver3.17.1で追加
    // --------
    let ratioLamp24Sisa: [Double] = [50,60,40,60,40,50]
    let ratioLamp35Sisa: [Double] = [50,40,60,40,60,50]
    @AppStorage("hokutoTenseiLampCountWhiteSum") var lampCountWhiteSum: Int = 0
    
     func lampWhiteSumFunc() {
        lampCountWhiteSum = lampCount24Sisa + lampCount35Sisa
    }
    
    // 通常時　レア役からの天破当選
    let ratioJakuCherrySuikaTenha: [Double] = [0.8,0.8,1.6,2.3,3.5,4.7]
    let ratioChanceShobuTenhaTeikaku: [Double] = [2,2.7,3.1,3.9,4.7,6.3]
    let ratioChanceShobuTenhaKokoaku: [Double] = [10.2,10.5,10.9,12.5,15.6,18.8]
    @AppStorage("hokutoTenseiKoyakuCountJakuCherry") var koyakuCountJakuCherry: Int = 0
    @AppStorage("hokutoTenseiKoyakuCountSuika") var koyakuCountSuika: Int = 0
    @AppStorage("hokutoTenseiKoyakuCountSum") var koyakuCountSum: Int = 0
    @AppStorage("hokutoTenseiKoyakuCountTenhaHit") var koyakuCountTenhaHit: Int = 0
    
     func koyakuSumFunc() {
        koyakuCountSum = koyakuCountJakuCherry + koyakuCountSuika
    }
    
    // -------
    // ver3.18.0で追加
    // -------
    // 天撃
    let ratioTengeki: [Double] = [9.2,9.2,10,10.7,17.9,30.1]
    @AppStorage("hokutoTenseiTengekiCountMiss") var tengekiCountMiss: Int = 0
    @AppStorage("hokutoTenseiTengekiCountHit") var tengekiCountHit: Int = 0
    @AppStorage("hokutoTenseiTengekiCountSum") var tengekiCountSum: Int = 0
    
    func tengekiSumFunc() {
        tengekiCountSum = tengekiCountMiss + tengekiCountHit
    }
    
    func resetTengeki() {
        tengekiCountMiss = 0
        tengekiCountHit = 0
        tengekiCountSum = 0
        minusCheck = false
    }
    
    // 天破突入確率入力化
    @AppStorage("hokutoTenseiTenhaDenoInput") var tenhaDenoInput: Double = 0.0
    @AppStorage("hokutoTenseiTenhaGame") var tenhaGame: Int = 0
}


class HokutoTenseiMemory1: ObservableObject {
    @AppStorage("hokutoTenseiNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("hokutoTenseiFirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("hokutoTenseiFirstHitCountTenhaMemory1") var firstHitCountTenha: Int = 0
    @AppStorage("hokutoTenseiMemoMemory1") var memo = ""
    @AppStorage("hokutoTenseiDateMemory1") var dateDouble = 0.0
    
    // -----------
    // ver3.17.0で追加
    // -----------
    @AppStorage("hokutoTenseiLampCountNoneMemory1") var lampCountNone: Int = 0
    @AppStorage("hokutoTenseiLampCount24SisaMemory1") var lampCount24Sisa: Int = 0
    @AppStorage("hokutoTenseiLampCount35SisaMemory1") var lampCount35Sisa: Int = 0
    @AppStorage("hokutoTenseiLampCountHighjakuMemory1") var lampCountHighjaku: Int = 0
    @AppStorage("hokutoTenseiLampCountHighKyoMemory1") var lampCountHighKyo: Int = 0
    @AppStorage("hokutoTenseiLampCountOver2Memory1") var lampCountOver2: Int = 0
    @AppStorage("hokutoTenseiLampCountOver4Memory1") var lampCountOver4: Int = 0
    @AppStorage("hokutoTenseiLampCountOver6Memory1") var lampCountOver6: Int = 0
    @AppStorage("hokutoTenseiLampCountSumMemory1") var lampCountSum: Int = 0
    @AppStorage("hokutoTenseiInputGameMemory1") var inputGame: Int = 0
    @AppStorage("hokutoTenseiGameArrayKeyMemory1") var gameArrayData: Data?
    
    // --------
    // ver3.17.1で追加
    // --------
    @AppStorage("hokutoTenseiLampCountWhiteSumMemory1") var lampCountWhiteSum: Int = 0
    @AppStorage("hokutoTenseiKoyakuCountJakuCherryMemory1") var koyakuCountJakuCherry: Int = 0
    @AppStorage("hokutoTenseiKoyakuCountSuikaMemory1") var koyakuCountSuika: Int = 0
    @AppStorage("hokutoTenseiKoyakuCountSumMemory1") var koyakuCountSum: Int = 0
    @AppStorage("hokutoTenseiKoyakuCountTenhaHitMemory1") var koyakuCountTenhaHit: Int = 0
    
    // -------
    // ver3.18.0で追加
    // -------
    @AppStorage("hokutoTenseiTengekiCountMissMemory1") var tengekiCountMiss: Int = 0
    @AppStorage("hokutoTenseiTengekiCountHitMemory1") var tengekiCountHit: Int = 0
    @AppStorage("hokutoTenseiTengekiCountSumMemory1") var tengekiCountSum: Int = 0
    @AppStorage("hokutoTenseiTenhaDenoInputMemory1") var tenhaDenoInput: Double = 0.0
    @AppStorage("hokutoTenseiTenhaGameMemory1") var tenhaGame: Int = 0
}

class HokutoTenseiMemory2: ObservableObject {
    @AppStorage("hokutoTenseiNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("hokutoTenseiFirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("hokutoTenseiFirstHitCountTenhaMemory2") var firstHitCountTenha: Int = 0
    @AppStorage("hokutoTenseiMemoMemory2") var memo = ""
    @AppStorage("hokutoTenseiDateMemory2") var dateDouble = 0.0
    
    // -----------
    // ver3.17.0で追加
    // -----------
    @AppStorage("hokutoTenseiLampCountNoneMemory2") var lampCountNone: Int = 0
    @AppStorage("hokutoTenseiLampCount24SisaMemory2") var lampCount24Sisa: Int = 0
    @AppStorage("hokutoTenseiLampCount35SisaMemory2") var lampCount35Sisa: Int = 0
    @AppStorage("hokutoTenseiLampCountHighjakuMemory2") var lampCountHighjaku: Int = 0
    @AppStorage("hokutoTenseiLampCountHighKyoMemory2") var lampCountHighKyo: Int = 0
    @AppStorage("hokutoTenseiLampCountOver2Memory2") var lampCountOver2: Int = 0
    @AppStorage("hokutoTenseiLampCountOver4Memory2") var lampCountOver4: Int = 0
    @AppStorage("hokutoTenseiLampCountOver6Memory2") var lampCountOver6: Int = 0
    @AppStorage("hokutoTenseiLampCountSumMemory2") var lampCountSum: Int = 0
    @AppStorage("hokutoTenseiInputGameMemory2") var inputGame: Int = 0
    @AppStorage("hokutoTenseiGameArrayKeyMemory2") var gameArrayData: Data?
    
    // --------
    // ver3.17.1で追加
    // --------
    @AppStorage("hokutoTenseiLampCountWhiteSumMemory2") var lampCountWhiteSum: Int = 0
    @AppStorage("hokutoTenseiKoyakuCountJakuCherryMemory2") var koyakuCountJakuCherry: Int = 0
    @AppStorage("hokutoTenseiKoyakuCountSuikaMemory2") var koyakuCountSuika: Int = 0
    @AppStorage("hokutoTenseiKoyakuCountSumMemory2") var koyakuCountSum: Int = 0
    @AppStorage("hokutoTenseiKoyakuCountTenhaHitMemory2") var koyakuCountTenhaHit: Int = 0
    
    // -------
    // ver3.18.0で追加
    // -------
    @AppStorage("hokutoTenseiTengekiCountMissMemory2") var tengekiCountMiss: Int = 0
    @AppStorage("hokutoTenseiTengekiCountHitMemory2") var tengekiCountHit: Int = 0
    @AppStorage("hokutoTenseiTengekiCountSumMemory2") var tengekiCountSum: Int = 0
    @AppStorage("hokutoTenseiTenhaDenoInputMemory2") var tenhaDenoInput: Double = 0.0
    @AppStorage("hokutoTenseiTenhaGameMemory2") var tenhaGame: Int = 0
}

class HokutoTenseiMemory3: ObservableObject {
    @AppStorage("hokutoTenseiNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("hokutoTenseiFirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("hokutoTenseiFirstHitCountTenhaMemory3") var firstHitCountTenha: Int = 0
    @AppStorage("hokutoTenseiMemoMemory3") var memo = ""
    @AppStorage("hokutoTenseiDateMemory3") var dateDouble = 0.0
    
    // -----------
    // ver3.17.0で追加
    // -----------
    @AppStorage("hokutoTenseiLampCountNoneMemory3") var lampCountNone: Int = 0
    @AppStorage("hokutoTenseiLampCount24SisaMemory3") var lampCount24Sisa: Int = 0
    @AppStorage("hokutoTenseiLampCount35SisaMemory3") var lampCount35Sisa: Int = 0
    @AppStorage("hokutoTenseiLampCountHighjakuMemory3") var lampCountHighjaku: Int = 0
    @AppStorage("hokutoTenseiLampCountHighKyoMemory3") var lampCountHighKyo: Int = 0
    @AppStorage("hokutoTenseiLampCountOver2Memory3") var lampCountOver2: Int = 0
    @AppStorage("hokutoTenseiLampCountOver4Memory3") var lampCountOver4: Int = 0
    @AppStorage("hokutoTenseiLampCountOver6Memory3") var lampCountOver6: Int = 0
    @AppStorage("hokutoTenseiLampCountSumMemory3") var lampCountSum: Int = 0
    @AppStorage("hokutoTenseiInputGameMemory3") var inputGame: Int = 0
    @AppStorage("hokutoTenseiGameArrayKeyMemory3") var gameArrayData: Data?
    
    // --------
    // ver3.17.1で追加
    // --------
    @AppStorage("hokutoTenseiLampCountWhiteSumMemory3") var lampCountWhiteSum: Int = 0
    @AppStorage("hokutoTenseiKoyakuCountJakuCherryMemory3") var koyakuCountJakuCherry: Int = 0
    @AppStorage("hokutoTenseiKoyakuCountSuikaMemory3") var koyakuCountSuika: Int = 0
    @AppStorage("hokutoTenseiKoyakuCountSumMemory3") var koyakuCountSum: Int = 0
    @AppStorage("hokutoTenseiKoyakuCountTenhaHitMemory3") var koyakuCountTenhaHit: Int = 0
    
    // -------
    // ver3.18.0で追加
    // -------
    @AppStorage("hokutoTenseiTengekiCountMissMemory3") var tengekiCountMiss: Int = 0
    @AppStorage("hokutoTenseiTengekiCountHitMemory3") var tengekiCountHit: Int = 0
    @AppStorage("hokutoTenseiTengekiCountSumMemory3") var tengekiCountSum: Int = 0
    @AppStorage("hokutoTenseiTenhaDenoInputMemory3") var tenhaDenoInput: Double = 0.0
    @AppStorage("hokutoTenseiTenhaGameMemory3") var tenhaGame: Int = 0
}
