//
//  mahjongClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/15.
//

import Foundation
import SwiftUI

class Mahjong: ObservableObject {
    // ////////////////////////
    // 初当り
    // ////////////////////////
    let ratioFirstHit: [Double] = [354.1,349.2,342.1,328.8,326.0,323.8]
    let ratioNormalBonus: [Double] = [433.3,431.8,426.6,420.2,417.9,416.5]
    let ratioDirectAt: [Double] = [15142.4,10716.9,8351.0,5164.8,4886.1,4631.9]
    
    // ////////////////////////
    // ボーナス終了画面
    // ////////////////////////
    @AppStorage("mahjongBonusScreenCountDefault") var bonusScreenCountDefault: Int = 0 {
        didSet {
            bonusScreenCountSum = countSum(bonusScreenCountDefault, bonusScreenCountGusu, bonusScreenCountKisu, bonusScreenCount2Over, bonusScreenCount5Over, bonusScreenCount6Over)
        }
    }
        @AppStorage("mahjongBonusScreenCountGusu") var bonusScreenCountGusu: Int = 0 {
            didSet {
                bonusScreenCountSum = countSum(bonusScreenCountDefault, bonusScreenCountGusu, bonusScreenCountKisu, bonusScreenCount2Over, bonusScreenCount5Over, bonusScreenCount6Over)
            }
        }
            @AppStorage("mahjongBonusScreenCountKisu") var bonusScreenCountKisu: Int = 0 {
                didSet {
                    bonusScreenCountSum = countSum(bonusScreenCountDefault, bonusScreenCountGusu, bonusScreenCountKisu, bonusScreenCount2Over, bonusScreenCount5Over, bonusScreenCount6Over)
                }
            }
                @AppStorage("mahjongBonusScreenCount2Over") var bonusScreenCount2Over: Int = 0 {
                    didSet {
                        bonusScreenCountSum = countSum(bonusScreenCountDefault, bonusScreenCountGusu, bonusScreenCountKisu, bonusScreenCount2Over, bonusScreenCount5Over, bonusScreenCount6Over)
                    }
                }
                    @AppStorage("mahjongBonusScreenCount5Over") var bonusScreenCount5Over: Int = 0 {
                        didSet {
                            bonusScreenCountSum = countSum(bonusScreenCountDefault, bonusScreenCountGusu, bonusScreenCountKisu, bonusScreenCount2Over, bonusScreenCount5Over, bonusScreenCount6Over)
                        }
                    }
                        @AppStorage("mahjongBonusScreenCount6Over") var bonusScreenCount6Over: Int = 0 {
                            didSet {
                                bonusScreenCountSum = countSum(bonusScreenCountDefault, bonusScreenCountGusu, bonusScreenCountKisu, bonusScreenCount2Over, bonusScreenCount5Over, bonusScreenCount6Over)
                            }
                        }
    @AppStorage("mahjongBonusScreenCountSum") var bonusScreenCountSum: Int = 0
    
    func resetBonusScreen() {
        bonusScreenCountDefault = 0
        bonusScreenCountGusu = 0
        bonusScreenCountKisu = 0
        bonusScreenCount2Over = 0
        bonusScreenCount5Over = 0
        bonusScreenCount6Over = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // AT終了画面
    // ////////////////////////
    @AppStorage("mahjongAtScreenCountDefault") var atScreenCountDefault: Int = 0 {
        didSet {
            atScreenCountSum = countSum(atScreenCountDefault, atScreenCountHighJaku, atScreenCountHighKyo, atScreenCount2Over, atScreenCount4Over, atScreenCount6Over)
        }
    }
        @AppStorage("mahjongAtScreenCountHighJaku") var atScreenCountHighJaku: Int = 0 {
            didSet {
                atScreenCountSum = countSum(atScreenCountDefault, atScreenCountHighJaku, atScreenCountHighKyo, atScreenCount2Over, atScreenCount4Over, atScreenCount6Over)
            }
        }
            @AppStorage("mahjongAtScreenCountHighKyo") var atScreenCountHighKyo: Int = 0 {
                didSet {
                    atScreenCountSum = countSum(atScreenCountDefault, atScreenCountHighJaku, atScreenCountHighKyo, atScreenCount2Over, atScreenCount4Over, atScreenCount6Over)
                }
            }
                @AppStorage("mahjongAtScreenCount2Over") var atScreenCount2Over: Int = 0 {
                    didSet {
                        atScreenCountSum = countSum(atScreenCountDefault, atScreenCountHighJaku, atScreenCountHighKyo, atScreenCount2Over, atScreenCount4Over, atScreenCount6Over)
                    }
                }
                    @AppStorage("mahjongAtScreenCount4Over") var atScreenCount4Over: Int = 0 {
                        didSet {
                            atScreenCountSum = countSum(atScreenCountDefault, atScreenCountHighJaku, atScreenCountHighKyo, atScreenCount2Over, atScreenCount4Over, atScreenCount6Over)
                        }
                    }
                        @AppStorage("mahjongAtScreenCount6Over") var atScreenCount6Over: Int = 0 {
                            didSet {
                                atScreenCountSum = countSum(atScreenCountDefault, atScreenCountHighJaku, atScreenCountHighKyo, atScreenCount2Over, atScreenCount4Over, atScreenCount6Over)
                            }
                        }
    @AppStorage("mahjongAtScreenCountSum") var atScreenCountSum: Int = 0
    
    func resetAtScreen() {
        atScreenCountDefault = 0
        atScreenCountHighJaku = 0
        atScreenCountHighKyo = 0
        atScreenCount2Over = 0
        atScreenCount4Over = 0
        atScreenCount6Over = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("mahjongMinusCheck") var minusCheck: Bool = false
    @AppStorage("mahjongSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetBonusScreen()
        resetAtScreen()
    }
}


// //// メモリー1
class MahjongMemory1: ObservableObject {
    @AppStorage("mahjongBonusScreenCountDefaultMemory1") var bonusScreenCountDefault: Int = 0
    @AppStorage("mahjongBonusScreenCountGusuMemory1") var bonusScreenCountGusu: Int = 0
    @AppStorage("mahjongBonusScreenCountKisuMemory1") var bonusScreenCountKisu: Int = 0
    @AppStorage("mahjongBonusScreenCount2OverMemory1") var bonusScreenCount2Over: Int = 0
    @AppStorage("mahjongBonusScreenCount5OverMemory1") var bonusScreenCount5Over: Int = 0
    @AppStorage("mahjongBonusScreenCount6OverMemory1") var bonusScreenCount6Over: Int = 0
    @AppStorage("mahjongBonusScreenCountSumMemory1") var bonusScreenCountSum: Int = 0
    @AppStorage("mahjongAtScreenCountDefaultMemory1") var atScreenCountDefault: Int = 0
    @AppStorage("mahjongAtScreenCountHighJakuMemory1") var atScreenCountHighJaku: Int = 0
    @AppStorage("mahjongAtScreenCountHighKyoMemory1") var atScreenCountHighKyo: Int = 0
    @AppStorage("mahjongAtScreenCount2OverMemory1") var atScreenCount2Over: Int = 0
    @AppStorage("mahjongAtScreenCount4OverMemory1") var atScreenCount4Over: Int = 0
    @AppStorage("mahjongAtScreenCount6OverMemory1") var atScreenCount6Over: Int = 0
    @AppStorage("mahjongAtScreenCountSumMemory1") var atScreenCountSum: Int = 0
    @AppStorage("mahjongMemoMemory1") var memo = ""
    @AppStorage("mahjongDateMemory1") var dateDouble = 0.0
}


// //// メモリー2
class MahjongMemory2: ObservableObject {
    @AppStorage("mahjongBonusScreenCountDefaultMemory2") var bonusScreenCountDefault: Int = 0
    @AppStorage("mahjongBonusScreenCountGusuMemory2") var bonusScreenCountGusu: Int = 0
    @AppStorage("mahjongBonusScreenCountKisuMemory2") var bonusScreenCountKisu: Int = 0
    @AppStorage("mahjongBonusScreenCount2OverMemory2") var bonusScreenCount2Over: Int = 0
    @AppStorage("mahjongBonusScreenCount5OverMemory2") var bonusScreenCount5Over: Int = 0
    @AppStorage("mahjongBonusScreenCount6OverMemory2") var bonusScreenCount6Over: Int = 0
    @AppStorage("mahjongBonusScreenCountSumMemory2") var bonusScreenCountSum: Int = 0
    @AppStorage("mahjongAtScreenCountDefaultMemory2") var atScreenCountDefault: Int = 0
    @AppStorage("mahjongAtScreenCountHighJakuMemory2") var atScreenCountHighJaku: Int = 0
    @AppStorage("mahjongAtScreenCountHighKyoMemory2") var atScreenCountHighKyo: Int = 0
    @AppStorage("mahjongAtScreenCount2OverMemory2") var atScreenCount2Over: Int = 0
    @AppStorage("mahjongAtScreenCount4OverMemory2") var atScreenCount4Over: Int = 0
    @AppStorage("mahjongAtScreenCount6OverMemory2") var atScreenCount6Over: Int = 0
    @AppStorage("mahjongAtScreenCountSumMemory2") var atScreenCountSum: Int = 0
    @AppStorage("mahjongMemoMemory2") var memo = ""
    @AppStorage("mahjongDateMemory2") var dateDouble = 0.0
}


// //// メモリー3
class MahjongMemory3: ObservableObject {
    @AppStorage("mahjongBonusScreenCountDefaultMemory3") var bonusScreenCountDefault: Int = 0
    @AppStorage("mahjongBonusScreenCountGusuMemory3") var bonusScreenCountGusu: Int = 0
    @AppStorage("mahjongBonusScreenCountKisuMemory3") var bonusScreenCountKisu: Int = 0
    @AppStorage("mahjongBonusScreenCount2OverMemory3") var bonusScreenCount2Over: Int = 0
    @AppStorage("mahjongBonusScreenCount5OverMemory3") var bonusScreenCount5Over: Int = 0
    @AppStorage("mahjongBonusScreenCount6OverMemory3") var bonusScreenCount6Over: Int = 0
    @AppStorage("mahjongBonusScreenCountSumMemory3") var bonusScreenCountSum: Int = 0
    @AppStorage("mahjongAtScreenCountDefaultMemory3") var atScreenCountDefault: Int = 0
    @AppStorage("mahjongAtScreenCountHighJakuMemory3") var atScreenCountHighJaku: Int = 0
    @AppStorage("mahjongAtScreenCountHighKyoMemory3") var atScreenCountHighKyo: Int = 0
    @AppStorage("mahjongAtScreenCount2OverMemory3") var atScreenCount2Over: Int = 0
    @AppStorage("mahjongAtScreenCount4OverMemory3") var atScreenCount4Over: Int = 0
    @AppStorage("mahjongAtScreenCount6OverMemory3") var atScreenCount6Over: Int = 0
    @AppStorage("mahjongAtScreenCountSumMemory3") var atScreenCountSum: Int = 0
    @AppStorage("mahjongMemoMemory3") var memo = ""
    @AppStorage("mahjongDateMemory3") var dateDouble = 0.0
}
