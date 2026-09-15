//
//  gareiClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹.
//

import Foundation
import SwiftUI
import Combine

class Garei: ObservableObject {
    // -------
    // 通常時
    // -------
    // 小役（-1 は全設定の確率が非公開）
    let ratioSuika: [Double] = [81.9,79.9,77.8,75.6,73.8,72.1]
    let ratioJakuCherry: [Double] = [99,95.3,91,85.1,80.5,78.2]
    let ratioKyoCherry: [Double] = [481.9,-1,-1,-1,-1,-1]
    let ratioJakuChance: [Double] = [136.5,-1,-1,-1,-1,-1]
    let ratioKyoChance: [Double] = [546.1,-1,-1,-1,-1,-1]
    @AppStorage("gareiKoyakuCountSuika") var koyakuCountSuika: Int = 0
    @AppStorage("gareiKoyakuCountJakuCherry") var koyakuCountJakuCherry: Int = 0
    @AppStorage("gareiKoyakuCountKyoCherry") var koyakuCountKyoCherry: Int = 0
    @AppStorage("gareiKoyakuCountJakuChance") var koyakuCountJakuChance: Int = 0
    @AppStorage("gareiKoyakuCountKyoChance") var koyakuCountKyoChance: Int = 0
    // ボーナス重複当選（弱🍒・強🍒のみ）
    let ratioChofukuJakuCherry: [Double] = [8.2,8.2,9.2,10.3,11.1,11.7]
    let ratioChofukuKyoCherry: [Double] = [25.3,25.3,28.1,31.5,34,35.9]
    @AppStorage("gareiChofukuCountJakuCherry") var chofukuCountJakuCherry: Int = 0
    @AppStorage("gareiChofukuCountKyoCherry") var chofukuCountKyoCherry: Int = 0
    // ゲーム数
    @AppStorage("gareiGameNumberStart") var gameNumberStart: Int = 0
    @AppStorage("gareiGameNumberCurrent") var gameNumberCurrent: Int = 0
    @AppStorage("gareiGameNumberPlay") var gameNumberPlay: Int = 0

    func resetNormal() {
        koyakuCountSuika = 0
        koyakuCountJakuCherry = 0
        koyakuCountKyoCherry = 0
        koyakuCountJakuChance = 0
        koyakuCountKyoChance = 0
        chofukuCountJakuCherry = 0
        chofukuCountKyoCherry = 0
        gameNumberStart = 0
        gameNumberCurrent = 0
        gameNumberPlay = 0
        minusCheck = false
    }
    
    // -------
    // CZ
    // -------
    let ratioCzRangeki: [Double] = [1.6,-1,-1,-1,-1,-1]
    @AppStorage("gareiCzRangekiCountMiss") var czRangekiCountMiss: Int = 0
    @AppStorage("gareiCzRangekiCountHit") var czRangekiCountHit: Int = 0
    @AppStorage("gareiCzRangekiCountSum") var czRangekiCountSum: Int = 0
    
    func rangekiSumFunc() {
        czRangekiCountSum = czRangekiCountHit + czRangekiCountMiss
    }
    
    func resetCz() {
        czRangekiCountMiss = 0
        czRangekiCountHit = 0
        czRangekiCountSum = 0
        minusCheck = false
    }

    // --------
    // 初当り
    // --------
    let ratioFirstHitCz: [Double] = [287.2,-1,-1,-1,-1,-1]
    let ratioFirstHitBig: [Double] = [385.5,385.5,378.8,372.4,368.2,364.1]
    let ratioFirstHitReg: [Double] = [414.8,409.6,402.1,385.5,376.6,364.1]
    let ratioFirstHitArt: [Double] = [468.6,-1,-1,-1,-1,-1]
    @AppStorage("gareiNormalGame") var normalGame: Int = 0
    @AppStorage("gareiFirstHitCountCz") var firstHitCountCz: Int = 0
    @AppStorage("gareiFirstHitCountBig") var firstHitCountBig: Int = 0
    @AppStorage("gareiFirstHitCountReg") var firstHitCountReg: Int = 0
    @AppStorage("gareiFirstHitCountArt") var firstHitCountArt: Int = 0

    func resetFirstHit() {
        normalGame = 0
        firstHitCountCz = 0
        firstHitCountBig = 0
        firstHitCountReg = 0
        firstHitCountArt = 0
        minusCheck = false
    }

    // --------
    // ボーナス終了画面
    // --------
    let ratioBonusScreenOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioBonusScreenOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    let ratioBonusScreenOver6: [Double] = [0,0,0,0,0,0.1,]
    @AppStorage("gareiBonusScreenCount1") var bonusScreenCount1: Int = 0
    @AppStorage("gareiBonusScreenCount2") var bonusScreenCount2: Int = 0
    @AppStorage("gareiBonusScreenCount3") var bonusScreenCount3: Int = 0
    @AppStorage("gareiBonusScreenCount4") var bonusScreenCount4: Int = 0
    @AppStorage("gareiBonusScreenCountSum") var bonusScreenCountSum: Int = 0

    func bonusScreenSumFunc() {
        bonusScreenCountSum = countSum(
            bonusScreenCount1,
            bonusScreenCount2,
            bonusScreenCount3,
            bonusScreenCount4,
        )
    }

    func resetBonusScreen() {
        bonusScreenCount1 = 0
        bonusScreenCount2 = 0
        bonusScreenCount3 = 0
        bonusScreenCount4 = 0
        bonusScreenCountSum = 0
        minusCheck = false
    }

    // --------
    // ART終了画面
    // --------
    let ratioArtScreenOver2: [Double] = [0,0.1,0.1,0.1,0.1,0.1,]
    let ratioArtScreenOver4: [Double] = [0,0,0,0.1,0.1,0.1,]
    @AppStorage("gareiArtScreenCount1") var artScreenCount1: Int = 0
    @AppStorage("gareiArtScreenCount2") var artScreenCount2: Int = 0
    @AppStorage("gareiArtScreenCount3") var artScreenCount3: Int = 0
    @AppStorage("gareiArtScreenCount4") var artScreenCount4: Int = 0
    @AppStorage("gareiArtScreenCountSum") var artScreenCountSum: Int = 0

    func artScreenSumFunc() {
        artScreenCountSum = countSum(
            artScreenCount1,
            artScreenCount2,
            artScreenCount3,
            artScreenCount4,
        )
    }

    func resetArtScreen() {
        artScreenCount1 = 0
        artScreenCount2 = 0
        artScreenCount3 = 0
        artScreenCount4 = 0
        artScreenCountSum = 0
        minusCheck = false
    }

    // -----------
    // 共通
    // -----------
    let machineName: String = "喰霊-零-Re"
    @AppStorage("gareiMinusCheck") var minusCheck: Bool = false
    @AppStorage("gareiSelectedMemory") var selectedMemory = "メモリー1"

    // -------
    // キャラ選択
    // -------
    @AppStorage("gareiCharaCount1") var charaCount1: Int = 0
    @AppStorage("gareiCharaCount2") var charaCount2: Int = 0
    @AppStorage("gareiCharaCount3") var charaCount3: Int = 0
    @AppStorage("gareiCharaCount4") var charaCount4: Int = 0
    @AppStorage("gareiCharaCount5") var charaCount5: Int = 0
    @AppStorage("gareiCharaCount6") var charaCount6: Int = 0
    @AppStorage("gareiCharaCountSum") var charaCountSum: Int = 0

    func charaSumFunc() {
        charaCountSum = countSum(
            charaCount1,
            charaCount2,
            charaCount3,
            charaCount4,
            charaCount5,
            charaCount6,
        )
    }

    func resetChara() {
        charaCount1 = 0
        charaCount2 = 0
        charaCount3 = 0
        charaCount4 = 0
        charaCount5 = 0
        charaCount6 = 0
        charaCountSum = 0
        minusCheck = false
    }

    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetBonusScreen()
        resetArtScreen()
        resetCz()
        resetChara()
    }
}


class GareiMemory1: ObservableObject {
    @AppStorage("gareiKoyakuCountSuikaMemory1") var koyakuCountSuika: Int = 0
    @AppStorage("gareiKoyakuCountJakuCherryMemory1") var koyakuCountJakuCherry: Int = 0
    @AppStorage("gareiKoyakuCountKyoCherryMemory1") var koyakuCountKyoCherry: Int = 0
    @AppStorage("gareiKoyakuCountJakuChanceMemory1") var koyakuCountJakuChance: Int = 0
    @AppStorage("gareiKoyakuCountKyoChanceMemory1") var koyakuCountKyoChance: Int = 0
    @AppStorage("gareiChofukuCountJakuCherryMemory1") var chofukuCountJakuCherry: Int = 0
    @AppStorage("gareiChofukuCountKyoCherryMemory1") var chofukuCountKyoCherry: Int = 0
    @AppStorage("gareiGameNumberStartMemory1") var gameNumberStart: Int = 0
    @AppStorage("gareiGameNumberCurrentMemory1") var gameNumberCurrent: Int = 0
    @AppStorage("gareiGameNumberPlayMemory1") var gameNumberPlay: Int = 0
    @AppStorage("gareiCzRangekiCountMissMemory1") var czRangekiCountMiss: Int = 0
    @AppStorage("gareiCzRangekiCountHitMemory1") var czRangekiCountHit: Int = 0
    @AppStorage("gareiCzRangekiCountSumMemory1") var czRangekiCountSum: Int = 0
    @AppStorage("gareiNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("gareiFirstHitCountCzMemory1") var firstHitCountCz: Int = 0
    @AppStorage("gareiFirstHitCountBigMemory1") var firstHitCountBig: Int = 0
    @AppStorage("gareiFirstHitCountRegMemory1") var firstHitCountReg: Int = 0
    @AppStorage("gareiFirstHitCountArtMemory1") var firstHitCountArt: Int = 0
    @AppStorage("gareiBonusScreenCount1Memory1") var bonusScreenCount1: Int = 0
    @AppStorage("gareiBonusScreenCount2Memory1") var bonusScreenCount2: Int = 0
    @AppStorage("gareiBonusScreenCount3Memory1") var bonusScreenCount3: Int = 0
    @AppStorage("gareiBonusScreenCount4Memory1") var bonusScreenCount4: Int = 0
    @AppStorage("gareiBonusScreenCountSumMemory1") var bonusScreenCountSum: Int = 0
    @AppStorage("gareiArtScreenCount1Memory1") var artScreenCount1: Int = 0
    @AppStorage("gareiArtScreenCount2Memory1") var artScreenCount2: Int = 0
    @AppStorage("gareiArtScreenCount3Memory1") var artScreenCount3: Int = 0
    @AppStorage("gareiArtScreenCount4Memory1") var artScreenCount4: Int = 0
    @AppStorage("gareiArtScreenCountSumMemory1") var artScreenCountSum: Int = 0
    @AppStorage("gareiMemoMemory1") var memo = ""
    @AppStorage("gareiDateMemory1") var dateDouble = 0.0
}


class GareiMemory2: ObservableObject {
    @AppStorage("gareiKoyakuCountSuikaMemory2") var koyakuCountSuika: Int = 0
    @AppStorage("gareiKoyakuCountJakuCherryMemory2") var koyakuCountJakuCherry: Int = 0
    @AppStorage("gareiKoyakuCountKyoCherryMemory2") var koyakuCountKyoCherry: Int = 0
    @AppStorage("gareiKoyakuCountJakuChanceMemory2") var koyakuCountJakuChance: Int = 0
    @AppStorage("gareiKoyakuCountKyoChanceMemory2") var koyakuCountKyoChance: Int = 0
    @AppStorage("gareiChofukuCountJakuCherryMemory2") var chofukuCountJakuCherry: Int = 0
    @AppStorage("gareiChofukuCountKyoCherryMemory2") var chofukuCountKyoCherry: Int = 0
    @AppStorage("gareiGameNumberStartMemory2") var gameNumberStart: Int = 0
    @AppStorage("gareiGameNumberCurrentMemory2") var gameNumberCurrent: Int = 0
    @AppStorage("gareiGameNumberPlayMemory2") var gameNumberPlay: Int = 0
    @AppStorage("gareiCzRangekiCountMissMemory2") var czRangekiCountMiss: Int = 0
    @AppStorage("gareiCzRangekiCountHitMemory2") var czRangekiCountHit: Int = 0
    @AppStorage("gareiCzRangekiCountSumMemory2") var czRangekiCountSum: Int = 0
    @AppStorage("gareiNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("gareiFirstHitCountCzMemory2") var firstHitCountCz: Int = 0
    @AppStorage("gareiFirstHitCountBigMemory2") var firstHitCountBig: Int = 0
    @AppStorage("gareiFirstHitCountRegMemory2") var firstHitCountReg: Int = 0
    @AppStorage("gareiFirstHitCountArtMemory2") var firstHitCountArt: Int = 0
    @AppStorage("gareiBonusScreenCount1Memory2") var bonusScreenCount1: Int = 0
    @AppStorage("gareiBonusScreenCount2Memory2") var bonusScreenCount2: Int = 0
    @AppStorage("gareiBonusScreenCount3Memory2") var bonusScreenCount3: Int = 0
    @AppStorage("gareiBonusScreenCount4Memory2") var bonusScreenCount4: Int = 0
    @AppStorage("gareiBonusScreenCountSumMemory2") var bonusScreenCountSum: Int = 0
    @AppStorage("gareiArtScreenCount1Memory2") var artScreenCount1: Int = 0
    @AppStorage("gareiArtScreenCount2Memory2") var artScreenCount2: Int = 0
    @AppStorage("gareiArtScreenCount3Memory2") var artScreenCount3: Int = 0
    @AppStorage("gareiArtScreenCount4Memory2") var artScreenCount4: Int = 0
    @AppStorage("gareiArtScreenCountSumMemory2") var artScreenCountSum: Int = 0
    @AppStorage("gareiMemoMemory2") var memo = ""
    @AppStorage("gareiDateMemory2") var dateDouble = 0.0
}


class GareiMemory3: ObservableObject {
    @AppStorage("gareiKoyakuCountSuikaMemory3") var koyakuCountSuika: Int = 0
    @AppStorage("gareiKoyakuCountJakuCherryMemory3") var koyakuCountJakuCherry: Int = 0
    @AppStorage("gareiKoyakuCountKyoCherryMemory3") var koyakuCountKyoCherry: Int = 0
    @AppStorage("gareiKoyakuCountJakuChanceMemory3") var koyakuCountJakuChance: Int = 0
    @AppStorage("gareiKoyakuCountKyoChanceMemory3") var koyakuCountKyoChance: Int = 0
    @AppStorage("gareiChofukuCountJakuCherryMemory3") var chofukuCountJakuCherry: Int = 0
    @AppStorage("gareiChofukuCountKyoCherryMemory3") var chofukuCountKyoCherry: Int = 0
    @AppStorage("gareiGameNumberStartMemory3") var gameNumberStart: Int = 0
    @AppStorage("gareiGameNumberCurrentMemory3") var gameNumberCurrent: Int = 0
    @AppStorage("gareiGameNumberPlayMemory3") var gameNumberPlay: Int = 0
    @AppStorage("gareiCzRangekiCountMissMemory3") var czRangekiCountMiss: Int = 0
    @AppStorage("gareiCzRangekiCountHitMemory3") var czRangekiCountHit: Int = 0
    @AppStorage("gareiCzRangekiCountSumMemory3") var czRangekiCountSum: Int = 0
    @AppStorage("gareiNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("gareiFirstHitCountCzMemory3") var firstHitCountCz: Int = 0
    @AppStorage("gareiFirstHitCountBigMemory3") var firstHitCountBig: Int = 0
    @AppStorage("gareiFirstHitCountRegMemory3") var firstHitCountReg: Int = 0
    @AppStorage("gareiFirstHitCountArtMemory3") var firstHitCountArt: Int = 0
    @AppStorage("gareiBonusScreenCount1Memory3") var bonusScreenCount1: Int = 0
    @AppStorage("gareiBonusScreenCount2Memory3") var bonusScreenCount2: Int = 0
    @AppStorage("gareiBonusScreenCount3Memory3") var bonusScreenCount3: Int = 0
    @AppStorage("gareiBonusScreenCount4Memory3") var bonusScreenCount4: Int = 0
    @AppStorage("gareiBonusScreenCountSumMemory3") var bonusScreenCountSum: Int = 0
    @AppStorage("gareiArtScreenCount1Memory3") var artScreenCount1: Int = 0
    @AppStorage("gareiArtScreenCount2Memory3") var artScreenCount2: Int = 0
    @AppStorage("gareiArtScreenCount3Memory3") var artScreenCount3: Int = 0
    @AppStorage("gareiArtScreenCount4Memory3") var artScreenCount4: Int = 0
    @AppStorage("gareiArtScreenCountSumMemory3") var artScreenCountSum: Int = 0
    @AppStorage("gareiMemoMemory3") var memo = ""
    @AppStorage("gareiDateMemory3") var dateDouble = 0.0
}
