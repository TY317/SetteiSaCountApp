//
//  EnenClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/08/15.
//

import Foundation
import SwiftUI

class Enen: ObservableObject {
    // ////////////
    // 通常時
    // ////////////
    let ratioRareBonusJuji: [Double] = [3,4,6,7,8]
    let ratioRareBonusKyoCherry: [Double] = [39,40,43,48,48]
    @AppStorage("enenRareBonusCountJuji") var rareBonusCountJuji: Int = 0
    @AppStorage("enenRareBonusCountJujiHit") var rareBonusCountJujiHit: Int = 0
    @AppStorage("enenRareBonusCountKyoCherry") var rareBonusCountKyoCherry: Int = 0
    @AppStorage("enenRareBonusCountKyoCherryHit") var rareBonusCountKyoCherryHit: Int = 0
    
    func resetNormal() {
        rareBonusCountJuji = 0
        rareBonusCountJujiHit = 0
        rareBonusCountKyoCherry = 0
        rareBonusCountKyoCherryHit = 0
        minusCheck = false
    }
    
    // /////////////
    // REGキャラ
    // /////////////
    let ratioCharaDefault: [Double] = [44,42,40,31,28]
    let ratioChara146Sisa: [Double] = [20,12,20,15,25]
    let ratioChara25Sisa: [Double] = [12,20,12,25,15]
    let ratioCharaNegate1: [Double] = [0,10,8,9,7]
    let ratioCharaNegate2: [Double] = [13,0,12,5,8]
    let ratioCharaNegate4: [Double] = [9,10,0,12,4]
    let ratioCharaNegate5: [Double] = [2,6,6,0,9]
    let ratioCharaOver4: [Double] = [0,0,2,2,2]
    let ratioCharaOver5: [Double] = [0,0,0,1,1]
    let ratioCharaOver6: [Double] = [0,0,0,0,1]
    @AppStorage("enenCharaCountDefault") var charaCountDefault: Int = 0
    @AppStorage("enenCharaCount25Sisa") var charaCount25Sisa: Int = 0
    @AppStorage("enenCharaCount145Sisa") var charaCount146Sisa: Int = 0
    @AppStorage("enenCharaCountNegate1") var charaCountNegate1: Int = 0
    @AppStorage("enenCharaCountNegate2") var charaCountNegate2: Int = 0
    @AppStorage("enenCharaCountNegate4") var charaCountNegate4: Int = 0
    @AppStorage("enenCharaCountNegate5") var charaCountNegate5: Int = 0
    @AppStorage("enenCharaCountOver6") var charaCountOver6: Int = 0
    @AppStorage("enenCharaCountOver4") var charaCountOver4: Int = 0
    @AppStorage("enenCharaCountOver5") var charaCountOver5: Int = 0
    @AppStorage("enenCharaCountSum") var charaCountSum: Int = 0
    
    func charaCountSumFunc() {
        charaCountSum = countSum(
            charaCountDefault,
            charaCount25Sisa,
            charaCount146Sisa,
            charaCountNegate1,
            charaCountNegate2,
            charaCountNegate4,
            charaCountNegate5,
            charaCountOver6,
            charaCountOver4,
            charaCountOver5,
        )
    }
    
    func resetChara() {
        charaCountDefault = 0
        charaCount25Sisa = 0
        charaCount146Sisa = 0
        charaCountNegate1 = 0
        charaCountNegate2 = 0
        charaCountNegate4 = 0
        charaCountNegate5 = 0
        charaCountOver6 = 0
        charaCountOver4 = 0
        charaCountOver5 = 0
        charaCountSum = 0
        minusCheck = false
    }
    
    // //////////////
    // REG終了後の画面
    // //////////////
    let ratioRegScreenDefault: [Double] = [77,73,64,61,55]
    let ratioRegScreenHighJaku: [Double] = [20,22,25,27,30]
    let ratioRegScreenHighKyo: [Double] = [3,5,6,7,9]
    let ratioRegScreenOver4: [Double] = [0,0,5,3,3]
    let ratioRegScreenOver5: [Double] = [0,0,0,2,2]
    let ratioRegScreenOver6: [Double] = [0,0,0,0,1]
    @AppStorage("enenRegScreenCountDefault") var regScreenCountDefault: Int = 0
    @AppStorage("enenRegScreenCountHighJaku") var regScreenCountHighJaku: Int = 0
    @AppStorage("enenRegScreenCountHighKyo") var regScreenCountHighKyo: Int = 0
    @AppStorage("enenRegScreenCountOver4") var regScreenCountOver4: Int = 0
    @AppStorage("enenRegScreenCountOver5") var regScreenCountOver5: Int = 0
    @AppStorage("enenRegScreenCountOver6") var regScreenCountOver6: Int = 0
    @AppStorage("enenRegScreenCountSum") var regScreenCountSum: Int = 0
    
    func regScreenCountSumFunc() {
        regScreenCountSum = countSum(
            regScreenCountDefault,
            regScreenCountHighJaku,
            regScreenCountHighKyo,
            regScreenCountOver4,
            regScreenCountOver5,
            regScreenCountOver6,
        )
    }
    
    func resetRegScreen() {
        regScreenCountDefault = 0
        regScreenCountHighJaku = 0
        regScreenCountHighKyo = 0
        regScreenCountOver4 = 0
        regScreenCountOver5 = 0
        regScreenCountOver6 = 0
        regScreenCountSum = 0
        minusCheck = false
    }
    
    // ///////////////
    // 伝道者の影
    // ///////////////
    let ratioDendoshaJuji: [Double] = [34,34,35,37,39]
    let ratioDendoshaJakuRare: [Double] = [1,1,2,3,3]
    @AppStorage("enenDendoshaCountJuji") var dendoshaCountJuji: Int = 0
    @AppStorage("enenDendoshaCountJujiHit") var dendoshaCountJujiHit: Int = 0
    @AppStorage("enenDendoshaCountJakuRare") var dendoshaCountJakuRare: Int = 0
    @AppStorage("enenDendoshaCountJakuRareHit") var dendoshaCountJakuRareHit: Int = 0
    func resetDendosha() {
        dendoshaCountJuji = 0
        dendoshaCountJujiHit = 0
        dendoshaCountJakuRare = 0
        dendoshaCountJakuRareHit = 0
        minusCheck = false
    }
    
    // //////////////
    // BIG終了後の画面
    // //////////////
    let ratioBigScreenDefault: [Double] = [87,83,78,75,73]
    let ratioBigScreenHighJaku: [Double] = [11,13,14,16,17]
    let ratioBigScreenHighKyo: [Double] = [3,4,5,6,6]
    let ratioBigScreenOver4: [Double] = [0,0,3,2,2]
    let ratioBigScreenOver5: [Double] = [0,0,0,1,1]
    let ratioBigScreenOver6: [Double] = [0,0,0,0,1]
    @AppStorage("enenBigScreenCountDefault") var bigScreenCountDefault: Int = 0
    @AppStorage("enenBigScreenCountHighJaku") var bigScreenCountHighJaku: Int = 0
    @AppStorage("enenBigScreenCountHighKyo") var bigScreenCountHighKyo: Int = 0
    @AppStorage("enenBigScreenCountOver4") var bigScreenCountOver4: Int = 0
    @AppStorage("enenBigScreenCountOver5") var bigScreenCountOver5: Int = 0
    @AppStorage("enenBigScreenCountOver6") var bigScreenCountOver6: Int = 0
    @AppStorage("enenBigScreenCountSum") var bigScreenCountSum: Int = 0
    
    func bigScreenCountSumFunc() {
        bigScreenCountSum = countSum(
            bigScreenCountDefault,
            bigScreenCountHighJaku,
            bigScreenCountHighKyo,
            bigScreenCountOver4,
            bigScreenCountOver5,
            bigScreenCountOver6,
        )
    }
    
    func resetBigScreen() {
        bigScreenCountDefault = 0
        bigScreenCountHighJaku = 0
        bigScreenCountHighKyo = 0
        bigScreenCountOver4 = 0
        bigScreenCountOver5 = 0
        bigScreenCountOver6 = 0
        bigScreenCountSum = 0
        minusCheck = false
    }
    
    // /////////////////
    // アドラバースト
    // /////////////////
    let ratioAdora25Sisa: [Double] = [39,57,38,57,37]
    let ratioAdora146Sisa: [Double] = [60,40,58,38,58]
    let ratioAdoraOver2: [Double] = [0,3,2,3,2]
    let ratioAdora146Fix: [Double] = [1,0,1,0,1]
    let ratioAdoraOver4: [Double] = [0,0,1,1,1]
    let ratioAdoraOver5: [Double] = [0,0,0,1,1]
    @AppStorage("enenAdoraCount25Sisa") var adoraCount25Sisa: Int = 0
    @AppStorage("enenAdoraCount146Sisa") var adoraCount146Sisa: Int = 0
    @AppStorage("enenAdoraCountOver2") var adoraCountOver2: Int = 0
    @AppStorage("enenAdoraCount146Fix") var adoraCount146Fix: Int = 0
    @AppStorage("enenAdoraCountOver4") var adoraCountOver4: Int = 0
    @AppStorage("enenAdoraCountOver5") var adoraCountOver5: Int = 0
    @AppStorage("enenAdoraCountSum") var adoraCountSum: Int = 0
    
    func adoraCountSumFunc() {
        adoraCountSum = countSum(
            adoraCount25Sisa,
            adoraCount146Sisa,
            adoraCountOver2,
            adoraCount146Fix,
            adoraCountOver4,
            adoraCountOver5,
        )
    }
    
    func resetAdora() {
        adoraCount25Sisa = 0
        adoraCount146Sisa = 0
        adoraCountOver2 = 0
        adoraCount146Fix = 0
        adoraCountOver4 = 0
        adoraCountOver5 = 0
        adoraCountSum = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    let machineName: String = "スマスロ炎炎ノ消防隊"
    @AppStorage("enenMinusCheck") var minusCheck: Bool = false
    @AppStorage("enenSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetChara()
        resetRegScreen()
        resetDendosha()
        resetBigScreen()
        resetAdora()
    }
}


// //// メモリー1
class EnenMemory1: ObservableObject {
    @AppStorage("enenRareBonusCountJujiMemory1") var rareBonusCountJuji: Int = 0
    @AppStorage("enenRareBonusCountJujiHitMemory1") var rareBonusCountJujiHit: Int = 0
    @AppStorage("enenRareBonusCountKyoCherryMemory1") var rareBonusCountKyoCherry: Int = 0
    @AppStorage("enenRareBonusCountKyoCherryHitMemory1") var rareBonusCountKyoCherryHit: Int = 0
    @AppStorage("enenCharaCountDefaultMemory1") var charaCountDefault: Int = 0
    @AppStorage("enenCharaCount25SisaMemory1") var charaCount25Sisa: Int = 0
    @AppStorage("enenCharaCount145SisaMemory1") var charaCount146Sisa: Int = 0
    @AppStorage("enenCharaCountNegate1Memory1") var charaCountNegate1: Int = 0
    @AppStorage("enenCharaCountNegate2Memory1") var charaCountNegate2: Int = 0
    @AppStorage("enenCharaCountNegate4Memory1") var charaCountNegate4: Int = 0
    @AppStorage("enenCharaCountNegate5Memory1") var charaCountNegate5: Int = 0
    @AppStorage("enenCharaCountOver6Memory1") var charaCountOver6: Int = 0
    @AppStorage("enenCharaCountOver4Memory1") var charaCountOver4: Int = 0
    @AppStorage("enenCharaCountOver5Memory1") var charaCountOver5: Int = 0
    @AppStorage("enenCharaCountSumMemory1") var charaCountSum: Int = 0
    @AppStorage("enenRegScreenCountDefaultMemory1") var regScreenCountDefault: Int = 0
    @AppStorage("enenRegScreenCountHighJakuMemory1") var regScreenCountHighJaku: Int = 0
    @AppStorage("enenRegScreenCountHighKyoMemory1") var regScreenCountHighKyo: Int = 0
    @AppStorage("enenRegScreenCountOver4Memory1") var regScreenCountOver4: Int = 0
    @AppStorage("enenRegScreenCountOver5Memory1") var regScreenCountOver5: Int = 0
    @AppStorage("enenRegScreenCountOver6Memory1") var regScreenCountOver6: Int = 0
    @AppStorage("enenRegScreenCountSumMemory1") var regScreenCountSum: Int = 0
    @AppStorage("enenDendoshaCountJujiMemory1") var dendoshaCountJuji: Int = 0
    @AppStorage("enenDendoshaCountJujiHitMemory1") var dendoshaCountJujiHit: Int = 0
    @AppStorage("enenDendoshaCountJakuRareMemory1") var dendoshaCountJakuRare: Int = 0
    @AppStorage("enenDendoshaCountJakuRareHitMemory1") var dendoshaCountJakuRareHit: Int = 0
    @AppStorage("enenBigScreenCountDefaultMemory1") var bigScreenCountDefault: Int = 0
    @AppStorage("enenBigScreenCountHighJakuMemory1") var bigScreenCountHighJaku: Int = 0
    @AppStorage("enenBigScreenCountHighKyoMemory1") var bigScreenCountHighKyo: Int = 0
    @AppStorage("enenBigScreenCountOver4Memory1") var bigScreenCountOver4: Int = 0
    @AppStorage("enenBigScreenCountOver5Memory1") var bigScreenCountOver5: Int = 0
    @AppStorage("enenBigScreenCountOver6Memory1") var bigScreenCountOver6: Int = 0
    @AppStorage("enenBigScreenCountSumMemory1") var bigScreenCountSum: Int = 0
    @AppStorage("enenAdoraCount25SisaMemory1") var adoraCount25Sisa: Int = 0
    @AppStorage("enenAdoraCount146SisaMemory1") var adoraCount146Sisa: Int = 0
    @AppStorage("enenAdoraCountOver2Memory1") var adoraCountOver2: Int = 0
    @AppStorage("enenAdoraCount146FixMemory1") var adoraCount146Fix: Int = 0
    @AppStorage("enenAdoraCountOver4Memory1") var adoraCountOver4: Int = 0
    @AppStorage("enenAdoraCountOver5Memory1") var adoraCountOver5: Int = 0
    @AppStorage("enenAdoraCountSumMemory1") var adoraCountSum: Int = 0
    @AppStorage("enenMemoMemory1") var memo = ""
    @AppStorage("enenDateMemory1") var dateDouble = 0.0
}


// //// メモリー2
class EnenMemory2: ObservableObject {
    @AppStorage("enenRareBonusCountJujiMemory2") var rareBonusCountJuji: Int = 0
    @AppStorage("enenRareBonusCountJujiHitMemory2") var rareBonusCountJujiHit: Int = 0
    @AppStorage("enenRareBonusCountKyoCherryMemory2") var rareBonusCountKyoCherry: Int = 0
    @AppStorage("enenRareBonusCountKyoCherryHitMemory2") var rareBonusCountKyoCherryHit: Int = 0
    @AppStorage("enenCharaCountDefaultMemory2") var charaCountDefault: Int = 0
    @AppStorage("enenCharaCount25SisaMemory2") var charaCount25Sisa: Int = 0
    @AppStorage("enenCharaCount145SisaMemory2") var charaCount146Sisa: Int = 0
    @AppStorage("enenCharaCountNegate1Memory2") var charaCountNegate1: Int = 0
    @AppStorage("enenCharaCountNegate2Memory2") var charaCountNegate2: Int = 0
    @AppStorage("enenCharaCountNegate4Memory2") var charaCountNegate4: Int = 0
    @AppStorage("enenCharaCountNegate5Memory2") var charaCountNegate5: Int = 0
    @AppStorage("enenCharaCountOver6Memory2") var charaCountOver6: Int = 0
    @AppStorage("enenCharaCountOver4Memory2") var charaCountOver4: Int = 0
    @AppStorage("enenCharaCountOver5Memory2") var charaCountOver5: Int = 0
    @AppStorage("enenCharaCountSumMemory2") var charaCountSum: Int = 0
    @AppStorage("enenRegScreenCountDefaultMemory2") var regScreenCountDefault: Int = 0
    @AppStorage("enenRegScreenCountHighJakuMemory2") var regScreenCountHighJaku: Int = 0
    @AppStorage("enenRegScreenCountHighKyoMemory2") var regScreenCountHighKyo: Int = 0
    @AppStorage("enenRegScreenCountOver4Memory2") var regScreenCountOver4: Int = 0
    @AppStorage("enenRegScreenCountOver5Memory2") var regScreenCountOver5: Int = 0
    @AppStorage("enenRegScreenCountOver6Memory2") var regScreenCountOver6: Int = 0
    @AppStorage("enenRegScreenCountSumMemory2") var regScreenCountSum: Int = 0
    @AppStorage("enenDendoshaCountJujiMemory2") var dendoshaCountJuji: Int = 0
    @AppStorage("enenDendoshaCountJujiHitMemory2") var dendoshaCountJujiHit: Int = 0
    @AppStorage("enenDendoshaCountJakuRareMemory2") var dendoshaCountJakuRare: Int = 0
    @AppStorage("enenDendoshaCountJakuRareHitMemory2") var dendoshaCountJakuRareHit: Int = 0
    @AppStorage("enenBigScreenCountDefaultMemory2") var bigScreenCountDefault: Int = 0
    @AppStorage("enenBigScreenCountHighJakuMemory2") var bigScreenCountHighJaku: Int = 0
    @AppStorage("enenBigScreenCountHighKyoMemory2") var bigScreenCountHighKyo: Int = 0
    @AppStorage("enenBigScreenCountOver4Memory2") var bigScreenCountOver4: Int = 0
    @AppStorage("enenBigScreenCountOver5Memory2") var bigScreenCountOver5: Int = 0
    @AppStorage("enenBigScreenCountOver6Memory2") var bigScreenCountOver6: Int = 0
    @AppStorage("enenBigScreenCountSumMemory2") var bigScreenCountSum: Int = 0
    @AppStorage("enenAdoraCount25SisaMemory2") var adoraCount25Sisa: Int = 0
    @AppStorage("enenAdoraCount146SisaMemory2") var adoraCount146Sisa: Int = 0
    @AppStorage("enenAdoraCountOver2Memory2") var adoraCountOver2: Int = 0
    @AppStorage("enenAdoraCount146FixMemory2") var adoraCount146Fix: Int = 0
    @AppStorage("enenAdoraCountOver4Memory2") var adoraCountOver4: Int = 0
    @AppStorage("enenAdoraCountOver5Memory2") var adoraCountOver5: Int = 0
    @AppStorage("enenAdoraCountSumMemory2") var adoraCountSum: Int = 0
    @AppStorage("enenMemoMemory2") var memo = ""
    @AppStorage("enenDateMemory2") var dateDouble = 0.0
}


// //// メモリー3
class EnenMemory3: ObservableObject {
    @AppStorage("enenRareBonusCountJujiMemory3") var rareBonusCountJuji: Int = 0
    @AppStorage("enenRareBonusCountJujiHitMemory3") var rareBonusCountJujiHit: Int = 0
    @AppStorage("enenRareBonusCountKyoCherryMemory3") var rareBonusCountKyoCherry: Int = 0
    @AppStorage("enenRareBonusCountKyoCherryHitMemory3") var rareBonusCountKyoCherryHit: Int = 0
    @AppStorage("enenCharaCountDefaultMemory3") var charaCountDefault: Int = 0
    @AppStorage("enenCharaCount25SisaMemory3") var charaCount25Sisa: Int = 0
    @AppStorage("enenCharaCount145SisaMemory3") var charaCount146Sisa: Int = 0
    @AppStorage("enenCharaCountNegate1Memory3") var charaCountNegate1: Int = 0
    @AppStorage("enenCharaCountNegate2Memory3") var charaCountNegate2: Int = 0
    @AppStorage("enenCharaCountNegate4Memory3") var charaCountNegate4: Int = 0
    @AppStorage("enenCharaCountNegate5Memory3") var charaCountNegate5: Int = 0
    @AppStorage("enenCharaCountOver6Memory3") var charaCountOver6: Int = 0
    @AppStorage("enenCharaCountOver4Memory3") var charaCountOver4: Int = 0
    @AppStorage("enenCharaCountOver5Memory3") var charaCountOver5: Int = 0
    @AppStorage("enenCharaCountSumMemory3") var charaCountSum: Int = 0
    @AppStorage("enenRegScreenCountDefaultMemory3") var regScreenCountDefault: Int = 0
    @AppStorage("enenRegScreenCountHighJakuMemory3") var regScreenCountHighJaku: Int = 0
    @AppStorage("enenRegScreenCountHighKyoMemory3") var regScreenCountHighKyo: Int = 0
    @AppStorage("enenRegScreenCountOver4Memory3") var regScreenCountOver4: Int = 0
    @AppStorage("enenRegScreenCountOver5Memory3") var regScreenCountOver5: Int = 0
    @AppStorage("enenRegScreenCountOver6Memory3") var regScreenCountOver6: Int = 0
    @AppStorage("enenRegScreenCountSumMemory3") var regScreenCountSum: Int = 0
    @AppStorage("enenDendoshaCountJujiMemory3") var dendoshaCountJuji: Int = 0
    @AppStorage("enenDendoshaCountJujiHitMemory3") var dendoshaCountJujiHit: Int = 0
    @AppStorage("enenDendoshaCountJakuRareMemory3") var dendoshaCountJakuRare: Int = 0
    @AppStorage("enenDendoshaCountJakuRareHitMemory3") var dendoshaCountJakuRareHit: Int = 0
    @AppStorage("enenBigScreenCountDefaultMemory3") var bigScreenCountDefault: Int = 0
    @AppStorage("enenBigScreenCountHighJakuMemory3") var bigScreenCountHighJaku: Int = 0
    @AppStorage("enenBigScreenCountHighKyoMemory3") var bigScreenCountHighKyo: Int = 0
    @AppStorage("enenBigScreenCountOver4Memory3") var bigScreenCountOver4: Int = 0
    @AppStorage("enenBigScreenCountOver5Memory3") var bigScreenCountOver5: Int = 0
    @AppStorage("enenBigScreenCountOver6Memory3") var bigScreenCountOver6: Int = 0
    @AppStorage("enenBigScreenCountSumMemory3") var bigScreenCountSum: Int = 0
    @AppStorage("enenAdoraCount25SisaMemory3") var adoraCount25Sisa: Int = 0
    @AppStorage("enenAdoraCount146SisaMemory3") var adoraCount146Sisa: Int = 0
    @AppStorage("enenAdoraCountOver2Memory3") var adoraCountOver2: Int = 0
    @AppStorage("enenAdoraCount146FixMemory3") var adoraCount146Fix: Int = 0
    @AppStorage("enenAdoraCountOver4Memory3") var adoraCountOver4: Int = 0
    @AppStorage("enenAdoraCountOver5Memory3") var adoraCountOver5: Int = 0
    @AppStorage("enenAdoraCountSumMemory3") var adoraCountSum: Int = 0
    @AppStorage("enenMemoMemory3") var memo = ""
    @AppStorage("enenDateMemory3") var dateDouble = 0.0
}
