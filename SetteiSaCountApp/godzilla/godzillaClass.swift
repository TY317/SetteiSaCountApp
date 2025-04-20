//
//  godzillaClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/13.
//

import Foundation
import SwiftUI

class Godzilla: ObservableObject {
    // //////////////////////
    // 通常時
    // //////////////////////
    @AppStorage("godzillaTansakuCount") var tansakuCount: Int = 0
    @AppStorage("godzillaNormalGame") var normalGame: Int = 0
    let ratioTansakuZone: [Double] = [91.3,-1,-1,-1,-1,72.5]
    
    func resetNormal() {
        tansakuCount = 0
        normalGame = 0
        minusCheck = false
    }
    
    // //////////////////////
    // 襲来ゾーン
    // //////////////////////
    @AppStorage("godzillaCzCharaCountRadon") var czCharaCountRadon: Int = 0 {
        didSet {
            czCharaCountSum = countSum(czCharaCountRadon, czCharaCountGaigan, czCharaCountBiorante, czCharaCountDestoroia, czCharaCountKingGidora)
        }
    }
        @AppStorage("godzillaCzCharaCountGaigan") var czCharaCountGaigan: Int = 0 {
            didSet {
                czCharaCountSum = countSum(czCharaCountRadon, czCharaCountGaigan, czCharaCountBiorante, czCharaCountDestoroia, czCharaCountKingGidora)
            }
        }
            @AppStorage("godzillaCzCharaCountBiorante") var czCharaCountBiorante: Int = 0 {
                didSet {
                    czCharaCountSum = countSum(czCharaCountRadon, czCharaCountGaigan, czCharaCountBiorante, czCharaCountDestoroia, czCharaCountKingGidora)
                }
            }
                @AppStorage("godzillaCzCharaCountDestoroia") var czCharaCountDestoroia: Int = 0 {
                    didSet {
                        czCharaCountSum = countSum(czCharaCountRadon, czCharaCountGaigan, czCharaCountBiorante, czCharaCountDestoroia, czCharaCountKingGidora)
                    }
                }
                    @AppStorage("godzillaCzCharaCountKingGidora") var czCharaCountKingGidora: Int = 0 {
                        didSet {
                            czCharaCountSum = countSum(czCharaCountRadon, czCharaCountGaigan, czCharaCountBiorante, czCharaCountDestoroia, czCharaCountKingGidora)
                        }
                    }
    @AppStorage("godzillaCzCharaCountSum") var czCharaCountSum: Int = 0
    let ratioCzCharaRadon: [Double] = [41.4,39.6,38.0,35.8,33.9,32.2]
    let ratioCzCharaGaigan: [Double] = [36.6,37.0,37.2,36.4,35.1,34.5]
    let ratioCzCharaBiorante: [Double] = [16.8,17.9,18.7,20.9,23.3,25.1]
    let ratioCzCharaDestoroia: [Double] = [5.0,5.4,5.9,6.7,7.5,8.1]
    
    func resetCz() {
        czCharaCountRadon = 0
        czCharaCountGaigan = 0
        czCharaCountBiorante = 0
        czCharaCountDestoroia = 0
        czCharaCountKingGidora = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // CZ,AT 初当り
    // ////////////////////////
    @AppStorage("godzillaCzCountShurai") var czCountShurai: Int = 0 {
        didSet {
            czCountSum = countSum(czCountShurai, czCountBreakDown)
        }
    }
        @AppStorage("godzillaCzCountBreakDown") var czCountBreakDown: Int = 0 {
            didSet {
                czCountSum = countSum(czCountShurai, czCountBreakDown)
            }
        }
    @AppStorage("godzillaCzCountSum") var czCountSum: Int = 0
    @AppStorage("godzillaAtCount") var atCount: Int = 0
    let ratioCz: [Double] = [306.9,304.0,303.0,302.1,299.6,295.5]
    let ratioAt: [Double] = [680.9,662.6,611.0,511.3,447.1,420.4]
    
    func resetFirstHit() {
        normalGame = 0
        czCountShurai = 0
        czCountBreakDown = 0
        atCount = 0
        minusCheck = false
    }
    
    // ///////////////////////
    // ボーナス終了画面
    // ///////////////////////
    
    @AppStorage("godzillaBonusScreenCountDefault") var bonusScreenCountDefault: Int = 0 {
        didSet {
            bonusScreenCountSum = countSum(bonusScreenCountDefault, bonusScreenCountKisu, bonusScreenCountGusu, bonusScreenCountKisuHigh, bonusScreenCountGusuHigh, bonusScreenCount4Over, bonusScreenCount5Over, bonusScreenCount6Over)
        }
    }
        @AppStorage("godzillaBonusScreenCountKisu") var bonusScreenCountKisu: Int = 0 {
            didSet {
                bonusScreenCountSum = countSum(bonusScreenCountDefault, bonusScreenCountKisu, bonusScreenCountGusu, bonusScreenCountKisuHigh, bonusScreenCountGusuHigh, bonusScreenCount4Over, bonusScreenCount5Over, bonusScreenCount6Over)
            }
        }
            @AppStorage("godzillaBonusScreenCountGusu") var bonusScreenCountGusu: Int = 0 {
                didSet {
                    bonusScreenCountSum = countSum(bonusScreenCountDefault, bonusScreenCountKisu, bonusScreenCountGusu, bonusScreenCountKisuHigh, bonusScreenCountGusuHigh, bonusScreenCount4Over, bonusScreenCount5Over, bonusScreenCount6Over)
                }
            }
                @AppStorage("godzillaBonusScreenCountKisuHigh") var bonusScreenCountKisuHigh: Int = 0 {
                    didSet {
                        bonusScreenCountSum = countSum(bonusScreenCountDefault, bonusScreenCountKisu, bonusScreenCountGusu, bonusScreenCountKisuHigh, bonusScreenCountGusuHigh, bonusScreenCount4Over, bonusScreenCount5Over, bonusScreenCount6Over)
                    }
                }
                    @AppStorage("godzillaBonusScreenCountGusuHigh") var bonusScreenCountGusuHigh: Int = 0 {
                        didSet {
                            bonusScreenCountSum = countSum(bonusScreenCountDefault, bonusScreenCountKisu, bonusScreenCountGusu, bonusScreenCountKisuHigh, bonusScreenCountGusuHigh, bonusScreenCount4Over, bonusScreenCount5Over, bonusScreenCount6Over)
                        }
                    }
                        @AppStorage("godzillaBonusScreenCount4Over") var bonusScreenCount4Over: Int = 0 {
                            didSet {
                                bonusScreenCountSum = countSum(bonusScreenCountDefault, bonusScreenCountKisu, bonusScreenCountGusu, bonusScreenCountKisuHigh, bonusScreenCountGusuHigh, bonusScreenCount4Over, bonusScreenCount5Over, bonusScreenCount6Over)
                            }
                        }
                            @AppStorage("godzillaBonusScreenCount5Over") var bonusScreenCount5Over: Int = 0 {
                                didSet {
                                    bonusScreenCountSum = countSum(bonusScreenCountDefault, bonusScreenCountKisu, bonusScreenCountGusu, bonusScreenCountKisuHigh, bonusScreenCountGusuHigh, bonusScreenCount4Over, bonusScreenCount5Over, bonusScreenCount6Over)
                                }
                            }
                                @AppStorage("godzillaBonusScreenCount6Over") var bonusScreenCount6Over: Int = 0 {
                                    didSet {
                                        bonusScreenCountSum = countSum(bonusScreenCountDefault, bonusScreenCountKisu, bonusScreenCountGusu, bonusScreenCountKisuHigh, bonusScreenCountGusuHigh, bonusScreenCount4Over, bonusScreenCount5Over, bonusScreenCount6Over)
                                    }
                                }
    @AppStorage("godzillaBonusScreenCountSum") var bonusScreenCountSum: Int = 0
    
    func resetBonusScreen() {
        bonusScreenCountDefault = 0
        bonusScreenCountKisu = 0
        bonusScreenCountGusu = 0
        bonusScreenCountKisuHigh = 0
        bonusScreenCountGusuHigh = 0
        bonusScreenCount4Over = 0
        bonusScreenCount5Over = 0
        bonusScreenCount6Over = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // EX中のムービー
    // ////////////////////////
    @AppStorage("godzillaExMovieCountDefault") var exMovieCountDefault: Int = 0 {
        didSet {
            exMovieCountSum = countSum(exMovieCountDefault, exMovieCountHighJaku, exMovieCountHighChu, exMovieCountHighKyo, exMovieCount5Over)
        }
    }
        @AppStorage("godzillaExMovieCountHighJaku") var exMovieCountHighJaku: Int = 0 {
            didSet {
                exMovieCountSum = countSum(exMovieCountDefault, exMovieCountHighJaku, exMovieCountHighChu, exMovieCountHighKyo, exMovieCount5Over)
            }
        }
            @AppStorage("godzillaExMovieCountHighChu") var exMovieCountHighChu: Int = 0 {
                didSet {
                    exMovieCountSum = countSum(exMovieCountDefault, exMovieCountHighJaku, exMovieCountHighChu, exMovieCountHighKyo, exMovieCount5Over)
                }
            }
                @AppStorage("godzillaExMovieCountHighKyo") var exMovieCountHighKyo: Int = 0 {
                    didSet {
                        exMovieCountSum = countSum(exMovieCountDefault, exMovieCountHighJaku, exMovieCountHighChu, exMovieCountHighKyo, exMovieCount5Over)
                    }
                }
                    @AppStorage("godzillaExMovieCount5Over") var exMovieCount5Over: Int = 0 {
                        didSet {
                            exMovieCountSum = countSum(exMovieCountDefault, exMovieCountHighJaku, exMovieCountHighChu, exMovieCountHighKyo, exMovieCount5Over)
                        }
                    }
    @AppStorage("godzillaExMovieCountSum") var exMovieCountSum: Int = 0
    
    func resetExMovie() {
        exMovieCountDefault = 0
        exMovieCountHighJaku = 0
        exMovieCountHighChu = 0
        exMovieCountHighKyo = 0
        exMovieCount5Over = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("godzillaMinusCheck") var minusCheck: Bool = false
    @AppStorage("godzillaSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetCz()
        resetFirstHit()
        resetExMovie()
        resetBonusScreen()
    }
}

// //// メモリー1
class GodzillaMemory1: ObservableObject {
    @AppStorage("godzillaTansakuCountMemory1") var tansakuCount: Int = 0
    @AppStorage("godzillaNormalGameMemory1") var normalGame: Int = 0
    @AppStorage("godzillaCzCharaCountRadonMemory1") var czCharaCountRadon: Int = 0
    @AppStorage("godzillaCzCharaCountGaiganMemory1") var czCharaCountGaigan: Int = 0
    @AppStorage("godzillaCzCharaCountBioranteMemory1") var czCharaCountBiorante: Int = 0
    @AppStorage("godzillaCzCharaCountDestoroiaMemory1") var czCharaCountDestoroia: Int = 0
    @AppStorage("godzillaCzCharaCountKingGidoraMemory1") var czCharaCountKingGidora: Int = 0
    @AppStorage("godzillaCzCharaCountSumMemory1") var czCharaCountSum: Int = 0
    @AppStorage("godzillaCzCountShuraiMemory1") var czCountShurai: Int = 0
    @AppStorage("godzillaCzCountBreakDownMemory1") var czCountBreakDown: Int = 0
    @AppStorage("godzillaCzCountSumMemory1") var czCountSum: Int = 0
    @AppStorage("godzillaAtCountMemory1") var atCount: Int = 0
    @AppStorage("godzillaBonusScreenCountDefaultMemory1") var bonusScreenCountDefault: Int = 0
    @AppStorage("godzillaBonusScreenCountKisuMemory1") var bonusScreenCountKisu: Int = 0
    @AppStorage("godzillaBonusScreenCountGusuMemory1") var bonusScreenCountGusu: Int = 0
    @AppStorage("godzillaBonusScreenCountKisuHighMemory1") var bonusScreenCountKisuHigh: Int = 0
    @AppStorage("godzillaBonusScreenCountGusuHighMemory1") var bonusScreenCountGusuHigh: Int = 0
    @AppStorage("godzillaBonusScreenCount4OverMemory1") var bonusScreenCount4Over: Int = 0
    @AppStorage("godzillaBonusScreenCount5OverMemory1") var bonusScreenCount5Over: Int = 0
    @AppStorage("godzillaBonusScreenCount6OverMemory1") var bonusScreenCount6Over: Int = 0
    @AppStorage("godzillaBonusScreenCountSumMemory1") var bonusScreenCountSum: Int = 0
    @AppStorage("godzillaExMovieCountDefaultMemory1") var exMovieCountDefault: Int = 0
    @AppStorage("godzillaExMovieCountHighJakuMemory1") var exMovieCountHighJaku: Int = 0
    @AppStorage("godzillaExMovieCountHighChuMemory1") var exMovieCountHighChu: Int = 0
    @AppStorage("godzillaExMovieCountHighKyoMemory1") var exMovieCountHighKyo: Int = 0
    @AppStorage("godzillaExMovieCount5OverMemory1") var exMovieCount5Over: Int = 0
    @AppStorage("godzillaExMovieCountSumMemory1") var exMovieCountSum: Int = 0
    @AppStorage("godzillaMemoMemory1") var memo = ""
    @AppStorage("godzillaDateMemory1") var dateDouble = 0.0
}


// //// メモリー2
class GodzillaMemory2: ObservableObject {
    @AppStorage("godzillaTansakuCountMemory2") var tansakuCount: Int = 0
    @AppStorage("godzillaNormalGameMemory2") var normalGame: Int = 0
    @AppStorage("godzillaCzCharaCountRadonMemory2") var czCharaCountRadon: Int = 0
    @AppStorage("godzillaCzCharaCountGaiganMemory2") var czCharaCountGaigan: Int = 0
    @AppStorage("godzillaCzCharaCountBioranteMemory2") var czCharaCountBiorante: Int = 0
    @AppStorage("godzillaCzCharaCountDestoroiaMemory2") var czCharaCountDestoroia: Int = 0
    @AppStorage("godzillaCzCharaCountKingGidoraMemory2") var czCharaCountKingGidora: Int = 0
    @AppStorage("godzillaCzCharaCountSumMemory2") var czCharaCountSum: Int = 0
    @AppStorage("godzillaCzCountShuraiMemory2") var czCountShurai: Int = 0
    @AppStorage("godzillaCzCountBreakDownMemory2") var czCountBreakDown: Int = 0
    @AppStorage("godzillaCzCountSumMemory2") var czCountSum: Int = 0
    @AppStorage("godzillaAtCountMemory2") var atCount: Int = 0
    @AppStorage("godzillaBonusScreenCountDefaultMemory2") var bonusScreenCountDefault: Int = 0
    @AppStorage("godzillaBonusScreenCountKisuMemory2") var bonusScreenCountKisu: Int = 0
    @AppStorage("godzillaBonusScreenCountGusuMemory2") var bonusScreenCountGusu: Int = 0
    @AppStorage("godzillaBonusScreenCountKisuHighMemory2") var bonusScreenCountKisuHigh: Int = 0
    @AppStorage("godzillaBonusScreenCountGusuHighMemory2") var bonusScreenCountGusuHigh: Int = 0
    @AppStorage("godzillaBonusScreenCount4OverMemory2") var bonusScreenCount4Over: Int = 0
    @AppStorage("godzillaBonusScreenCount5OverMemory2") var bonusScreenCount5Over: Int = 0
    @AppStorage("godzillaBonusScreenCount6OverMemory2") var bonusScreenCount6Over: Int = 0
    @AppStorage("godzillaBonusScreenCountSumMemory2") var bonusScreenCountSum: Int = 0
    @AppStorage("godzillaExMovieCountDefaultMemory2") var exMovieCountDefault: Int = 0
    @AppStorage("godzillaExMovieCountHighJakuMemory2") var exMovieCountHighJaku: Int = 0
    @AppStorage("godzillaExMovieCountHighChuMemory2") var exMovieCountHighChu: Int = 0
    @AppStorage("godzillaExMovieCountHighKyoMemory2") var exMovieCountHighKyo: Int = 0
    @AppStorage("godzillaExMovieCount5OverMemory2") var exMovieCount5Over: Int = 0
    @AppStorage("godzillaExMovieCountSumMemory2") var exMovieCountSum: Int = 0
    @AppStorage("godzillaMemoMemory2") var memo = ""
    @AppStorage("godzillaDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class GodzillaMemory3: ObservableObject {
    @AppStorage("godzillaTansakuCountMemory3") var tansakuCount: Int = 0
    @AppStorage("godzillaNormalGameMemory3") var normalGame: Int = 0
    @AppStorage("godzillaCzCharaCountRadonMemory3") var czCharaCountRadon: Int = 0
    @AppStorage("godzillaCzCharaCountGaiganMemory3") var czCharaCountGaigan: Int = 0
    @AppStorage("godzillaCzCharaCountBioranteMemory3") var czCharaCountBiorante: Int = 0
    @AppStorage("godzillaCzCharaCountDestoroiaMemory3") var czCharaCountDestoroia: Int = 0
    @AppStorage("godzillaCzCharaCountKingGidoraMemory3") var czCharaCountKingGidora: Int = 0
    @AppStorage("godzillaCzCharaCountSumMemory3") var czCharaCountSum: Int = 0
    @AppStorage("godzillaCzCountShuraiMemory3") var czCountShurai: Int = 0
    @AppStorage("godzillaCzCountBreakDownMemory3") var czCountBreakDown: Int = 0
    @AppStorage("godzillaCzCountSumMemory3") var czCountSum: Int = 0
    @AppStorage("godzillaAtCountMemory3") var atCount: Int = 0
    @AppStorage("godzillaBonusScreenCountDefaultMemory3") var bonusScreenCountDefault: Int = 0
    @AppStorage("godzillaBonusScreenCountKisuMemory3") var bonusScreenCountKisu: Int = 0
    @AppStorage("godzillaBonusScreenCountGusuMemory3") var bonusScreenCountGusu: Int = 0
    @AppStorage("godzillaBonusScreenCountKisuHighMemory3") var bonusScreenCountKisuHigh: Int = 0
    @AppStorage("godzillaBonusScreenCountGusuHighMemory3") var bonusScreenCountGusuHigh: Int = 0
    @AppStorage("godzillaBonusScreenCount4OverMemory3") var bonusScreenCount4Over: Int = 0
    @AppStorage("godzillaBonusScreenCount5OverMemory3") var bonusScreenCount5Over: Int = 0
    @AppStorage("godzillaBonusScreenCount6OverMemory3") var bonusScreenCount6Over: Int = 0
    @AppStorage("godzillaBonusScreenCountSumMemory3") var bonusScreenCountSum: Int = 0
    @AppStorage("godzillaExMovieCountDefaultMemory3") var exMovieCountDefault: Int = 0
    @AppStorage("godzillaExMovieCountHighJakuMemory3") var exMovieCountHighJaku: Int = 0
    @AppStorage("godzillaExMovieCountHighChuMemory3") var exMovieCountHighChu: Int = 0
    @AppStorage("godzillaExMovieCountHighKyoMemory3") var exMovieCountHighKyo: Int = 0
    @AppStorage("godzillaExMovieCount5OverMemory3") var exMovieCount5Over: Int = 0
    @AppStorage("godzillaExMovieCountSumMemory3") var exMovieCountSum: Int = 0
    @AppStorage("godzillaMemoMemory3") var memo = ""
    @AppStorage("godzillaDateMemory3") var dateDouble = 0.0
}
