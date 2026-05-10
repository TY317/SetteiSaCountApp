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
    let ratioFirstHitCz: [Double] = [143.3,-1,-1,-1,-1,-1]
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
}
