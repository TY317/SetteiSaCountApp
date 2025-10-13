//
//  AzurLaneClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/24.
//

import Foundation
import SwiftUI

class AzurLane: ObservableObject {
    // /////////////
    // 通常時
    // /////////////
    let ratioJakuCherry: [Double] = [79,78,77.1,75.3,74.5,72]
    let ratioJakuSuika: [Double] = [104,102.4,100.8,99.3,97.8,96.4]
//    let ratioJakuRareSum: [Double] = [44.9,44.3,43.7,42.8,42.3,41.2]
    let ratioJakuRareSum: [Double] = [14.8,14.6,14.2,13.8,13.5,13.0]
    @AppStorage("azurLaneKoyakuCountJakuCherry") var koyakuCountJakuCherry: Int = 0
    @AppStorage("azurLaneKoyakuCountJakuSuika") var koyakuCountJakuSuika: Int = 0
    @AppStorage("azurLaneKoyakuCountSum") var koyakuCountSum: Int = 0
    @AppStorage("azurLaneGameNumberStart") var gameNumberStart: Int = 0
    @AppStorage("azurLaneGameNumberCurrent") var gameNumberCurrent: Int = 0
    @AppStorage("azurLaneGameNumberPlay") var gameNumberPlay: Int = 0
    
    
    
    func koyakuSumFunc() {
        koyakuCountSum = countSum(
            koyakuCountJakuCherry,
            koyakuCountJakuSuika,
            koyakuCountCommonBell,
        )
    }
    
    func resetNormal() {
        koyakuCountJakuCherry = 0
        koyakuCountJakuSuika = 0
        koyakuCountSum = 0
        gameNumberStart = 0
        gameNumberCurrent = 0
        gameNumberPlay = 0
        minusCheck = false
        koyakuCountCommonBell = 0
    }
    
    // ボーナス当選率
    let ratioChofukuNormalAny: [Double] = [0.003,0.003,0.004,0.004,0.004,0.005]
    let ratioChofukuNormalCherry: [Double] = [0.4,0.4,0.4,0.5,0.6,0.6]
    let ratioChofukuNormalSuika: [Double] = [2,2,2.2,2.4,2.6,2.8]
    let ratioChofukuNormalKyoCherryChance: [Double] = [20.4,20.5,21,21.8,22.4,23]
    let ratioChofukuNormalKyoSuika: [Double] = [50]
    let ratioChofukuNormalAkashiSuccess: [Double] = [25,25.1,25.4,25.8,26.1,26.4]
    
    let ratioChofukuHighAny: [Double] = [0.006,0.006,0.007,0.008,0.009,0.010]
    let ratioChofukuHighCherry: [Double] = [0.8,0.8,0.9,1,1.1,1.2]
    let ratioChofukuHighSuika: [Double] = [20.3,20.4,20.7,21,21.3,21.6]
    let ratioChofukuHighKyoCherryChance: [Double] = [55.1,55.2,55.5,55.9,56.2,56.5]
    let ratioChofukuHighKyoSuika: [Double] = [100]
    let ratioChofukuHighAkashiSuccess: [Double] = [25,25.1,25.4,25.8,26.1,26.4]
    
    let ratioChofukuChoHighAny: [Double] = [0.78]
    let ratioChofukuChoHighCherry: [Double] = [3.1,3.2,3.3,3.4,3.5,3.7]
    let ratioChofukuChoHighSuika: [Double] = [40.3,40.4,41,41.7,42.3,43]
    let ratioChofukuChoHighKyoCherryChance: [Double] = [80.1,80.2,80.6,81.2,81.7,82.2]
    let ratioChofukuChoHighKyoSuika: [Double] = [100]
    let ratioChofukuChoHighAkashiSuccess: [Double] = [25,25.1,25.4,25.8,26.1,26.4]
    
    // //////////////
    // 初当り
    // //////////////
    let ratioBonus: [Double] = [167.4,166.5,164.3,161.3,158.9,156.0]
    let ratioAt: [Double] = [598.9,589.5,564.2,527.1,496.4,467.5]
    @AppStorage("azurLaneBonusCount") var bonusCount: Int = 0
    @AppStorage("azurLaneAtCount") var atCount: Int = 0
    @AppStorage("azurLaneGameNormalNumberStart") var gameNormalNumberStart: Int = 0
    @AppStorage("azurLaneGameNormalNumberCurrent") var gameNormalNumberCurrent: Int = 0
    @AppStorage("azurLaneGameNormalNumberPlay") var gameNormalNumberPlay: Int = 0
    
    
    func resetFirstHit() {
        bonusCount = 0
        atCount = 0
        gameNormalNumberStart = 0
        gameNormalNumberCurrent = 0
        gameNormalNumberPlay = 0
        minusCheck = false
        bonusCountWhite = 0
        bonusCountBlue = 0
    }
    
    // ////////////
    // 加賀バトル
    // ////////////
    @AppStorage("azurLaneKagaCountDefault") var kagaCountDefault: Int = 0
    @AppStorage("azurLaneKagaCountKisu") var kagaCountKisu: Int = 0
    @AppStorage("azurLaneKagaCountGusu") var kagaCountGusu: Int = 0
    @AppStorage("azurLaneKagaCount46sisa") var kagaCount46sisa: Int = 0
    @AppStorage("azurLaneKagaCount56sisa") var kagaCount56sisa: Int = 0
    @AppStorage("azurLaneKagaCountSum") var kagaCountSum: Int = 0
    
    func kagaSumFunc() {
        kagaCountSum = countSum(
            kagaCountDefault,
            kagaCountKisu,
            kagaCountGusu,
            kagaCount46sisa,
            kagaCount56sisa,
            kagaCountDefaultGusu,
        )
    }
    
    func resetKaga() {
        kagaCountDefault = 0
        kagaCountKisu = 0
        kagaCountGusu = 0
        kagaCount46sisa = 0
        kagaCount56sisa = 0
        kagaCountSum = 0
        minusCheck = false
        kagaCountDefaultGusu = 0
    }
    
    // /////////////
    // 終了画面
    // /////////////
    @AppStorage("azurLaneScreenCountDefault") var screenCountDefault: Int = 0
    @AppStorage("azurLaneScreenCountHighJaku") var screenCountHighJaku: Int = 0
    @AppStorage("azurLaneScreenCountHighKyo") var screenCountHighKyo: Int = 0
    @AppStorage("azurLaneScreenCountOver2") var screenCountOver2: Int = 0
    @AppStorage("azurLaneScreenCountOver4") var screenCountOver4: Int = 0
    @AppStorage("azurLaneScreenCountOver6") var screenCountOver6: Int = 0
    @AppStorage("azurLaneScreenCountRemain3Sisa") var screenCountRemain3Sisa: Int = 0
    @AppStorage("azurLaneScreenCountRemain5") var screenCountRemain5: Int = 0
    @AppStorage("azurLaneScreenCountRemain3") var screenCountRemain3: Int = 0
    @AppStorage("azurLaneScreenCountRemain1") var screenCountRemain1: Int = 0
    @AppStorage("azurLaneScreenCountSum") var screenCountSum: Int = 0
    
    func screenSumFunc() {
        screenCountSum = countSum(
            screenCountDefault,
            screenCountHighJaku,
            screenCountHighKyo,
            screenCountOver2,
            screenCountOver4,
            screenCountOver6,
            screenCountRemain3Sisa,
            screenCountRemain5,
            screenCountRemain3,
            screenCountRemain1,
            screenCountDefaultGusu,
        )
        
        screenCountSetteiSum = countSum(
            screenCountDefault,
            screenCountHighJaku,
            screenCountHighKyo,
            screenCountOver2,
            screenCountOver4,
            screenCountOver6,
            screenCountDefaultGusu,
        )
    }
    
    func resetScreen() {
        screenCountDefault = 0
        screenCountHighJaku = 0
        screenCountHighKyo = 0
        screenCountOver2 = 0
        screenCountOver4 = 0
        screenCountOver6 = 0
        screenCountRemain3Sisa = 0
        screenCountRemain5 = 0
        screenCountRemain3 = 0
        screenCountRemain1 = 0
        screenCountSum = 0
        minusCheck = false
        screenCountDefaultGusu = 0
        screenCountSetteiSum = 0
    }
    
    // ////////////
    // 高確スタート
    // ////////////
    let ratioStartNormal: [Double] = [59.7,59.6,58.9,57.8,56.9,56]
    let ratioStartHigh: [Double] = [39.9,40,40.6,41.6,42.4,43.2]
    let ratioStartChoHigh: [Double] = [0.4,0.4,0.5,0.6,0.7,0.8]
    @AppStorage("azurLaneStartModeCountNormal") var startModeCountNormal: Int = 0
    @AppStorage("azurLaneStartModeCountHigh") var startModeCountHigh: Int = 0
    @AppStorage("azurLaneStartModeCountChoHigh") var startModeCountChoHigh: Int = 0
    @AppStorage("azurLaneStartModeCountSum") var startModeCountSum: Int = 0
    
    func modeCountSumFunc() {
        startModeCountSum = countSum(
            startModeCountNormal,
            startModeCountHigh,
            startModeCountChoHigh,
        )
    }
    
    func resetKokakuStart() {
        startModeCountNormal = 0
        startModeCountHigh = 0
        startModeCountChoHigh = 0
        startModeCountSum = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "アズールレーン"
    @AppStorage("azurLaneMinusCheck") var minusCheck: Bool = false
    @AppStorage("azurLaneSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetFirstHit()
        resetKaga()
        resetScreen()
        resetKokakuStart()
        resetAkashi()
    }
    
    // //////////////
    // ver3.9.1で追加
    // //////////////
    // 白・青の詳細入力機能
    let ratioBonusWhite: [Double] = [175.4,174.7,173.6,172.0,170.5,168.7]
    let ratioBonusBlue: [Double] = [3665.8,3544.0,3056.6,2581.4,2331.5,2075.6]
    @AppStorage("azurLaneBonusCountWhite") var bonusCountWhite: Int = 0
    @AppStorage("azurLaneBonusCountBlue") var bonusCountBlue: Int = 0
    
    func bonusSumFunc() {
        bonusCount = bonusCountWhite + bonusCountBlue
    }
    
    // 明石チャレンジ
    let ratioAkashiKisu: [Double] = [72.0,18.0,72.0,18.0,72.0,18.0]
    let ratioAkashiGusu: [Double] = [18.0,72.0,18.0,72.0,18.0,72.0]
    let ratioAkashiLast: [Double] = [10.0,10.0,10.0,10.0,10.0,10.0]
    @AppStorage("azurLaneAkashiCountKisu") var akashiCountKisu: Int = 0
    @AppStorage("azurLaneAkashiCountGusu") var akashiCountGusu: Int = 0
    @AppStorage("azurLaneAkashiCountLast") var akashiCountLast: Int = 0
    @AppStorage("azurLaneAkashiCountSum") var akashiCountSum: Int = 0
    
    func akashiCountSumFunc() {
        akashiCountSum = akashiCountKisu + akashiCountGusu + akashiCountLast
    }
    
    func resetAkashi() {
        akashiCountKisu = 0
        akashiCountGusu = 0
        akashiCountLast = 0
        akashiCountSum = 0
        minusCheck = false
    }
    
    // ////////////
    // ver3.11.0で追加
    // ////////////
    // 共通ベル
    let ratioCommonBell: [Double] = [22.1,21.7,21.0,20.4,19.8,18.9]
    @AppStorage("azurLaneKoyakuCountCommonBell") var koyakuCountCommonBell: Int = 0
    // 加賀バトル
    let ratioKagaDefaultKisu: [Double] = [41.5,33.2,49.8,32.9,50.0,32.5]
    let ratioKagaDefaultGusu: [Double] = [41.5,49.8,33.2,49.3,32.3,48.8]
    let ratioKagaKisu: [Double] = [10,5,10,5,10,5]
    let ratioKagaGusu: [Double] = [5,10,5,10,5,10]
    let ratioKaga46Sisa: [Double] = [1,1,1,1.6,1.2,1.9]
    let ratioKaga56Sisa: [Double] = [1,1,1,1.2,1.5,1.9]
    @AppStorage("azurLaneKagaCountDefaultGusu") var kagaCountDefaultGusu: Int = 0
    // 終了画面
    let ratioScreenDefaultKisu: [Double] = [43.3,33.4,50.1,29.4,43.6,28.7]
    let ratioScreenDefaultGusu: [Double] = [43.3,50.1,33.4,44.1,29.1,43.0]
    let ratioScreenHighJaku: [Double] = [12.5,12.5,12.5,20,20.6,21.3]
    let ratioScreenHighKyo: [Double] = [1,1,1,3.2,3.5,3.6]
    let ratioScreenOver2: [Double] = [0,3,3,3,3,3]
    let ratioScreenOver4: [Double] = [0,0,0,0.2,0.2,0.2]
    let ratioScreenOver6: [Double] = [0,0,0,0,0,0.1]
    @AppStorage("azurLaneScreenCountDefaultGusu") var screenCountDefaultGusu: Int = 0
    @AppStorage("azurLaneScreenCountSetteiSum") var screenCountSetteiSum: Int = 0
}

// //// メモリー1
class AzurLaneMemory1: ObservableObject {
    @AppStorage("azurLaneKoyakuCountJakuCherryMemory1") var koyakuCountJakuCherry: Int = 0
    @AppStorage("azurLaneKoyakuCountJakuSuikaMemory1") var koyakuCountJakuSuika: Int = 0
    @AppStorage("azurLaneKoyakuCountSumMemory1") var koyakuCountSum: Int = 0
    @AppStorage("azurLaneGameNumberStartMemory1") var gameNumberStart: Int = 0
    @AppStorage("azurLaneGameNumberCurrentMemory1") var gameNumberCurrent: Int = 0
    @AppStorage("azurLaneGameNumberPlayMemory1") var gameNumberPlay: Int = 0
    @AppStorage("azurLaneBonusCountMemory1") var bonusCount: Int = 0
    @AppStorage("azurLaneAtCountMemory1") var atCount: Int = 0
    @AppStorage("azurLaneGameNormalNumberStartMemory1") var gameNormalNumberStart: Int = 0
    @AppStorage("azurLaneGameNormalNumberCurrentMemory1") var gameNormalNumberCurrent: Int = 0
    @AppStorage("azurLaneGameNormalNumberPlayMemory1") var gameNormalNumberPlay: Int = 0
    @AppStorage("azurLaneKagaCountDefaultMemory1") var kagaCountDefault: Int = 0
    @AppStorage("azurLaneKagaCountKisuMemory1") var kagaCountKisu: Int = 0
    @AppStorage("azurLaneKagaCountGusuMemory1") var kagaCountGusu: Int = 0
    @AppStorage("azurLaneKagaCount46sisaMemory1") var kagaCount46sisa: Int = 0
    @AppStorage("azurLaneKagaCount56sisaMemory1") var kagaCount56sisa: Int = 0
    @AppStorage("azurLaneKagaCountSumMemory1") var kagaCountSum: Int = 0
    @AppStorage("azurLaneScreenCountDefaultMemory1") var screenCountDefault: Int = 0
    @AppStorage("azurLaneScreenCountHighJakuMemory1") var screenCountHighJaku: Int = 0
    @AppStorage("azurLaneScreenCountHighKyoMemory1") var screenCountHighKyo: Int = 0
    @AppStorage("azurLaneScreenCountOver2Memory1") var screenCountOver2: Int = 0
    @AppStorage("azurLaneScreenCountOver4Memory1") var screenCountOver4: Int = 0
    @AppStorage("azurLaneScreenCountOver6Memory1") var screenCountOver6: Int = 0
    @AppStorage("azurLaneScreenCountRemain3SisaMemory1") var screenCountRemain3Sisa: Int = 0
    @AppStorage("azurLaneScreenCountRemain5Memory1") var screenCountRemain5: Int = 0
    @AppStorage("azurLaneScreenCountRemain3Memory1") var screenCountRemain3: Int = 0
    @AppStorage("azurLaneScreenCountRemain1Memory1") var screenCountRemain1: Int = 0
    @AppStorage("azurLaneScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("azurLaneStartModeCountNormalMemory1") var startModeCountNormal: Int = 0
    @AppStorage("azurLaneStartModeCountHighMemory1") var startModeCountHigh: Int = 0
    @AppStorage("azurLaneStartModeCountChoHighMemory1") var startModeCountChoHigh: Int = 0
    @AppStorage("azurLaneStartModeCountSumMemory1") var startModeCountSum: Int = 0
    @AppStorage("azurLaneMemoMemory1") var memo = ""
    @AppStorage("azurLaneDateMemory1") var dateDouble = 0.0
    
    // //////////////
    // ver3.9.1で追加
    // //////////////
    @AppStorage("azurLaneBonusCountWhiteMemory1") var bonusCountWhite: Int = 0
    @AppStorage("azurLaneBonusCountBlueMemory1") var bonusCountBlue: Int = 0
    @AppStorage("azurLaneAkashiCountKisuMemory1") var akashiCountKisu: Int = 0
    @AppStorage("azurLaneAkashiCountGusuMemory1") var akashiCountGusu: Int = 0
    @AppStorage("azurLaneAkashiCountLastMemory1") var akashiCountLast: Int = 0
    @AppStorage("azurLaneAkashiCountSumMemory1") var akashiCountSum: Int = 0
    
    // ////////////
    // ver3.11.0で追加
    // ////////////
    @AppStorage("azurLaneKoyakuCountCommonBellMemory1") var koyakuCountCommonBell: Int = 0
    @AppStorage("azurLaneKagaCountDefaultGusuMemory1") var kagaCountDefaultGusu: Int = 0
    @AppStorage("azurLaneScreenCountDefaultGusuMemory1") var screenCountDefaultGusu: Int = 0
    @AppStorage("azurLaneScreenCountSetteiSumMemory1") var screenCountSetteiSum: Int = 0
}

// //// メモリー2
class AzurLaneMemory2: ObservableObject {
    @AppStorage("azurLaneKoyakuCountJakuCherryMemory2") var koyakuCountJakuCherry: Int = 0
    @AppStorage("azurLaneKoyakuCountJakuSuikaMemory2") var koyakuCountJakuSuika: Int = 0
    @AppStorage("azurLaneKoyakuCountSumMemory2") var koyakuCountSum: Int = 0
    @AppStorage("azurLaneGameNumberStartMemory2") var gameNumberStart: Int = 0
    @AppStorage("azurLaneGameNumberCurrentMemory2") var gameNumberCurrent: Int = 0
    @AppStorage("azurLaneGameNumberPlayMemory2") var gameNumberPlay: Int = 0
    @AppStorage("azurLaneBonusCountMemory2") var bonusCount: Int = 0
    @AppStorage("azurLaneAtCountMemory2") var atCount: Int = 0
    @AppStorage("azurLaneGameNormalNumberStartMemory2") var gameNormalNumberStart: Int = 0
    @AppStorage("azurLaneGameNormalNumberCurrentMemory2") var gameNormalNumberCurrent: Int = 0
    @AppStorage("azurLaneGameNormalNumberPlayMemory2") var gameNormalNumberPlay: Int = 0
    @AppStorage("azurLaneKagaCountDefaultMemory2") var kagaCountDefault: Int = 0
    @AppStorage("azurLaneKagaCountKisuMemory2") var kagaCountKisu: Int = 0
    @AppStorage("azurLaneKagaCountGusuMemory2") var kagaCountGusu: Int = 0
    @AppStorage("azurLaneKagaCount46sisaMemory2") var kagaCount46sisa: Int = 0
    @AppStorage("azurLaneKagaCount56sisaMemory2") var kagaCount56sisa: Int = 0
    @AppStorage("azurLaneKagaCountSumMemory2") var kagaCountSum: Int = 0
    @AppStorage("azurLaneScreenCountDefaultMemory2") var screenCountDefault: Int = 0
    @AppStorage("azurLaneScreenCountHighJakuMemory2") var screenCountHighJaku: Int = 0
    @AppStorage("azurLaneScreenCountHighKyoMemory2") var screenCountHighKyo: Int = 0
    @AppStorage("azurLaneScreenCountOver2Memory2") var screenCountOver2: Int = 0
    @AppStorage("azurLaneScreenCountOver4Memory2") var screenCountOver4: Int = 0
    @AppStorage("azurLaneScreenCountOver6Memory2") var screenCountOver6: Int = 0
    @AppStorage("azurLaneScreenCountRemain3SisaMemory2") var screenCountRemain3Sisa: Int = 0
    @AppStorage("azurLaneScreenCountRemain5Memory2") var screenCountRemain5: Int = 0
    @AppStorage("azurLaneScreenCountRemain3Memory2") var screenCountRemain3: Int = 0
    @AppStorage("azurLaneScreenCountRemain1Memory2") var screenCountRemain1: Int = 0
    @AppStorage("azurLaneScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("azurLaneStartModeCountNormalMemory2") var startModeCountNormal: Int = 0
    @AppStorage("azurLaneStartModeCountHighMemory2") var startModeCountHigh: Int = 0
    @AppStorage("azurLaneStartModeCountChoHighMemory2") var startModeCountChoHigh: Int = 0
    @AppStorage("azurLaneStartModeCountSumMemory2") var startModeCountSum: Int = 0
    @AppStorage("azurLaneMemoMemory2") var memo = ""
    @AppStorage("azurLaneDateMemory2") var dateDouble = 0.0
    
    // //////////////
    // ver3.9.1で追加
    // //////////////
    @AppStorage("azurLaneBonusCountWhiteMemory2") var bonusCountWhite: Int = 0
    @AppStorage("azurLaneBonusCountBlueMemory2") var bonusCountBlue: Int = 0
    @AppStorage("azurLaneAkashiCountKisuMemory2") var akashiCountKisu: Int = 0
    @AppStorage("azurLaneAkashiCountGusuMemory2") var akashiCountGusu: Int = 0
    @AppStorage("azurLaneAkashiCountLastMemory2") var akashiCountLast: Int = 0
    @AppStorage("azurLaneAkashiCountSumMemory2") var akashiCountSum: Int = 0
    
    // ////////////
    // ver3.11.0で追加
    // ////////////
    @AppStorage("azurLaneKoyakuCountCommonBellMemory2") var koyakuCountCommonBell: Int = 0
    @AppStorage("azurLaneKagaCountDefaultGusuMemory2") var kagaCountDefaultGusu: Int = 0
    @AppStorage("azurLaneScreenCountDefaultGusuMemory2") var screenCountDefaultGusu: Int = 0
    @AppStorage("azurLaneScreenCountSetteiSumMemory2") var screenCountSetteiSum: Int = 0
}

// //// メモリー3
class AzurLaneMemory3: ObservableObject {
    @AppStorage("azurLaneKoyakuCountJakuCherryMemory3") var koyakuCountJakuCherry: Int = 0
    @AppStorage("azurLaneKoyakuCountJakuSuikaMemory3") var koyakuCountJakuSuika: Int = 0
    @AppStorage("azurLaneKoyakuCountSumMemory3") var koyakuCountSum: Int = 0
    @AppStorage("azurLaneGameNumberStartMemory3") var gameNumberStart: Int = 0
    @AppStorage("azurLaneGameNumberCurrentMemory3") var gameNumberCurrent: Int = 0
    @AppStorage("azurLaneGameNumberPlayMemory3") var gameNumberPlay: Int = 0
    @AppStorage("azurLaneBonusCountMemory3") var bonusCount: Int = 0
    @AppStorage("azurLaneAtCountMemory3") var atCount: Int = 0
    @AppStorage("azurLaneGameNormalNumberStartMemory3") var gameNormalNumberStart: Int = 0
    @AppStorage("azurLaneGameNormalNumberCurrentMemory3") var gameNormalNumberCurrent: Int = 0
    @AppStorage("azurLaneGameNormalNumberPlayMemory3") var gameNormalNumberPlay: Int = 0
    @AppStorage("azurLaneKagaCountDefaultMemory3") var kagaCountDefault: Int = 0
    @AppStorage("azurLaneKagaCountKisuMemory3") var kagaCountKisu: Int = 0
    @AppStorage("azurLaneKagaCountGusuMemory3") var kagaCountGusu: Int = 0
    @AppStorage("azurLaneKagaCount46sisaMemory3") var kagaCount46sisa: Int = 0
    @AppStorage("azurLaneKagaCount56sisaMemory3") var kagaCount56sisa: Int = 0
    @AppStorage("azurLaneKagaCountSumMemory3") var kagaCountSum: Int = 0
    @AppStorage("azurLaneScreenCountDefaultMemory3") var screenCountDefault: Int = 0
    @AppStorage("azurLaneScreenCountHighJakuMemory3") var screenCountHighJaku: Int = 0
    @AppStorage("azurLaneScreenCountHighKyoMemory3") var screenCountHighKyo: Int = 0
    @AppStorage("azurLaneScreenCountOver2Memory3") var screenCountOver2: Int = 0
    @AppStorage("azurLaneScreenCountOver4Memory3") var screenCountOver4: Int = 0
    @AppStorage("azurLaneScreenCountOver6Memory3") var screenCountOver6: Int = 0
    @AppStorage("azurLaneScreenCountRemain3SisaMemory3") var screenCountRemain3Sisa: Int = 0
    @AppStorage("azurLaneScreenCountRemain5Memory3") var screenCountRemain5: Int = 0
    @AppStorage("azurLaneScreenCountRemain3Memory3") var screenCountRemain3: Int = 0
    @AppStorage("azurLaneScreenCountRemain1Memory3") var screenCountRemain1: Int = 0
    @AppStorage("azurLaneScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("azurLaneStartModeCountNormalMemory3") var startModeCountNormal: Int = 0
    @AppStorage("azurLaneStartModeCountHighMemory3") var startModeCountHigh: Int = 0
    @AppStorage("azurLaneStartModeCountChoHighMemory3") var startModeCountChoHigh: Int = 0
    @AppStorage("azurLaneStartModeCountSumMemory3") var startModeCountSum: Int = 0
    @AppStorage("azurLaneMemoMemory3") var memo = ""
    @AppStorage("azurLaneDateMemory3") var dateDouble = 0.0
    
    // //////////////
    // ver3.9.1で追加
    // //////////////
    @AppStorage("azurLaneBonusCountWhiteMemory3") var bonusCountWhite: Int = 0
    @AppStorage("azurLaneBonusCountBlueMemory3") var bonusCountBlue: Int = 0
    @AppStorage("azurLaneAkashiCountKisuMemory3") var akashiCountKisu: Int = 0
    @AppStorage("azurLaneAkashiCountGusuMemory3") var akashiCountGusu: Int = 0
    @AppStorage("azurLaneAkashiCountLastMemory3") var akashiCountLast: Int = 0
    @AppStorage("azurLaneAkashiCountSumMemory3") var akashiCountSum: Int = 0
    
    // ////////////
    // ver3.11.0で追加
    // ////////////
    @AppStorage("azurLaneKoyakuCountCommonBellMemory3") var koyakuCountCommonBell: Int = 0
    @AppStorage("azurLaneKagaCountDefaultGusuMemory3") var kagaCountDefaultGusu: Int = 0
    @AppStorage("azurLaneScreenCountDefaultGusuMemory3") var screenCountDefaultGusu: Int = 0
    @AppStorage("azurLaneScreenCountSetteiSumMemory3") var screenCountSetteiSum: Int = 0
}
