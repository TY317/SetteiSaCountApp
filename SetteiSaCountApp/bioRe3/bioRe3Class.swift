//
//  bioRe3Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/05/03.
//

import Foundation
import SwiftUI
import Combine

class BioRe3: ObservableObject {
    // ---------
    // 初当り
    // ---------
    let ratioFirstHitCz: [Double] = [143.3,140.1,131.8,121.9,110.6,105.7]
    let ratioFirstHitAt: [Double] = [399,391.4,372.8,349.8,323.5,311.2]
    @AppStorage("bioRe3NormalGame") var normalGame: Int = 0
    @AppStorage("bioRe3FirstHitCountCz") var firstHitCountCz: Int = 0
    @AppStorage("bioRe3FirstHitCountAt") var firstHitCountAt: Int = 0
    
    func resetFirstHit() {
        normalGame = 0
        firstHitCountCz = 0
        firstHitCountAt = 0
        minusCheck = false
    }
    
    // ---------
    // フィギュア
    // ---------
    @AppStorage("bioRe3FigureCountKisuJaku") var figureCountKisuJaku: Int = 0
    @AppStorage("bioRe3FigureCountKisuKyo") var figureCountKisuKyo: Int = 0
    @AppStorage("bioRe3FigureCountGusuJaku") var figureCountGusuJaku: Int = 0
    @AppStorage("bioRe3FigureCountGusuKyo") var figureCountGusuKyo: Int = 0
    @AppStorage("bioRe3FigureCountHighJaku") var figureCountHighJaku: Int = 0
    @AppStorage("bioRe3FigureCountHighChu") var figureCountHighChu: Int = 0
    @AppStorage("bioRe3FigureCountHighKyo") var figureCountHighKyo: Int = 0
    @AppStorage("bioRe3FigureCountOver2") var figureCountOver2: Int = 0
    @AppStorage("bioRe3FigureCountOver4With16") var figureCountOver4With16: Int = 0
    @AppStorage("bioRe3FigureCountOver4With15") var figureCountOver4With15: Int = 0
    @AppStorage("bioRe3FigureCountSum") var figureCountSum: Int = 0
    
    func figureSumFunc() {
        figureCountSum = countSum(
            figureCountKisuJaku,
            figureCountKisuKyo,
            figureCountGusuJaku,
            figureCountGusuKyo,
            figureCountHighJaku,
            figureCountHighChu,
            figureCountHighKyo,
            figureCountOver2,
            figureCountOver4With16,
            figureCountOver4With15,
        )
    }
    
    func resetFigure() {
        figureCountKisuJaku = 0
        figureCountKisuKyo = 0
        figureCountGusuJaku = 0
        figureCountGusuKyo = 0
        figureCountHighJaku = 0
        figureCountHighChu = 0
        figureCountHighKyo = 0
        figureCountOver2 = 0
        figureCountOver4With16 = 0
        figureCountOver4With15 = 0
        figureCountSum = 0
        minusCheck = false
    }
    
    // -----------
    // 共通
    // -----------
    let machineName: String = "バイオハザードRE:3"
    @AppStorage("bioRe3MinusCheck") var minusCheck: Bool = false
    @AppStorage("bioRe3SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetFirstHit()
        resetFigure()
        resetNormal()
    }
    
    // ---------
    // ver3.27.1
    // ---------
    let ratioJakuRareNormalACz: [Double] = [0.4,-1,-1,-1,-1,-1,]
    let ratioJakuRareNormalBCz: [Double] = [0.4,-1,-1,-1,-1,-1,]
    let ratioJakuRareHighCz: [Double] = [6.3,-1,-1,-1,-1,-1,]
    let ratioJakuRareSuperHighCz: [Double] = [25,-1,-1,-1,-1,-1,]
    let ratioJakuRareNormalAAt: [Double] = [0,0,0,0,0,0]
    let ratioJakuRareNormalBAt: [Double] = [0,0,0,0,0,0]
    let ratioJakuRareHighAt: [Double] = [0,0,0,0,0,0]
    let ratioJakuRareSuperHighAt: [Double] = [0,0,0,0,0,0]
    let ratioKyoRareNormalACz: [Double] = [12.1,-1,-1,-1,-1,-1,]
    let ratioKyoRareNormalBCz: [Double] = [16.4,-1,-1,-1,-1,-1,]
    let ratioKyoRareHighCz: [Double] = [49.6,-1,-1,-1,-1,-1,]
    let ratioKyoRareSuperHighCz: [Double] = [87.5,-1,-1,-1,-1,-1,]
    let ratioKyoRareNormalAAt: [Double] = [0.4,-1,-1,-1,-1,-1,]
    let ratioKyoRareNormalBAt: [Double] = [0.4,-1,-1,-1,-1,-1,]
    let ratioKyoRareHighAt: [Double] = [0.4,-1,-1,-1,-1,-1,]
    let ratioKyoRareSuperHighAt: [Double] = [12.5,-1,-1,-1,-1,-1,]
    @AppStorage("bioRe3JakuRareCountJakuCherry") var jakuRareCountJakuCherry: Int = 0
    @AppStorage("bioRe3JakuRareCountSuika") var jakuRareCountSuika: Int = 0
    @AppStorage("bioRe3JakuRareCountKoyakuSum") var jakuRareCountKoyakuSum: Int = 0
    @AppStorage("bioRe3JakuRareCountCzHit") var jakuRareCountCzHit: Int = 0
    @AppStorage("bioRe3KyoRareCountKyoCherry") var kyoRareCountKyoCherry: Int = 0
    @AppStorage("bioRe3KyoRareCountChance") var kyoRareCountChance: Int = 0
    @AppStorage("bioRe3KyoRareCountKoyakuSum") var kyoRareCountKoyakuSum: Int = 0
    @AppStorage("bioRe3KyoRareCountCzHit") var kyoRareCountCzHit: Int = 0
    @AppStorage("bioRe3KyoRareCountAtHit") var kyoRareCountAtHit: Int = 0
    
    func koyakuCountSumFunc() {
        jakuRareCountKoyakuSum = jakuRareCountJakuCherry + jakuRareCountSuika
        kyoRareCountKoyakuSum = kyoRareCountKyoCherry + kyoRareCountChance
    }
    
    func resetNormal() {
        jakuRareCountJakuCherry = 0
        jakuRareCountSuika = 0
        jakuRareCountKoyakuSum = 0
        jakuRareCountCzHit = 0
        kyoRareCountKyoCherry = 0
        kyoRareCountChance = 0
        kyoRareCountKoyakuSum = 0
        kyoRareCountCzHit = 0
        kyoRareCountAtHit = 0
        minusCheck = false
        
        shinonCountDrop = 0
        shinonCountStay = 0
        shinonCountSum = 0
    }
    
    // ---------
    // ver4.0.0
    // ---------
    let ratioShinonDrop: [Double] = [50,49.6,48.4,45.3,43.8,43.4]
    @AppStorage("bioRe3ShinonCountDrop") var shinonCountDrop: Int = 0
    @AppStorage("bioRe3ShinonCountStay") var shinonCountStay: Int = 0
    @AppStorage("bioRe3ShinonCountSum") var shinonCountSum: Int = 0
    
    func shinonSumFunc() {
        shinonCountSum = shinonCountDrop + shinonCountStay
    }
    
    // ---------
    // ver4.1.0
    // ---------
    let ratioDuringAtCz: [Double] = [222.8,216.7,201.8,188.2,168.6,160.8]
    @AppStorage("bioRe3AtGame") var atGame: Int = 0
    @AppStorage("bioRe3DuringAtCountCz") var duringAtCountCz: Int = 0
    
    func resetDuringAt() {
        atGame = 0
        duringAtCountCz = 0
        minusCheck = false
    }
}


class BioRe3Memory1: ObservableObject {
    @AppStorage("bioRe3NormalGameMemory1") var normalGame: Int = 0
    @AppStorage("bioRe3FirstHitCountCzMemory1") var firstHitCountCz: Int = 0
    @AppStorage("bioRe3FirstHitCountAtMemory1") var firstHitCountAt: Int = 0
    @AppStorage("bioRe3FigureCountKisuJakuMemory1") var figureCountKisuJaku: Int = 0
    @AppStorage("bioRe3FigureCountKisuKyoMemory1") var figureCountKisuKyo: Int = 0
    @AppStorage("bioRe3FigureCountGusuJakuMemory1") var figureCountGusuJaku: Int = 0
    @AppStorage("bioRe3FigureCountGusuKyoMemory1") var figureCountGusuKyo: Int = 0
    @AppStorage("bioRe3FigureCountHighJakuMemory1") var figureCountHighJaku: Int = 0
    @AppStorage("bioRe3FigureCountHighChuMemory1") var figureCountHighChu: Int = 0
    @AppStorage("bioRe3FigureCountHighKyoMemory1") var figureCountHighKyo: Int = 0
    @AppStorage("bioRe3FigureCountOver2Memory1") var figureCountOver2: Int = 0
    @AppStorage("bioRe3FigureCountOver4With16Memory1") var figureCountOver4With16: Int = 0
    @AppStorage("bioRe3FigureCountOver4With15Memory1") var figureCountOver4With15: Int = 0
    @AppStorage("bioRe3FigureCountSumMemory1") var figureCountSum: Int = 0
    @AppStorage("bioRe3MemoMemory1") var memo = ""
    @AppStorage("bioRe3DateMemory1") var dateDouble = 0.0
    
    // ---------
    // ver3.27.1
    // ---------
    @AppStorage("bioRe3JakuRareCountJakuCherryMemory1") var jakuRareCountJakuCherry: Int = 0
    @AppStorage("bioRe3JakuRareCountSuikaMemory1") var jakuRareCountSuika: Int = 0
    @AppStorage("bioRe3JakuRareCountKoyakuSumMemory1") var jakuRareCountKoyakuSum: Int = 0
    @AppStorage("bioRe3JakuRareCountCzHitMemory1") var jakuRareCountCzHit: Int = 0
    @AppStorage("bioRe3KyoRareCountKyoCherryMemory1") var kyoRareCountKyoCherry: Int = 0
    @AppStorage("bioRe3KyoRareCountChanceMemory1") var kyoRareCountChance: Int = 0
    @AppStorage("bioRe3KyoRareCountKoyakuSumMemory1") var kyoRareCountKoyakuSum: Int = 0
    @AppStorage("bioRe3KyoRareCountCzHitMemory1") var kyoRareCountCzHit: Int = 0
    @AppStorage("bioRe3KyoRareCountAtHitMemory1") var kyoRareCountAtHit: Int = 0
    
    // ---------
    // ver4.0.0
    // ---------
    @AppStorage("bioRe3ShinonCountDropMemory1") var shinonCountDrop: Int = 0
    @AppStorage("bioRe3ShinonCountStayMemory1") var shinonCountStay: Int = 0
    @AppStorage("bioRe3ShinonCountSumMemory1") var shinonCountSum: Int = 0
}


class BioRe3Memory2: ObservableObject {
    @AppStorage("bioRe3NormalGameMemory2") var normalGame: Int = 0
    @AppStorage("bioRe3FirstHitCountCzMemory2") var firstHitCountCz: Int = 0
    @AppStorage("bioRe3FirstHitCountAtMemory2") var firstHitCountAt: Int = 0
    @AppStorage("bioRe3FigureCountKisuJakuMemory2") var figureCountKisuJaku: Int = 0
    @AppStorage("bioRe3FigureCountKisuKyoMemory2") var figureCountKisuKyo: Int = 0
    @AppStorage("bioRe3FigureCountGusuJakuMemory2") var figureCountGusuJaku: Int = 0
    @AppStorage("bioRe3FigureCountGusuKyoMemory2") var figureCountGusuKyo: Int = 0
    @AppStorage("bioRe3FigureCountHighJakuMemory2") var figureCountHighJaku: Int = 0
    @AppStorage("bioRe3FigureCountHighChuMemory2") var figureCountHighChu: Int = 0
    @AppStorage("bioRe3FigureCountHighKyoMemory2") var figureCountHighKyo: Int = 0
    @AppStorage("bioRe3FigureCountOver2Memory2") var figureCountOver2: Int = 0
    @AppStorage("bioRe3FigureCountOver4With16Memory2") var figureCountOver4With16: Int = 0
    @AppStorage("bioRe3FigureCountOver4With15Memory2") var figureCountOver4With15: Int = 0
    @AppStorage("bioRe3FigureCountSumMemory2") var figureCountSum: Int = 0
    @AppStorage("bioRe3MemoMemory2") var memo = ""
    @AppStorage("bioRe3DateMemory2") var dateDouble = 0.0
    
    // ---------
    // ver3.27.1
    // ---------
    @AppStorage("bioRe3JakuRareCountJakuCherryMemory2") var jakuRareCountJakuCherry: Int = 0
    @AppStorage("bioRe3JakuRareCountSuikaMemory2") var jakuRareCountSuika: Int = 0
    @AppStorage("bioRe3JakuRareCountKoyakuSumMemory2") var jakuRareCountKoyakuSum: Int = 0
    @AppStorage("bioRe3JakuRareCountCzHitMemory2") var jakuRareCountCzHit: Int = 0
    @AppStorage("bioRe3KyoRareCountKyoCherryMemory2") var kyoRareCountKyoCherry: Int = 0
    @AppStorage("bioRe3KyoRareCountChanceMemory2") var kyoRareCountChance: Int = 0
    @AppStorage("bioRe3KyoRareCountKoyakuSumMemory2") var kyoRareCountKoyakuSum: Int = 0
    @AppStorage("bioRe3KyoRareCountCzHitMemory2") var kyoRareCountCzHit: Int = 0
    @AppStorage("bioRe3KyoRareCountAtHitMemory2") var kyoRareCountAtHit: Int = 0
    
    // ---------
    // ver4.0.0
    // ---------
    @AppStorage("bioRe3ShinonCountDropMemory2") var shinonCountDrop: Int = 0
    @AppStorage("bioRe3ShinonCountStayMemory2") var shinonCountStay: Int = 0
    @AppStorage("bioRe3ShinonCountSumMemory2") var shinonCountSum: Int = 0
}


class BioRe3Memory3: ObservableObject {
    @AppStorage("bioRe3NormalGameMemory3") var normalGame: Int = 0
    @AppStorage("bioRe3FirstHitCountCzMemory3") var firstHitCountCz: Int = 0
    @AppStorage("bioRe3FirstHitCountAtMemory3") var firstHitCountAt: Int = 0
    @AppStorage("bioRe3FigureCountKisuJakuMemory3") var figureCountKisuJaku: Int = 0
    @AppStorage("bioRe3FigureCountKisuKyoMemory3") var figureCountKisuKyo: Int = 0
    @AppStorage("bioRe3FigureCountGusuJakuMemory3") var figureCountGusuJaku: Int = 0
    @AppStorage("bioRe3FigureCountGusuKyoMemory3") var figureCountGusuKyo: Int = 0
    @AppStorage("bioRe3FigureCountHighJakuMemory3") var figureCountHighJaku: Int = 0
    @AppStorage("bioRe3FigureCountHighChuMemory3") var figureCountHighChu: Int = 0
    @AppStorage("bioRe3FigureCountHighKyoMemory3") var figureCountHighKyo: Int = 0
    @AppStorage("bioRe3FigureCountOver2Memory3") var figureCountOver2: Int = 0
    @AppStorage("bioRe3FigureCountOver4With16Memory3") var figureCountOver4With16: Int = 0
    @AppStorage("bioRe3FigureCountOver4With15Memory3") var figureCountOver4With15: Int = 0
    @AppStorage("bioRe3FigureCountSumMemory3") var figureCountSum: Int = 0
    @AppStorage("bioRe3MemoMemory3") var memo = ""
    @AppStorage("bioRe3DateMemory3") var dateDouble = 0.0
    
    // ---------
    // ver3.27.1
    // ---------
    @AppStorage("bioRe3JakuRareCountJakuCherryMemory3") var jakuRareCountJakuCherry: Int = 0
    @AppStorage("bioRe3JakuRareCountSuikaMemory3") var jakuRareCountSuika: Int = 0
    @AppStorage("bioRe3JakuRareCountKoyakuSumMemory3") var jakuRareCountKoyakuSum: Int = 0
    @AppStorage("bioRe3JakuRareCountCzHitMemory3") var jakuRareCountCzHit: Int = 0
    @AppStorage("bioRe3KyoRareCountKyoCherryMemory3") var kyoRareCountKyoCherry: Int = 0
    @AppStorage("bioRe3KyoRareCountChanceMemory3") var kyoRareCountChance: Int = 0
    @AppStorage("bioRe3KyoRareCountKoyakuSumMemory3") var kyoRareCountKoyakuSum: Int = 0
    @AppStorage("bioRe3KyoRareCountCzHitMemory3") var kyoRareCountCzHit: Int = 0
    @AppStorage("bioRe3KyoRareCountAtHitMemory3") var kyoRareCountAtHit: Int = 0
    
    // ---------
    // ver4.0.0
    // ---------
    @AppStorage("bioRe3ShinonCountDropMemory3") var shinonCountDrop: Int = 0
    @AppStorage("bioRe3ShinonCountStayMemory3") var shinonCountStay: Int = 0
    @AppStorage("bioRe3ShinonCountSumMemory3") var shinonCountSum: Int = 0
}
