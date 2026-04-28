//
//  jormungandClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/04/04.
//

import Foundation
import SwiftUI
import Combine

class Jormungand: ObservableObject {
    // ---------
    // 通常時
    // ---------
    // レア役からのCZ
    let ratioRareCzNormalChance: [Double] = [10.16,11.33,14.06,16.02,16.41,16.80]
    let ratioRareCzNormalKyoCherry: [Double] = [25,26.95,32.03,34.38,34.77,35.16]
    let ratioRareCzHighChance: [Double] = [33.59,36.72,46.09,50,50,50]
    let ratioRareCzHighKyoCherry: [Double] = [66.80,68.36,75,80.08,80.08,80.08,]
    @AppStorage("jormungandRareCzCountChance") var rareCzCountChance: Int = 0
    @AppStorage("jormungandRareCzCountChanceHit") var rareCzCountChanceHit: Int = 0
    @AppStorage("jormungandRareCzCountKyoCherry") var rareCzCountKyoCherry: Int = 0
    @AppStorage("jormungandRareCzCountKyoCherryHit") var rareCzCountKyoCherryHit: Int = 0
    
    // 天井短縮
    let ratioTenjoCut: [Double] = [33.59,40.23,45.31,49.22,49.61,50]
    @AppStorage("jormungandTenjoCountMiss") var tenjoCountMiss: Int = 0
    @AppStorage("jormungandTenjoCountHit") var tenjoCountHit: Int = 0
    @AppStorage("jormungandTenjoCountSum") var tenjoCountSum: Int = 0
    
    func tenjoSumFunc() {
        tenjoCountSum = tenjoCountMiss + tenjoCountHit
    }
    
    // 示唆カード
    @AppStorage("jormungandCardCountDefault") var cardCountDefault: Int = 0
    @AppStorage("jormungandCardCountKisu") var cardCountKisu: Int = 0
    @AppStorage("jormungandCardCountGusu") var cardCountGusu: Int = 0
    @AppStorage("jormungandCardCountHighJaku") var cardCountHighJaku: Int = 0
    @AppStorage("jormungandCardCountModeCJaku") var cardCountModeCJaku: Int = 0
    @AppStorage("jormungandCardCountHighKyo") var cardCountHighKyo: Int = 0
    @AppStorage("jormungandCardCountModeCKyo") var cardCountModeCKyo: Int = 0
    @AppStorage("jormungandCardCountGusuFix") var cardCountGusuFix: Int = 0
    @AppStorage("jormungandCardCountModeD") var cardCountModeD: Int = 0
    @AppStorage("jormungandCardCountHorobi") var cardCountHorobi: Int = 0
    @AppStorage("jormungandCardCountSum") var cardCountSum: Int = 0
    
    func cardSumFunc() {
        cardCountSum = countSum(
            cardCountDefault,
            cardCountKisu,
            cardCountGusu,
            cardCountHighJaku,
//            cardCountModeCJaku,
            cardCountHighKyo,
//            cardCountModeCKyo,
            cardCountGusuFix,
//            cardCountModeD,
//            cardCountHorobi,
        )
    }
    
    func resetNormal() {
        rareCzCountChance = 0
        rareCzCountChanceHit = 0
        rareCzCountKyoCherry = 0
        rareCzCountKyoCherryHit = 0
        tenjoCountMiss = 0
        tenjoCountHit = 0
        tenjoCountSum = 0
        cardCountDefault = 0
        cardCountKisu = 0
        cardCountGusu = 0
        cardCountHighJaku = 0
        cardCountModeCJaku = 0
        cardCountHighKyo = 0
        cardCountModeCKyo = 0
        cardCountGusuFix = 0
        cardCountModeD = 0
        cardCountHorobi = 0
        cardCountSum = 0
        minusCheck = false
        
        rareCzCountJakuRare = 0
        rareCzCountJakuRareHit = 0
    }
    
    // ----------
    // CZ
    // ----------
    let ratioFirstHitCz: [Double] = [194.2,188.6,175.7,169.4,167.8,167.2]
    @AppStorage("jormungandNormalGame") var normalGame: Int = 0
    @AppStorage("jormungandFirstHitCountCz") var firstHitCountCz: Int = 0
    
    func resetCz() {
        normalGame = 0
        firstHitCountCz = 0
        minusCheck = false
    }
    
    // -----------
    // 初当り
    // -----------
    let ratioFirstHitAt: [Double] = [333.8,323.3,305.4,291.6,291.1,290.1]
    @AppStorage("jormungandFirstHitCountAt") var firstHitCountAt: Int = 0
    func resetFirstHit() {
        normalGame = 0
        firstHitCountCz = 0
        firstHitCountAt = 0
        minusCheck = false
    }
    
    // -------
    // 終了画面
    // -------
    @AppStorage("jormungandScreenCountDefault") var screenCountDefault: Int = 0
    @AppStorage("jormungandScreenCountHigh") var screenCountHigh: Int = 0
    @AppStorage("jormungandScreenCountKisu") var screenCountKisu: Int = 0
    @AppStorage("jormungandScreenCountGusu") var screenCountGusu: Int = 0
    @AppStorage("jormungandScreenCountNegate2") var screenCountNegate2: Int = 0
    @AppStorage("jormungandScreenCountGusuFix") var screenCountGusuFix: Int = 0
    @AppStorage("jormungandScreenCountOver4") var screenCountOver4: Int = 0
    @AppStorage("jormungandScreenCountOver6") var screenCountOver6: Int = 0
    @AppStorage("jormungandScreenCountSum") var screenCountSum: Int = 0
    
    func screenSumFunc() {
        screenCountSum = countSum(
            screenCountDefault,
            screenCountHigh,
            screenCountKisu,
            screenCountGusu,
            screenCountNegate2,
            screenCountGusuFix,
            screenCountOver4,
            screenCountOver6,
        )
    }
    
    func resetScreen() {
        screenCountDefault = 0
        screenCountHigh = 0
        screenCountKisu = 0
        screenCountGusu = 0
        screenCountNegate2 = 0
        screenCountGusuFix = 0
        screenCountOver4 = 0
        screenCountOver6 = 0
        screenCountSum = 0
        minusCheck = false
    }
    
    // ---------
    // REG
    // ---------
    @AppStorage("jormungandCharaCountKisu") var charaCountKisu: Int = 0
    @AppStorage("jormungandCharaCountGusu") var charaCountGusu: Int = 0
    @AppStorage("jormungandCharaCountHigh") var charaCountHigh: Int = 0
    @AppStorage("jormungandCharaCountOver2") var charaCountOver2: Int = 0
    @AppStorage("jormungandCharaCountOver4") var charaCountOver4: Int = 0
    @AppStorage("jormungandCharaCountOver6") var charaCountOver6: Int = 0
    @AppStorage("jormungandCharaCountSum") var charaCountSum: Int = 0
    
    func charaSumFunc() {
        charaCountSum = countSum(
            charaCountKisu,
            charaCountGusu,
            charaCountHigh,
            charaCountOver2,
            charaCountOver4,
            charaCountOver6,
        )
        
        chara3CountSum = countSum(
            chara3CountKisu,
            chara3CountGusu,
            chara3CountHigh,
            chara3CountOver2,
            chara3CountOver4,
            chara3CountOver6,
        )
    }
    
    func resetReg() {
        charaCountKisu = 0
        charaCountGusu = 0
        charaCountHigh = 0
        charaCountOver2 = 0
        charaCountOver4 = 0
        charaCountOver6 = 0
        minusCheck = false
        
        chara3CountKisu = 0
        chara3CountGusu = 0
        chara3CountHigh = 0
        chara3CountOver2 = 0
        chara3CountOver4 = 0
        chara3CountOver6 = 0
        chara3CountSum = 0
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "ヨルムンガンド"
    @AppStorage("jormungandMinusCheck") var minusCheck: Bool = false
    @AppStorage("jormungandSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetCz()
        resetFirstHit()
        resetNormal()
        resetScreen()
        resetReg()
    }
    
    // --------
    // ver3.24.1
    // --------
    let ratioCharaKisu: [Double] = [50,43.75,54.69,42.19,56.25,41.41]
    let ratioCharaGusu: [Double] = [44.53,50,37.5,50,35.16,50]
    let ratioCharaHigh: [Double] = [5.47,6.25,7.81,7.81,8.59,8.59]
    let ratioCharaOver2: [Double] = [0,0,0,0,0,0]
    let ratioCharaOver4: [Double] = [0,0,0,0,0,0]
    let ratioCharaOver6: [Double] = [0,0,0,0,0,0]
    let ratioChara3Kisu: [Double] = [50,39.06,50,35.94,50,34.66]
    let ratioChara3Gusu: [Double] = [44.53,50,37.5,50,35.16,50]
    let ratioChara3High: [Double] = [5.47,6.25,7.81,7.81,8.59,8.59]
    let ratioChara3Over2: [Double] = [0,4.69,4.69,4.69,4.69,4.69,]
    let ratioChara3Over4: [Double] = [0,0,0,1.56,1.56,1.56,]
    let ratioChara3Over6: [Double] = [0,0,0,0,0,0.39]
    @AppStorage("jormungandChara3CountKisu") var chara3CountKisu: Int = 0
    @AppStorage("jormungandChara3CountGusu") var chara3CountGusu: Int = 0
    @AppStorage("jormungandChara3CountHigh") var chara3CountHigh: Int = 0
    @AppStorage("jormungandChara3CountOver2") var chara3CountOver2: Int = 0
    @AppStorage("jormungandChara3CountOver4") var chara3CountOver4: Int = 0
    @AppStorage("jormungandChara3CountOver6") var chara3CountOver6: Int = 0
    @AppStorage("jormungandChara3CountSum") var chara3CountSum: Int = 0
    
    // 弱レア役からのCZ
    let ratioRareCzHighJakuRare: [Double] = [5.1,5.9,8.2,10.2,10.2,10.2]
    @AppStorage("jormungandRareCzCountJakuRare") var rareCzCountJakuRare: Int = 0
    @AppStorage("jormungandRareCzCountJakuRareHit") var rareCzCountJakuRareHit: Int = 0
}


class JormungandMemory1: ObservableObject {
    @AppStorage("jormungandRareCzCountChanceMemory1") var rareCzCountChance: Int = 0
    @AppStorage("jormungandRareCzCountChanceHitMemory1") var rareCzCountChanceHit: Int = 0
    @AppStorage("jormungandRareCzCountKyoCherryMemory1") var rareCzCountKyoCherry: Int = 0
    @AppStorage("jormungandRareCzCountKyoCherryHitMemory1") var rareCzCountKyoCherryHit: Int = 0
    @AppStorage("jormungandTenjoCountMissMemory1") var tenjoCountMiss: Int = 0
    @AppStorage("jormungandTenjoCountHitMemory1") var tenjoCountHit: Int = 0
    @AppStorage("jormungandTenjoCountSumMemory1") var tenjoCountSum: Int = 0
    @AppStorage("jormungandCardCountDefaultMemory1") var cardCountDefault: Int = 0
    @AppStorage("jormungandCardCountKisuMemory1") var cardCountKisu: Int = 0
    @AppStorage("jormungandCardCountGusuMemory1") var cardCountGusu: Int = 0
    @AppStorage("jormungandCardCountHighJakuMemory1") var cardCountHighJaku: Int = 0
    @AppStorage("jormungandCardCountModeCJakuMemory1") var cardCountModeCJaku: Int = 0
    @AppStorage("jormungandCardCountHighKyoMemory1") var cardCountHighKyo: Int = 0
    @AppStorage("jormungandCardCountModeCKyoMemory1") var cardCountModeCKyo: Int = 0
    @AppStorage("jormungandCardCountGusuFixMemory1") var cardCountGusuFix: Int = 0
    @AppStorage("jormungandCardCountModeDMemory1") var cardCountModeD: Int = 0
    @AppStorage("jormungandCardCountHorobiMemory1") var cardCountHorobi: Int = 0
    @AppStorage("jormungandCardCountSumMemory1") var cardCountSum: Int = 0
    @AppStorage("jormungandNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("jormungandFirstHitCountCzMemory1") var firstHitCountCz: Int = 0
    @AppStorage("jormungandFirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("jormungandScreenCountDefaultMemory1") var screenCountDefault: Int = 0
    @AppStorage("jormungandScreenCountHighMemory1") var screenCountHigh: Int = 0
    @AppStorage("jormungandScreenCountKisuMemory1") var screenCountKisu: Int = 0
    @AppStorage("jormungandScreenCountGusuMemory1") var screenCountGusu: Int = 0
    @AppStorage("jormungandScreenCountNegate2Memory1") var screenCountNegate2: Int = 0
    @AppStorage("jormungandScreenCountGusuFixMemory1") var screenCountGusuFix: Int = 0
    @AppStorage("jormungandScreenCountOver4Memory1") var screenCountOver4: Int = 0
    @AppStorage("jormungandScreenCountOver6Memory1") var screenCountOver6: Int = 0
    @AppStorage("jormungandScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("jormungandCharaCountKisuMemory1") var charaCountKisu: Int = 0
    @AppStorage("jormungandCharaCountGusuMemory1") var charaCountGusu: Int = 0
    @AppStorage("jormungandCharaCountHighMemory1") var charaCountHigh: Int = 0
    @AppStorage("jormungandCharaCountOver2Memory1") var charaCountOver2: Int = 0
    @AppStorage("jormungandCharaCountOver4Memory1") var charaCountOver4: Int = 0
    @AppStorage("jormungandCharaCountOver6Memory1") var charaCountOver6: Int = 0
    @AppStorage("jormungandCharaCountSumMemory1") var charaCountSum: Int = 0
    @AppStorage("jormungandMemoMemory1") var memo = ""
    @AppStorage("jormungandDateMemory1") var dateDouble = 0.0
    
    // --------
    // ver3.24.1
    // --------
    @AppStorage("jormungandChara3CountKisuMemory1") var chara3CountKisu: Int = 0
    @AppStorage("jormungandChara3CountGusuMemory1") var chara3CountGusu: Int = 0
    @AppStorage("jormungandChara3CountHighMemory1") var chara3CountHigh: Int = 0
    @AppStorage("jormungandChara3CountOver2Memory1") var chara3CountOver2: Int = 0
    @AppStorage("jormungandChara3CountOver4Memory1") var chara3CountOver4: Int = 0
    @AppStorage("jormungandChara3CountOver6Memory1") var chara3CountOver6: Int = 0
    @AppStorage("jormungandChara3CountSumMemory1") var chara3CountSum: Int = 0
    @AppStorage("jormungandRareCzCountJakuRareMemory1") var rareCzCountJakuRare: Int = 0
    @AppStorage("jormungandRareCzCountJakuRareHitMemory1") var rareCzCountJakuRareHit: Int = 0
}


class JormungandMemory2: ObservableObject {
    @AppStorage("jormungandRareCzCountChanceMemory2") var rareCzCountChance: Int = 0
    @AppStorage("jormungandRareCzCountChanceHitMemory2") var rareCzCountChanceHit: Int = 0
    @AppStorage("jormungandRareCzCountKyoCherryMemory2") var rareCzCountKyoCherry: Int = 0
    @AppStorage("jormungandRareCzCountKyoCherryHitMemory2") var rareCzCountKyoCherryHit: Int = 0
    @AppStorage("jormungandTenjoCountMissMemory2") var tenjoCountMiss: Int = 0
    @AppStorage("jormungandTenjoCountHitMemory2") var tenjoCountHit: Int = 0
    @AppStorage("jormungandTenjoCountSumMemory2") var tenjoCountSum: Int = 0
    @AppStorage("jormungandCardCountDefaultMemory2") var cardCountDefault: Int = 0
    @AppStorage("jormungandCardCountKisuMemory2") var cardCountKisu: Int = 0
    @AppStorage("jormungandCardCountGusuMemory2") var cardCountGusu: Int = 0
    @AppStorage("jormungandCardCountHighJakuMemory2") var cardCountHighJaku: Int = 0
    @AppStorage("jormungandCardCountModeCJakuMemory2") var cardCountModeCJaku: Int = 0
    @AppStorage("jormungandCardCountHighKyoMemory2") var cardCountHighKyo: Int = 0
    @AppStorage("jormungandCardCountModeCKyoMemory2") var cardCountModeCKyo: Int = 0
    @AppStorage("jormungandCardCountGusuFixMemory2") var cardCountGusuFix: Int = 0
    @AppStorage("jormungandCardCountModeDMemory2") var cardCountModeD: Int = 0
    @AppStorage("jormungandCardCountHorobiMemory2") var cardCountHorobi: Int = 0
    @AppStorage("jormungandCardCountSumMemory2") var cardCountSum: Int = 0
    @AppStorage("jormungandNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("jormungandFirstHitCountCzMemory2") var firstHitCountCz: Int = 0
    @AppStorage("jormungandFirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("jormungandScreenCountDefaultMemory2") var screenCountDefault: Int = 0
    @AppStorage("jormungandScreenCountHighMemory2") var screenCountHigh: Int = 0
    @AppStorage("jormungandScreenCountKisuMemory2") var screenCountKisu: Int = 0
    @AppStorage("jormungandScreenCountGusuMemory2") var screenCountGusu: Int = 0
    @AppStorage("jormungandScreenCountNegate2Memory2") var screenCountNegate2: Int = 0
    @AppStorage("jormungandScreenCountGusuFixMemory2") var screenCountGusuFix: Int = 0
    @AppStorage("jormungandScreenCountOver4Memory2") var screenCountOver4: Int = 0
    @AppStorage("jormungandScreenCountOver6Memory2") var screenCountOver6: Int = 0
    @AppStorage("jormungandScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("jormungandCharaCountKisuMemory2") var charaCountKisu: Int = 0
    @AppStorage("jormungandCharaCountGusuMemory2") var charaCountGusu: Int = 0
    @AppStorage("jormungandCharaCountHighMemory2") var charaCountHigh: Int = 0
    @AppStorage("jormungandCharaCountOver2Memory2") var charaCountOver2: Int = 0
    @AppStorage("jormungandCharaCountOver4Memory2") var charaCountOver4: Int = 0
    @AppStorage("jormungandCharaCountOver6Memory2") var charaCountOver6: Int = 0
    @AppStorage("jormungandCharaCountSumMemory2") var charaCountSum: Int = 0
    @AppStorage("jormungandMemoMemory2") var memo = ""
    @AppStorage("jormungandDateMemory2") var dateDouble = 0.0
    
    // --------
    // ver3.24.1
    // --------
    @AppStorage("jormungandChara3CountKisuMemory2") var chara3CountKisu: Int = 0
    @AppStorage("jormungandChara3CountGusuMemory2") var chara3CountGusu: Int = 0
    @AppStorage("jormungandChara3CountHighMemory2") var chara3CountHigh: Int = 0
    @AppStorage("jormungandChara3CountOver2Memory2") var chara3CountOver2: Int = 0
    @AppStorage("jormungandChara3CountOver4Memory2") var chara3CountOver4: Int = 0
    @AppStorage("jormungandChara3CountOver6Memory2") var chara3CountOver6: Int = 0
    @AppStorage("jormungandChara3CountSumMemory2") var chara3CountSum: Int = 0
    @AppStorage("jormungandRareCzCountJakuRareMemory2") var rareCzCountJakuRare: Int = 0
    @AppStorage("jormungandRareCzCountJakuRareHitMemory2") var rareCzCountJakuRareHit: Int = 0
}


class JormungandMemory3: ObservableObject {
    @AppStorage("jormungandRareCzCountChanceMemory3") var rareCzCountChance: Int = 0
    @AppStorage("jormungandRareCzCountChanceHitMemory3") var rareCzCountChanceHit: Int = 0
    @AppStorage("jormungandRareCzCountKyoCherryMemory3") var rareCzCountKyoCherry: Int = 0
    @AppStorage("jormungandRareCzCountKyoCherryHitMemory3") var rareCzCountKyoCherryHit: Int = 0
    @AppStorage("jormungandTenjoCountMissMemory3") var tenjoCountMiss: Int = 0
    @AppStorage("jormungandTenjoCountHitMemory3") var tenjoCountHit: Int = 0
    @AppStorage("jormungandTenjoCountSumMemory3") var tenjoCountSum: Int = 0
    @AppStorage("jormungandCardCountDefaultMemory3") var cardCountDefault: Int = 0
    @AppStorage("jormungandCardCountKisuMemory3") var cardCountKisu: Int = 0
    @AppStorage("jormungandCardCountGusuMemory3") var cardCountGusu: Int = 0
    @AppStorage("jormungandCardCountHighJakuMemory3") var cardCountHighJaku: Int = 0
    @AppStorage("jormungandCardCountModeCJakuMemory3") var cardCountModeCJaku: Int = 0
    @AppStorage("jormungandCardCountHighKyoMemory3") var cardCountHighKyo: Int = 0
    @AppStorage("jormungandCardCountModeCKyoMemory3") var cardCountModeCKyo: Int = 0
    @AppStorage("jormungandCardCountGusuFixMemory3") var cardCountGusuFix: Int = 0
    @AppStorage("jormungandCardCountModeDMemory3") var cardCountModeD: Int = 0
    @AppStorage("jormungandCardCountHorobiMemory3") var cardCountHorobi: Int = 0
    @AppStorage("jormungandCardCountSumMemory3") var cardCountSum: Int = 0
    @AppStorage("jormungandNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("jormungandFirstHitCountCzMemory3") var firstHitCountCz: Int = 0
    @AppStorage("jormungandFirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("jormungandScreenCountDefaultMemory3") var screenCountDefault: Int = 0
    @AppStorage("jormungandScreenCountHighMemory3") var screenCountHigh: Int = 0
    @AppStorage("jormungandScreenCountKisuMemory3") var screenCountKisu: Int = 0
    @AppStorage("jormungandScreenCountGusuMemory3") var screenCountGusu: Int = 0
    @AppStorage("jormungandScreenCountNegate2Memory3") var screenCountNegate2: Int = 0
    @AppStorage("jormungandScreenCountGusuFixMemory3") var screenCountGusuFix: Int = 0
    @AppStorage("jormungandScreenCountOver4Memory3") var screenCountOver4: Int = 0
    @AppStorage("jormungandScreenCountOver6Memory3") var screenCountOver6: Int = 0
    @AppStorage("jormungandScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("jormungandCharaCountKisuMemory3") var charaCountKisu: Int = 0
    @AppStorage("jormungandCharaCountGusuMemory3") var charaCountGusu: Int = 0
    @AppStorage("jormungandCharaCountHighMemory3") var charaCountHigh: Int = 0
    @AppStorage("jormungandCharaCountOver2Memory3") var charaCountOver2: Int = 0
    @AppStorage("jormungandCharaCountOver4Memory3") var charaCountOver4: Int = 0
    @AppStorage("jormungandCharaCountOver6Memory3") var charaCountOver6: Int = 0
    @AppStorage("jormungandCharaCountSumMemory3") var charaCountSum: Int = 0
    @AppStorage("jormungandMemoMemory3") var memo = ""
    @AppStorage("jormungandDateMemory3") var dateDouble = 0.0
    
    // --------
    // ver3.24.1
    // --------
    @AppStorage("jormungandChara3CountKisuMemory3") var chara3CountKisu: Int = 0
    @AppStorage("jormungandChara3CountGusuMemory3") var chara3CountGusu: Int = 0
    @AppStorage("jormungandChara3CountHighMemory3") var chara3CountHigh: Int = 0
    @AppStorage("jormungandChara3CountOver2Memory3") var chara3CountOver2: Int = 0
    @AppStorage("jormungandChara3CountOver4Memory3") var chara3CountOver4: Int = 0
    @AppStorage("jormungandChara3CountOver6Memory3") var chara3CountOver6: Int = 0
    @AppStorage("jormungandChara3CountSumMemory3") var chara3CountSum: Int = 0
    @AppStorage("jormungandRareCzCountJakuRareMemory3") var rareCzCountJakuRare: Int = 0
    @AppStorage("jormungandRareCzCountJakuRareHitMemory3") var rareCzCountJakuRareHit: Int = 0
}
