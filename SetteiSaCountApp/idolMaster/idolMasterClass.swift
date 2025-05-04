//
//  idolMasterClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/29.
//

import Foundation
import SwiftUI
import TipKit

class IdolMaster: ObservableObject {
    // /////////////////
    // 初当り
    // /////////////////
    let ratioCz: [Double] = [428,415.5,378.4,353.8,322.7,306.2]
    let ratioBonus: [Double] = [347,337.4,314,280.6,256.8,242]
    
    // /////////////////
    // ボーナス終了画面
    // /////////////////
    @AppStorage("idolMasterScreenCountDefault") var screenCountDefault: Int = 0 {
        didSet {
            screenCountSum = countSum(screenCountDefault, screenCountKisuJaku, screenCountKisuKyo, screenCountGusuJaku, screenCountGusuKyo, screenCountHighJaku, screenCountHighChu, screenCountHighKyo, screenCountGold, screenCountRainbow)
        }
    }
        @AppStorage("idolMasterScreenCountKisuJaku") var screenCountKisuJaku: Int = 0 {
            didSet {
                screenCountSum = countSum(screenCountDefault, screenCountKisuJaku, screenCountKisuKyo, screenCountGusuJaku, screenCountGusuKyo, screenCountHighJaku, screenCountHighChu, screenCountHighKyo, screenCountGold, screenCountRainbow)
            }
        }
            @AppStorage("idolMasterScreenCountKisuKyo") var screenCountKisuKyo: Int = 0 {
                didSet {
                    screenCountSum = countSum(screenCountDefault, screenCountKisuJaku, screenCountKisuKyo, screenCountGusuJaku, screenCountGusuKyo, screenCountHighJaku, screenCountHighChu, screenCountHighKyo, screenCountGold, screenCountRainbow)
                }
            }
                @AppStorage("idolMasterScreenCountGusuJaku") var screenCountGusuJaku: Int = 0 {
                    didSet {
                        screenCountSum = countSum(screenCountDefault, screenCountKisuJaku, screenCountKisuKyo, screenCountGusuJaku, screenCountGusuKyo, screenCountHighJaku, screenCountHighChu, screenCountHighKyo, screenCountGold, screenCountRainbow)
                    }
                }
                    @AppStorage("idolMasterScreenCountGusuKyo") var screenCountGusuKyo: Int = 0 {
                        didSet {
                            screenCountSum = countSum(screenCountDefault, screenCountKisuJaku, screenCountKisuKyo, screenCountGusuJaku, screenCountGusuKyo, screenCountHighJaku, screenCountHighChu, screenCountHighKyo, screenCountGold, screenCountRainbow)
                        }
                    }
                        @AppStorage("idolMasterScreenCountHighJaku") var screenCountHighJaku: Int = 0 {
                            didSet {
                                screenCountSum = countSum(screenCountDefault, screenCountKisuJaku, screenCountKisuKyo, screenCountGusuJaku, screenCountGusuKyo, screenCountHighJaku, screenCountHighChu, screenCountHighKyo, screenCountGold, screenCountRainbow)
                            }
                        }
                            @AppStorage("idolMasterScreenCountHighChu") var screenCountHighChu: Int = 0 {
                                didSet {
                                    screenCountSum = countSum(screenCountDefault, screenCountKisuJaku, screenCountKisuKyo, screenCountGusuJaku, screenCountGusuKyo, screenCountHighJaku, screenCountHighChu, screenCountHighKyo, screenCountGold, screenCountRainbow)
                                }
                            }
                                @AppStorage("idolMasterScreenCountHighKyo") var screenCountHighKyo: Int = 0 {
                                    didSet {
                                        screenCountSum = countSum(screenCountDefault, screenCountKisuJaku, screenCountKisuKyo, screenCountGusuJaku, screenCountGusuKyo, screenCountHighJaku, screenCountHighChu, screenCountHighKyo, screenCountGold, screenCountRainbow)
                                    }
                                }
                                    @AppStorage("idolMasterScreenCountGold") var screenCountGold: Int = 0 {
                                        didSet {
                                            screenCountSum = countSum(screenCountDefault, screenCountKisuJaku, screenCountKisuKyo, screenCountGusuJaku, screenCountGusuKyo, screenCountHighJaku, screenCountHighChu, screenCountHighKyo, screenCountGold, screenCountRainbow)
                                        }
                                    }
                                        @AppStorage("idolMasterScreenCountRainbow") var screenCountRainbow: Int = 0 {
                                            didSet {
                                                screenCountSum = countSum(screenCountDefault, screenCountKisuJaku, screenCountKisuKyo, screenCountGusuJaku, screenCountGusuKyo, screenCountHighJaku, screenCountHighChu, screenCountHighKyo, screenCountGold, screenCountRainbow)
                                            }
                                        }
    @AppStorage("idolMasterScreenCountSum") var screenCountSum: Int = 0
    func resetScreen() {
        screenCountDefault = 0
        screenCountKisuJaku = 0
        screenCountKisuKyo = 0
        screenCountGusuJaku = 0
        screenCountGusuKyo = 0
        screenCountHighJaku = 0
        screenCountHighChu = 0
        screenCountHighKyo = 0
        screenCountGold = 0
        screenCountRainbow = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("idolMasterMinusCheck") var minusCheck: Bool = false
    @AppStorage("idolMasterSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetScreen()
        
    }
}

// //// メモリー1
class IdolMasterMemory1: ObservableObject {
    @AppStorage("idolMasterScreenCountDefaultMemory1") var screenCountDefault: Int = 0
    @AppStorage("idolMasterScreenCountKisuJakuMemory1") var screenCountKisuJaku: Int = 0
    @AppStorage("idolMasterScreenCountKisuKyoMemory1") var screenCountKisuKyo: Int = 0
    @AppStorage("idolMasterScreenCountGusuJakuMemory1") var screenCountGusuJaku: Int = 0
    @AppStorage("idolMasterScreenCountGusuKyoMemory1") var screenCountGusuKyo: Int = 0
    @AppStorage("idolMasterScreenCountHighJakuMemory1") var screenCountHighJaku: Int = 0
    @AppStorage("idolMasterScreenCountHighChuMemory1") var screenCountHighChu: Int = 0
    @AppStorage("idolMasterScreenCountHighKyoMemory1") var screenCountHighKyo: Int = 0
    @AppStorage("idolMasterScreenCountGoldMemory1") var screenCountGold: Int = 0
    @AppStorage("idolMasterScreenCountRainbowMemory1") var screenCountRainbow: Int = 0
    @AppStorage("idolMasterScreenCountSumMemory1") var screenCountSum: Int = 0
    @AppStorage("idolMasterMemoMemory1") var memo = ""
    @AppStorage("idolMasterDateMemory1") var dateDouble = 0.0
}


// //// メモリー2
class IdolMasterMemory2: ObservableObject {
    @AppStorage("idolMasterScreenCountDefaultMemory2") var screenCountDefault: Int = 0
    @AppStorage("idolMasterScreenCountKisuJakuMemory2") var screenCountKisuJaku: Int = 0
    @AppStorage("idolMasterScreenCountKisuKyoMemory2") var screenCountKisuKyo: Int = 0
    @AppStorage("idolMasterScreenCountGusuJakuMemory2") var screenCountGusuJaku: Int = 0
    @AppStorage("idolMasterScreenCountGusuKyoMemory2") var screenCountGusuKyo: Int = 0
    @AppStorage("idolMasterScreenCountHighJakuMemory2") var screenCountHighJaku: Int = 0
    @AppStorage("idolMasterScreenCountHighChuMemory2") var screenCountHighChu: Int = 0
    @AppStorage("idolMasterScreenCountHighKyoMemory2") var screenCountHighKyo: Int = 0
    @AppStorage("idolMasterScreenCountGoldMemory2") var screenCountGold: Int = 0
    @AppStorage("idolMasterScreenCountRainbowMemory2") var screenCountRainbow: Int = 0
    @AppStorage("idolMasterScreenCountSumMemory2") var screenCountSum: Int = 0
    @AppStorage("idolMasterMemoMemory2") var memo = ""
    @AppStorage("idolMasterDateMemory2") var dateDouble = 0.0
}


// //// メモリー3
class IdolMasterMemory3: ObservableObject {
    @AppStorage("idolMasterScreenCountDefaultMemory3") var screenCountDefault: Int = 0
    @AppStorage("idolMasterScreenCountKisuJakuMemory3") var screenCountKisuJaku: Int = 0
    @AppStorage("idolMasterScreenCountKisuKyoMemory3") var screenCountKisuKyo: Int = 0
    @AppStorage("idolMasterScreenCountGusuJakuMemory3") var screenCountGusuJaku: Int = 0
    @AppStorage("idolMasterScreenCountGusuKyoMemory3") var screenCountGusuKyo: Int = 0
    @AppStorage("idolMasterScreenCountHighJakuMemory3") var screenCountHighJaku: Int = 0
    @AppStorage("idolMasterScreenCountHighChuMemory3") var screenCountHighChu: Int = 0
    @AppStorage("idolMasterScreenCountHighKyoMemory3") var screenCountHighKyo: Int = 0
    @AppStorage("idolMasterScreenCountGoldMemory3") var screenCountGold: Int = 0
    @AppStorage("idolMasterScreenCountRainbowMemory3") var screenCountRainbow: Int = 0
    @AppStorage("idolMasterScreenCountSumMemory3") var screenCountSum: Int = 0
    @AppStorage("idolMasterMemoMemory3") var memo = ""
    @AppStorage("idolMasterDateMemory3") var dateDouble = 0.0
}
