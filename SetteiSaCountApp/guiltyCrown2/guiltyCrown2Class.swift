//
//  guiltyCrown2Class.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/06/05.
//

import Foundation
import SwiftUI

class GuiltyCrown2: ObservableObject {
    // ///////////////////
    // 初当り
    // ///////////////////
    let ratioBonus: [Double] = [315.1,312.1,309.1,297.9,284.9,273.1]
    let ratioAt: [Double] = [596.4,571.6,528.8,447.0,410.5,375.5]
    let ratioFirstTotal: [Double] = [206.2,201.9,195.1,178.8,168.2,158.1]
    
    
    // /////////////////
    // BIG終了画面
    // /////////////////
    @AppStorage("guiltyCrown2BonusScreenCountBlack") var bonusScreenCountBlack: Int = 0
    @AppStorage("guiltyCrown2BonusScreenCountWhite") var bonusScreenCountWhite: Int = 0
    @AppStorage("guiltyCrown2BonusScreenCountSum") var bonusScreenCountSum: Int = 0
    
    func bonusScreenCountSumFunc() {
        bonusScreenCountSum = countSum(
            bonusScreenCountBlack,
            bonusScreenCountWhite,
        )
    }
    
    func resetBonusScreen() {
        bonusScreenCountBlack = 0
        bonusScreenCountWhite = 0
        minusCheck = false
    }
    
    
    // ////////////////
    // AT終了画面
    // ////////////////
    @AppStorage("guiltyCrown2AtScreenCountDefault") var atScreenCountDefault: Int = 0
    @AppStorage("guiltyCrown2AtScreenCountOver2") var atScreenCountOver2: Int = 0
    @AppStorage("guiltyCrown2AtScreenCountOver4") var atScreenCountOver4: Int = 0
    @AppStorage("guiltyCrown2AtScreenCountOver6") var atScreenCountOver6: Int = 0
    @AppStorage("guiltyCrown2AtScreenCountSum") var atScreenCountSum: Int = 0
    
    func atScreenCountSumFunc() {
        atScreenCountSum = countSum(
            atScreenCountDefault,
            atScreenCountOver2,
            atScreenCountOver4,
            atScreenCountOver6,
        )
    }
    
    func resetAtScreen() {
        atScreenCountDefault = 0
        atScreenCountOver2 = 0
        atScreenCountOver4 = 0
        atScreenCountOver6 = 0
        atScreenCountSumFunc()
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "ギルティクラウン2"
    @AppStorage("guiltyCrown2MinusCheck") var minusCheck: Bool = false
    @AppStorage("guiltyCrown2SelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetBonusScreen()
        resetAtScreen()
    }
}

// //// メモリー1
class GuiltyCrown2Memory1: ObservableObject {
    @AppStorage("guiltyCrown2BonusScreenCountBlackMemory1") var bonusScreenCountBlack: Int = 0
    @AppStorage("guiltyCrown2BonusScreenCountWhiteMemory1") var bonusScreenCountWhite: Int = 0
    @AppStorage("guiltyCrown2BonusScreenCountSumMemory1") var bonusScreenCountSum: Int = 0
    @AppStorage("guiltyCrown2AtScreenCountDefaultMemory1") var atScreenCountDefault: Int = 0
    @AppStorage("guiltyCrown2AtScreenCountOver2Memory1") var atScreenCountOver2: Int = 0
    @AppStorage("guiltyCrown2AtScreenCountOver4Memory1") var atScreenCountOver4: Int = 0
    @AppStorage("guiltyCrown2AtScreenCountOver6Memory1") var atScreenCountOver6: Int = 0
    @AppStorage("guiltyCrown2AtScreenCountSumMemory1") var atScreenCountSum: Int = 0
    @AppStorage("guiltyCrown2MemoMemory1") var memo = ""
    @AppStorage("guiltyCrown2DateMemory1") var dateDouble = 0.0
}


// //// メモリー2
class GuiltyCrown2Memory2: ObservableObject {
    @AppStorage("guiltyCrown2BonusScreenCountBlackMemory2") var bonusScreenCountBlack: Int = 0
    @AppStorage("guiltyCrown2BonusScreenCountWhiteMemory2") var bonusScreenCountWhite: Int = 0
    @AppStorage("guiltyCrown2BonusScreenCountSumMemory2") var bonusScreenCountSum: Int = 0
    @AppStorage("guiltyCrown2AtScreenCountDefaultMemory2") var atScreenCountDefault: Int = 0
    @AppStorage("guiltyCrown2AtScreenCountOver2Memory2") var atScreenCountOver2: Int = 0
    @AppStorage("guiltyCrown2AtScreenCountOver4Memory2") var atScreenCountOver4: Int = 0
    @AppStorage("guiltyCrown2AtScreenCountOver6Memory2") var atScreenCountOver6: Int = 0
    @AppStorage("guiltyCrown2AtScreenCountSumMemory2") var atScreenCountSum: Int = 0
    @AppStorage("guiltyCrown2MemoMemory2") var memo = ""
    @AppStorage("guiltyCrown2DateMemory2") var dateDouble = 0.0
}


// //// メモリー3
class GuiltyCrown2Memory3: ObservableObject {
    @AppStorage("guiltyCrown2BonusScreenCountBlackMemory3") var bonusScreenCountBlack: Int = 0
    @AppStorage("guiltyCrown2BonusScreenCountWhiteMemory3") var bonusScreenCountWhite: Int = 0
    @AppStorage("guiltyCrown2BonusScreenCountSumMemory3") var bonusScreenCountSum: Int = 0
    @AppStorage("guiltyCrown2AtScreenCountDefaultMemory3") var atScreenCountDefault: Int = 0
    @AppStorage("guiltyCrown2AtScreenCountOver2Memory3") var atScreenCountOver2: Int = 0
    @AppStorage("guiltyCrown2AtScreenCountOver4Memory3") var atScreenCountOver4: Int = 0
    @AppStorage("guiltyCrown2AtScreenCountOver6Memory3") var atScreenCountOver6: Int = 0
    @AppStorage("guiltyCrown2AtScreenCountSumMemory3") var atScreenCountSum: Int = 0
    @AppStorage("guiltyCrown2MemoMemory3") var memo = ""
    @AppStorage("guiltyCrown2DateMemory3") var dateDouble = 0.0
}
