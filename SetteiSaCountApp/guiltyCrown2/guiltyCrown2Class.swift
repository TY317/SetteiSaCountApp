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
        resetNormal()
        resetFirstHit()
    }
    
    // ////////////////////
    // ver3.5.0で追加
    // ////////////////////
    // //// スイカでのボーナス当選率
    let ratioSuikaBonusJaku: [Double] = [2.0,2.0,2.0,2.7,3.4,4.2]
    let ratioSuikaBonusKyo: [Double] = [30,30.6,31.1,32.5,34.4,36.1]
    @AppStorage("guiltyCrown2SuikaBonusCountJaku") var suikaBonusCountJaku: Int = 0
    @AppStorage("guiltyCrown2SuikaBonusCountJakuBonus") var suikaBonusCountJakuBonus: Int = 0
    @AppStorage("guiltyCrown2SuikaBonusCountKyo") var suikaBonusCountKyo: Int = 0
    @AppStorage("guiltyCrown2SuikaBonusCountKyoBonus") var suikaBonusCountKyoBonus: Int = 0
    
    func resetNormal() {
        suikaBonusCountJaku = 0
        suikaBonusCountJakuBonus = 0
        suikaBonusCountKyo = 0
        suikaBonusCountKyoBonus = 0
        minusCheck = false
    }
    
    // //// スイカ契機ボーナス詳細
    let ratioJakuRedIshoku: [Double] = [16384,16384,16384,9362.3,6553.6,5041.2]
    let ratioKyoRed: [Double] = [5461.3,5041.2,4681.1,4369.1,3855.0,3449.2]
    let ratioKyoWhite: [Double] = [2730.6,2621.4,2520.6,2427.2,2259.8,2114.0]
    let ratioKyoWhiteIshoku: [Double] = [3640.8,3640.8,3640.8,3120.7,2730.6,2427.2]
    let ratioDetailSum: [Double] = [1129.9,1092.2,1057.0,936.2,819.2,728.1]
    let ratioRed7: [Double] = [1213.6,1191.6,1170.3,1149.8,1110.8,1074.4]
    let ratioWhite7: [Double] = [1213.6,1191.6,1170.3,1149.8,1110.8,1074.4]
    let ratioRedIshoku: [Double] = [1310.7,1310.7,1310.7,1236.5,1170.3,1110.8]
    let ratioWhiteIshoku: [Double] = [1310.7,1310.7,1310.7,1236.5,1170.3,1110.8]
    @AppStorage("guiltyCrown2BonusDetailCountJakuRedIshoku") var bonusDetailCountJakuRedIshoku: Int = 0
    @AppStorage("guiltyCrown2BonusDetailCountKyoRed") var bonusDetailCountKyoRed: Int = 0
    @AppStorage("guiltyCrown2BonusDetailCountKyoWhite") var bonusDetailCountKyoWhite: Int = 0
    @AppStorage("guiltyCrown2BonusDetailCountKyoWhiteIshoku") var bonusDetailCountKyoWhiteIshoku: Int = 0
    @AppStorage("guiltyCrown2BonusDetailCountSum") var bonusDetailCountSum: Int = 0
    @AppStorage("guiltyCrown2NormalGame") var normalGame: Int = 0
    func bonusDetailCountSumFunc() {
        bonusDetailCountSum = countSum(
            bonusDetailCountJakuRedIshoku,
            bonusDetailCountKyoRed,
            bonusDetailCountKyoWhite,
            bonusDetailCountKyoWhiteIshoku,
        )
    }
    
    func resetFirstHit() {
        bonusDetailCountJakuRedIshoku = 0
        bonusDetailCountKyoRed = 0
        bonusDetailCountKyoWhite = 0
        bonusDetailCountKyoWhiteIshoku = 0
        bonusDetailCountSum = 0
        normalGame = 0
        minusCheck = false
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
    
    // ////////////////////
    // ver3.5.0で追加
    // ////////////////////
    @AppStorage("guiltyCrown2SuikaBonusCountJakuMemory1") var suikaBonusCountJaku: Int = 0
    @AppStorage("guiltyCrown2SuikaBonusCountJakuBonusMemory1") var suikaBonusCountJakuBonus: Int = 0
    @AppStorage("guiltyCrown2SuikaBonusCountKyoMemory1") var suikaBonusCountKyo: Int = 0
    @AppStorage("guiltyCrown2SuikaBonusCountKyoBonusMemory1") var suikaBonusCountKyoBonus: Int = 0
    @AppStorage("guiltyCrown2BonusDetailCountJakuRedIshokuMemory1") var bonusDetailCountJakuRedIshoku: Int = 0
    @AppStorage("guiltyCrown2BonusDetailCountKyoRedMemory1") var bonusDetailCountKyoRed: Int = 0
    @AppStorage("guiltyCrown2BonusDetailCountKyoWhiteMemory1") var bonusDetailCountKyoWhite: Int = 0
    @AppStorage("guiltyCrown2BonusDetailCountKyoWhiteIshokuMemory1") var bonusDetailCountKyoWhiteIshoku: Int = 0
    @AppStorage("guiltyCrown2BonusDetailCountSumMemory1") var bonusDetailCountSum: Int = 0
    @AppStorage("guiltyCrown2NormalGameMemory1") var normalGame: Int = 0
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
    
    // ////////////////////
    // ver3.5.0で追加
    // ////////////////////
    @AppStorage("guiltyCrown2SuikaBonusCountJakuMemory2") var suikaBonusCountJaku: Int = 0
    @AppStorage("guiltyCrown2SuikaBonusCountJakuBonusMemory2") var suikaBonusCountJakuBonus: Int = 0
    @AppStorage("guiltyCrown2SuikaBonusCountKyoMemory2") var suikaBonusCountKyo: Int = 0
    @AppStorage("guiltyCrown2SuikaBonusCountKyoBonusMemory2") var suikaBonusCountKyoBonus: Int = 0
    @AppStorage("guiltyCrown2BonusDetailCountJakuRedIshokuMemory2") var bonusDetailCountJakuRedIshoku: Int = 0
    @AppStorage("guiltyCrown2BonusDetailCountKyoRedMemory2") var bonusDetailCountKyoRed: Int = 0
    @AppStorage("guiltyCrown2BonusDetailCountKyoWhiteMemory2") var bonusDetailCountKyoWhite: Int = 0
    @AppStorage("guiltyCrown2BonusDetailCountKyoWhiteIshokuMemory2") var bonusDetailCountKyoWhiteIshoku: Int = 0
    @AppStorage("guiltyCrown2BonusDetailCountSumMemory2") var bonusDetailCountSum: Int = 0
    @AppStorage("guiltyCrown2NormalGameMemory2") var normalGame: Int = 0
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
    
    // ////////////////////
    // ver3.5.0で追加
    // ////////////////////
    @AppStorage("guiltyCrown2SuikaBonusCountJakuMemory3") var suikaBonusCountJaku: Int = 0
    @AppStorage("guiltyCrown2SuikaBonusCountJakuBonusMemory3") var suikaBonusCountJakuBonus: Int = 0
    @AppStorage("guiltyCrown2SuikaBonusCountKyoMemory3") var suikaBonusCountKyo: Int = 0
    @AppStorage("guiltyCrown2SuikaBonusCountKyoBonusMemory3") var suikaBonusCountKyoBonus: Int = 0
    @AppStorage("guiltyCrown2BonusDetailCountJakuRedIshokuMemory3") var bonusDetailCountJakuRedIshoku: Int = 0
    @AppStorage("guiltyCrown2BonusDetailCountKyoRedMemory3") var bonusDetailCountKyoRed: Int = 0
    @AppStorage("guiltyCrown2BonusDetailCountKyoWhiteMemory3") var bonusDetailCountKyoWhite: Int = 0
    @AppStorage("guiltyCrown2BonusDetailCountKyoWhiteIshokuMemory3") var bonusDetailCountKyoWhiteIshoku: Int = 0
    @AppStorage("guiltyCrown2BonusDetailCountSumMemory3") var bonusDetailCountSum: Int = 0
    @AppStorage("guiltyCrown2NormalGameMemory3") var normalGame: Int = 0
}
