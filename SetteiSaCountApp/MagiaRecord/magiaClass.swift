//
//  magiaClass.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2025/04/06.
//

import Foundation
import SwiftUI
import TipKit

class Magia: ObservableObject {
    // ////////////////////////
    // 通常時
    // ////////////////////////
    let ratioJakuCherry: [Double] = [60,57.7,55.5,53.5,51.7,50]
    let ratioSuikaCz: [Double] = [19.9,22.3,24.6,27.3,30.1,32.8]
    @AppStorage("magiaSuikaCzCountSuika") var suikaCzCountSuika: Int = 0
    @AppStorage("magiaSuikaCzCountCz") var suikaCzCountCz: Int = 0
    
    func resetNormal() {
        suikaCzCountSuika = 0
        suikaCzCountCz = 0
        minusCheck = false
        
        mgmTransferCountIroha = 0
        mgmTransferCountYachiyo = 0
        mgmTransferCountTsuruno = 0
        mgmTransferCountFerishia = 0
        mgmTransferCountSana = 0
        mgmTransferCountKuroe = 0
        mgmRisingCountIroha = 0
        mgmRisingCountYachiyo = 0
        mgmRisingCountTsuruno = 0
        mgmRisingCountFerishia = 0
        mgmRisingCountSana = 0
        mgmRisingCountKuroe = 0
    }
    
    // ////////////////////////
    // BIG終了画面
    // ////////////////////////
    @AppStorage("magiaBigScreenCountDefault") var bigScreenCountDefault: Int = 0 {
        didSet {
            bigScreenCountSum = countSum(bigScreenCount356, bigScreenCount246, bigScreenCountHigh1, bigScreenCountHigh2,bigScreenCountDefault, bigScreenCountOver2, bigScreenCountOver4, bigScreenCountOver5, bigScreenCountOver6)
        }
    }
        @AppStorage("magiaBigScreenCount356") var bigScreenCount356: Int = 0 {
            didSet {
                bigScreenCountSum = countSum(bigScreenCount356, bigScreenCount246, bigScreenCountHigh1, bigScreenCountHigh2,bigScreenCountDefault, bigScreenCountOver2, bigScreenCountOver4, bigScreenCountOver5, bigScreenCountOver6)
            }
        }
            @AppStorage("magiaBigScreenCount246") var bigScreenCount246: Int = 0 {
                didSet {
                    bigScreenCountSum = countSum(bigScreenCount356, bigScreenCount246, bigScreenCountHigh1, bigScreenCountHigh2,bigScreenCountDefault, bigScreenCountOver2, bigScreenCountOver4, bigScreenCountOver5, bigScreenCountOver6)
                }
            }
                @AppStorage("magiaBigScreenCountHigh1") var bigScreenCountHigh1: Int = 0 {
                    didSet {
                        bigScreenCountSum = countSum(bigScreenCount356, bigScreenCount246, bigScreenCountHigh1, bigScreenCountHigh2,bigScreenCountDefault, bigScreenCountOver2, bigScreenCountOver4, bigScreenCountOver5, bigScreenCountOver6)
                    }
                }
                    @AppStorage("magiaBigScreenCountHigh2") var bigScreenCountHigh2: Int = 0 {
                        didSet {
                            bigScreenCountSum = countSum(bigScreenCount356, bigScreenCount246, bigScreenCountHigh1, bigScreenCountHigh2,bigScreenCountDefault, bigScreenCountOver2, bigScreenCountOver4, bigScreenCountOver5, bigScreenCountOver6)
                        }
                    }
    @AppStorage("magiaBigScreenCountSum") var bigScreenCountSum: Int = 0
    
    func resetBigScreen() {
        bigScreenCountDefault = 0
        bigScreenCount356 = 0
        bigScreenCount246 = 0
        bigScreenCountHigh1 = 0
        bigScreenCountHigh2 = 0
        minusCheck = false
        
        bigScreenCountOver2 = 0
        bigScreenCountOver4 = 0
        bigScreenCountOver5 = 0
        bigScreenCountOver6 = 0
    }
    
    // ////////////////////////
    // 初当り
    // ////////////////////////
    let ratioBonus: [Double] = [240.6,236.1,222.8,208.5,195.1,184.3]
    let ratioAt: [Double] = [654.6,633.4,571.8,516.6,456.5,416.7]
    @AppStorage("magiaNormalPlayGame") var normalPlayGame: Int = 0
    @AppStorage("magiaBonusCountBig") var bonusCountBig : Int = 0 {
        didSet {
            bonusCountSum = countSum(bonusCountBig, bonusCountMitama, bonusCountEpisode)
        }
    }
        @AppStorage("magiaBonusCountMitama") var bonusCountMitama : Int = 0 {
            didSet {
                bonusCountSum = countSum(bonusCountBig, bonusCountMitama, bonusCountEpisode)
            }
        }
            @AppStorage("magiaBonusCountEpisode") var bonusCountEpisode : Int = 0 {
                didSet {
                    bonusCountSum = countSum(bonusCountBig, bonusCountMitama, bonusCountEpisode)
                }
            }
    @AppStorage("magiaBonusCountSum") var bonusCountSum : Int = 0
    @AppStorage("magiaAtCount") var atCount : Int = 0
    
    func resetFirstHit() {
        normalPlayGame = 0
        bonusCountBig = 0
        bonusCountMitama = 0
        bonusCountEpisode = 0
        atCount = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // AT終了画面
    // ////////////////////////
    @AppStorage("magiaAtScreenCountDefault") var atScreenCountDefault: Int = 0 {
        didSet {
            atScreenCountSum = countSum(atScreenCountDefault, atScreenCount356, atScreenCount246, atScreenCountOver6)
        }
    }
        @AppStorage("magiaAtScreenCount356") var atScreenCount356: Int = 0 {
            didSet {
                atScreenCountSum = countSum(atScreenCountDefault, atScreenCount356, atScreenCount246, atScreenCountOver6)
            }
        }
            @AppStorage("magiaAtScreenCount246") var atScreenCount246: Int = 0 {
                didSet {
                    atScreenCountSum = countSum(atScreenCountDefault, atScreenCount356, atScreenCount246, atScreenCountOver6)
                }
            }
    @AppStorage("magiaAtScreenCountSum") var atScreenCountSum: Int = 0
    
    func resetAtScreen() {
        atScreenCountDefault = 0
        atScreenCount356 = 0
        atScreenCount246 = 0
        atScreenCountOver6 = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // 共通
    // ////////////////////////
    @AppStorage("magiaMinusCheck") var minusCheck: Bool = false
    @AppStorage("magiaSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormal()
        resetBigScreen()
        resetAtScreen()
        resetFirstHit()
        resetKokakuStart()
        resetEnding()
    }
    
    // ///////////////////////
    // ver2.8.0で追加
    // ///////////////////////
    
    // //////////////
    // 高確スタート
    // //////////////
    @AppStorage("magiaKokakuStartAfterAtCountNone") var kokakuStartAfterAtCountNone: Int = 0 {
        didSet {
            kokakuStartAfterAtCountSum = countSum(kokakuStartAfterAtCountNone, kokakuStartAfterAtCountHit)
        }
    }
        @AppStorage("magiaKokakuStartAfterAtCountHit") var kokakuStartAfterAtCountHit: Int = 0 {
            didSet {
                kokakuStartAfterAtCountSum = countSum(kokakuStartAfterAtCountNone, kokakuStartAfterAtCountHit)
            }
        }
    @AppStorage("magiaKokakuStartAfterAtCountSum") var kokakuStartAfterAtCountSum: Int = 0
    @AppStorage("magiaKokakuStartAfterBonusCountNone") var kokakuStartAfterBonusCountNone: Int = 0 {
        didSet {
            kokakuStartAfterBonusCountSum = countSum(kokakuStartAfterBonusCountNone, kokakuStartAfterBonusCountHit)
        }
    }
        @AppStorage("magiaKokakuStartAfterBonusCountHit") var kokakuStartAfterBonusCountHit: Int = 0 {
            didSet {
                kokakuStartAfterBonusCountSum = countSum(kokakuStartAfterBonusCountNone, kokakuStartAfterBonusCountHit)
            }
        }
    @AppStorage("magiaKokakuStartAfterBonusCountSum") var kokakuStartAfterBonusCountSum: Int = 0
    
    let ratioKokakuStartAfterAtTotal: [Double] = [25,25,27.7,29.3,30.5,33.7]
    let ratioKokakuStartAfterAt10G: [Double] = [14.1,14.1,15.6,16.4,17.2,18.8]
    let ratioKokakuStartAfterAt20G: [Double] = [7.8,7.8,8.6,9.0,9.4,10.2]
    let ratioKokakuStartAfterAt30G: [Double] = [3.1,3.1,3.5,3.9,3.9,4.7]
    let ratioKokakuStartAfterBonusTotal: [Double] = [33.7,33.7,36.4,40.6,45.3,50.0]
    let ratioKokakuStartAfterBonus10G: [Double] = [18.8,18.8,20.3,22.7,25.0,27.3]
    let ratioKokakuStartAfterBonus20G: [Double] = [13.3,13.3,14.1,15.6,17.2,18.8]
    let ratioKokakuStartAfterBonus30G: [Double] = [1.6,1.6,2.0,2.3,3.1,3.9]
    
    func resetKokakuStart() {
        kokakuStartAfterAtCountNone = 0
        kokakuStartAfterAtCountHit = 0
        kokakuStartAfterBonusCountNone = 0
        kokakuStartAfterBonusCountHit = 0
        minusCheck = false
    }
    
    // ///////////////////
    // エンディング
    // ///////////////////
    @AppStorage("magiaEndingCountKisu") var endingCountKisu: Int = 0 {
        didSet {
            endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountHigh, endingCountKisuKyo, endingCountGusuKyo, endingCountHighKyo, endingCountNegate2, endingCountNegate3, endingCountNegate4, endingCountNegate1High, endingCountNegate4High, endingCountOver4)
        }
    }
        @AppStorage("magiaEndingCountGusu") var endingCountGusu: Int = 0 {
            didSet {
                endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountHigh, endingCountKisuKyo, endingCountGusuKyo, endingCountHighKyo, endingCountNegate2, endingCountNegate3, endingCountNegate4, endingCountNegate1High, endingCountNegate4High, endingCountOver4)
            }
        }
            @AppStorage("magiaEndingCountHigh") var endingCountHigh: Int = 0 {
                didSet {
                    endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountHigh, endingCountKisuKyo, endingCountGusuKyo, endingCountHighKyo, endingCountNegate2, endingCountNegate3, endingCountNegate4, endingCountNegate1High, endingCountNegate4High, endingCountOver4)
                }
            }
    @AppStorage("magiaEndingCountSum") var endingCountSum: Int = 0
    
    func resetEnding() {
        endingCountKisu = 0
        endingCountGusu = 0
        endingCountHigh = 0
        endingCountKisuKyo = 0
        endingCountGusuKyo = 0
        endingCountHighKyo = 0
        endingCountNegate2 = 0
        endingCountNegate3 = 0
        endingCountNegate4 = 0
        endingCountNegate1High = 0
        endingCountNegate4High = 0
        endingCountOver4 = 0
        minusCheck = false
    }
    
    // ///////////////////
    // ver3.0.0で追加
    // ///////////////////
    @AppStorage("magiaBigScreenCountOver2") var bigScreenCountOver2: Int = 0 {
        didSet {
            bigScreenCountSum = countSum(bigScreenCount356, bigScreenCount246, bigScreenCountHigh1, bigScreenCountHigh2,bigScreenCountDefault, bigScreenCountOver2, bigScreenCountOver4, bigScreenCountOver5, bigScreenCountOver6)
        }
    }
        @AppStorage("magiaBigScreenCountOver4") var bigScreenCountOver4: Int = 0 {
            didSet {
                bigScreenCountSum = countSum(bigScreenCount356, bigScreenCount246, bigScreenCountHigh1, bigScreenCountHigh2,bigScreenCountDefault, bigScreenCountOver2, bigScreenCountOver4, bigScreenCountOver5, bigScreenCountOver6)
            }
        }
            @AppStorage("magiaBigScreenCountOver5") var bigScreenCountOver5: Int = 0 {
                didSet {
                    bigScreenCountSum = countSum(bigScreenCount356, bigScreenCount246, bigScreenCountHigh1, bigScreenCountHigh2,bigScreenCountDefault, bigScreenCountOver2, bigScreenCountOver4, bigScreenCountOver5, bigScreenCountOver6)
                }
            }
                @AppStorage("magiaBigScreenCountOver6") var bigScreenCountOver6: Int = 0 {
                    didSet {
                        bigScreenCountSum = countSum(bigScreenCount356, bigScreenCount246, bigScreenCountHigh1, bigScreenCountHigh2,bigScreenCountDefault, bigScreenCountOver2, bigScreenCountOver4, bigScreenCountOver5, bigScreenCountOver6)
                    }
                }
    
    // //////////////
    // ver3.1.0で追加
    // //////////////
    @AppStorage("magiaEndingCountKisuKyo") var endingCountKisuKyo: Int = 0 {
        didSet {
            endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountHigh, endingCountKisuKyo, endingCountGusuKyo, endingCountHighKyo, endingCountNegate2, endingCountNegate3, endingCountNegate4, endingCountNegate1High, endingCountNegate4High, endingCountOver4)
        }
    }
        @AppStorage("magiaEndingCountGusuKyo") var endingCountGusuKyo: Int = 0 {
            didSet {
                endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountHigh, endingCountKisuKyo, endingCountGusuKyo, endingCountHighKyo, endingCountNegate2, endingCountNegate3, endingCountNegate4, endingCountNegate1High, endingCountNegate4High, endingCountOver4)
            }
        }
            @AppStorage("magiaEndingCountHighKyo") var endingCountHighKyo: Int = 0 {
                didSet {
                    endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountHigh, endingCountKisuKyo, endingCountGusuKyo, endingCountHighKyo, endingCountNegate2, endingCountNegate3, endingCountNegate4, endingCountNegate1High, endingCountNegate4High, endingCountOver4)
                }
            }
                @AppStorage("magiaEndingCountNegate2") var endingCountNegate2: Int = 0 {
                    didSet {
                        endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountHigh, endingCountKisuKyo, endingCountGusuKyo, endingCountHighKyo, endingCountNegate2, endingCountNegate3, endingCountNegate4, endingCountNegate1High, endingCountNegate4High, endingCountOver4)
                    }
                }
                    @AppStorage("magiaEndingCountNegate3") var endingCountNegate3: Int = 0 {
                        didSet {
                            endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountHigh, endingCountKisuKyo, endingCountGusuKyo, endingCountHighKyo, endingCountNegate2, endingCountNegate3, endingCountNegate4, endingCountNegate1High, endingCountNegate4High, endingCountOver4)
                        }
                    }
                        @AppStorage("magiaEndingCountNegate4") var endingCountNegate4: Int = 0 {
                            didSet {
                                endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountHigh, endingCountKisuKyo, endingCountGusuKyo, endingCountHighKyo, endingCountNegate2, endingCountNegate3, endingCountNegate4, endingCountNegate1High, endingCountNegate4High, endingCountOver4)
                            }
                        }
                            @AppStorage("magiaEndingCountNegate1High") var endingCountNegate1High: Int = 0 {
                                didSet {
                                    endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountHigh, endingCountKisuKyo, endingCountGusuKyo, endingCountHighKyo, endingCountNegate2, endingCountNegate3, endingCountNegate4, endingCountNegate1High, endingCountNegate4High, endingCountOver4)
                                }
                            }
                                @AppStorage("magiaEndingCountNegate4High") var endingCountNegate4High: Int = 0 {
                                    didSet {
                                        endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountHigh, endingCountKisuKyo, endingCountGusuKyo, endingCountHighKyo, endingCountNegate2, endingCountNegate3, endingCountNegate4, endingCountNegate1High, endingCountNegate4High, endingCountOver4)
                                    }
                                }
                                    @AppStorage("magiaEndingCountOver4") var endingCountOver4: Int = 0 {
                                        didSet {
                                            endingCountSum = countSum(endingCountKisu, endingCountGusu, endingCountHigh, endingCountKisuKyo, endingCountGusuKyo, endingCountHighKyo, endingCountNegate2, endingCountNegate3, endingCountNegate4, endingCountNegate1High, endingCountNegate4High, endingCountOver4)
                                        }
                                    }
    
    // //// AT終了画面追加
    @AppStorage("magiaAtScreenCountOver6") var atScreenCountOver6: Int = 0 {
        didSet {
            atScreenCountSum = countSum(atScreenCountDefault, atScreenCount356, atScreenCount246, atScreenCountOver6)
        }
    }
    
    // //// CZ確率詳細
    let ratioCzKuroeNegateSana: [Double] = [0.4,0.8]
    let ratioCzNegateSanaSum: [Double] = [20.3,22.7,25.0,28.1,30.9,33.6]
    let ratioCzMagiaSana: [Double] = [48.4]
    let ratioCzKuroeSana: [Double] = [1.6]
    
    // //// 魔法少女モードのカウント
    let ratioMgmTransferIroha: [Double] = [75,73.4,68.4,61.7,54.7,50]
    let ratioMgmTransferYachiyo: [Double] = [5.5,6.3,9.4,10.9]
    let ratioMgmTransferTsuruno: [Double] = [5.5,7.8,10.9]
    let ratioMgmTransferSana: [Double] = [5.5,6.3,9.4,10.9]
    let ratioMgmTransferFerishia: [Double] = [5.5,7.8,10.9]
    let ratioMgmTransferKuroe: [Double] = [3.1,3.5,3.9,4.7,6.3]
    let ratioMgmRisingIroha: [Double] = [77.7,74.2,70.3,66.4,64.1]
    let ratioMgmRisingYachiyo: [Double] = [4.7,6.3,7.0]
    let ratioMgmRisingTsuruno: [Double] = [3.9,5.5,7.0]
    let ratioMgmRisingSana: [Double] = [4.7,6.3,7]
    let ratioMgmRisingFerishia: [Double] = [3.9,5.5,7]
    let ratioMgmRisingKuroe: [Double] = [5.1,5.5,6.3,7.0,7.8]
    @AppStorage("magiaMgmTransferCountIroha") var mgmTransferCountIroha: Int = 0 {
        didSet {
            mgmTransferCountSum = countSum(mgmTransferCountIroha, mgmTransferCountYachiyo, mgmTransferCountTsuruno, mgmTransferCountFerishia, mgmTransferCountSana, mgmTransferCountKuroe)
        }
    }
        @AppStorage("magiaMgmTransferCountYachiyo") var mgmTransferCountYachiyo: Int = 0 {
            didSet {
                mgmTransferCountSum = countSum(mgmTransferCountIroha, mgmTransferCountYachiyo, mgmTransferCountTsuruno, mgmTransferCountFerishia, mgmTransferCountSana, mgmTransferCountKuroe)
            }
        }
            @AppStorage("magiaMgmTransferCountTsuruno") var mgmTransferCountTsuruno: Int = 0 {
                didSet {
                    mgmTransferCountSum = countSum(mgmTransferCountIroha, mgmTransferCountYachiyo, mgmTransferCountTsuruno, mgmTransferCountFerishia, mgmTransferCountSana, mgmTransferCountKuroe)
                }
            }
                @AppStorage("magiaMgmTransferCountFerishia") var mgmTransferCountFerishia: Int = 0 {
                    didSet {
                        mgmTransferCountSum = countSum(mgmTransferCountIroha, mgmTransferCountYachiyo, mgmTransferCountTsuruno, mgmTransferCountFerishia, mgmTransferCountSana, mgmTransferCountKuroe)
                    }
                }
                    @AppStorage("magiaMgmTransferCountSana") var mgmTransferCountSana: Int = 0 {
                        didSet {
                            mgmTransferCountSum = countSum(mgmTransferCountIroha, mgmTransferCountYachiyo, mgmTransferCountTsuruno, mgmTransferCountFerishia, mgmTransferCountSana, mgmTransferCountKuroe)
                        }
                    }
                        @AppStorage("magiaMgmTransferCountKuroe") var mgmTransferCountKuroe: Int = 0 {
                            didSet {
                                mgmTransferCountSum = countSum(mgmTransferCountIroha, mgmTransferCountYachiyo, mgmTransferCountTsuruno, mgmTransferCountFerishia, mgmTransferCountSana, mgmTransferCountKuroe)
                            }
                        }
    @AppStorage("magiaMgmTransferCountSum") var mgmTransferCountSum: Int = 0
    @AppStorage("magiaMgmRisingCountIroha") var mgmRisingCountIroha: Int = 0 {
        didSet {
            mgmRisingCountSum = countSum(mgmRisingCountIroha, mgmRisingCountYachiyo, mgmRisingCountTsuruno, mgmRisingCountFerishia, mgmRisingCountSana, mgmRisingCountKuroe)
        }
    }
        @AppStorage("magiaMgmRisingCountYachiyo") var mgmRisingCountYachiyo: Int = 0 {
            didSet {
                mgmRisingCountSum = countSum(mgmRisingCountIroha, mgmRisingCountYachiyo, mgmRisingCountTsuruno, mgmRisingCountFerishia, mgmRisingCountSana, mgmRisingCountKuroe)
            }
        }
            @AppStorage("magiaMgmRisingCountTsuruno") var mgmRisingCountTsuruno: Int = 0 {
                didSet {
                    mgmRisingCountSum = countSum(mgmRisingCountIroha, mgmRisingCountYachiyo, mgmRisingCountTsuruno, mgmRisingCountFerishia, mgmRisingCountSana, mgmRisingCountKuroe)
                }
            }
                @AppStorage("magiaMgmRisingCountFerishia") var mgmRisingCountFerishia: Int = 0 {
                    didSet {
                        mgmRisingCountSum = countSum(mgmRisingCountIroha, mgmRisingCountYachiyo, mgmRisingCountTsuruno, mgmRisingCountFerishia, mgmRisingCountSana, mgmRisingCountKuroe)
                    }
                }
                    @AppStorage("magiaMgmRisingCountSana") var mgmRisingCountSana: Int = 0 {
                        didSet {
                            mgmRisingCountSum = countSum(mgmRisingCountIroha, mgmRisingCountYachiyo, mgmRisingCountTsuruno, mgmRisingCountFerishia, mgmRisingCountSana, mgmRisingCountKuroe)
                        }
                    }
                        @AppStorage("magiaMgmRisingCountKuroe") var mgmRisingCountKuroe: Int = 0 {
                            didSet {
                                mgmRisingCountSum = countSum(mgmRisingCountIroha, mgmRisingCountYachiyo, mgmRisingCountTsuruno, mgmRisingCountFerishia, mgmRisingCountSana, mgmRisingCountKuroe)
                            }
                        }
    @AppStorage("magiaMgmRisingCountSum") var mgmRisingCountSum: Int = 0
}


// //// メモリー1
class MagiaMemory1: ObservableObject {
    @AppStorage("magiaSuikaCzCountSuikaMemory1") var suikaCzCountSuika: Int = 0
    @AppStorage("magiaSuikaCzCountCzMemory1") var suikaCzCountCz: Int = 0
    @AppStorage("magiaBigScreenCountDefaultMemory1") var bigScreenCountDefault: Int = 0
    @AppStorage("magiaBigScreenCount356Memory1") var bigScreenCount356: Int = 0
    @AppStorage("magiaBigScreenCount246Memory1") var bigScreenCount246: Int = 0
    @AppStorage("magiaBigScreenCountHigh1Memory1") var bigScreenCountHigh1: Int = 0
    @AppStorage("magiaBigScreenCountHigh2Memory1") var bigScreenCountHigh2: Int = 0
    @AppStorage("magiaBigScreenCountSumMemory1") var bigScreenCountSum: Int = 0
    @AppStorage("magiaNormalPlayGameMemory1") var normalPlayGame: Int = 0
    @AppStorage("magiaBonusCountBigMemory1") var bonusCountBig : Int = 0
    @AppStorage("magiaBonusCountMitamaMemory1") var bonusCountMitama : Int = 0
    @AppStorage("magiaBonusCountEpisodeMemory1") var bonusCountEpisode : Int = 0
    @AppStorage("magiaBonusCountSumMemory1") var bonusCountSum : Int = 0
    @AppStorage("magiaAtCountMemory1") var atCount : Int = 0
    @AppStorage("magiaAtScreenCountDefaultMemory1") var atScreenCountDefault: Int = 0
    @AppStorage("magiaAtScreenCount356Memory1") var atScreenCount356: Int = 0
    @AppStorage("magiaAtScreenCount246Memory1") var atScreenCount246: Int = 0
    @AppStorage("magiaAtScreenCountSumMemory1") var atScreenCountSum: Int = 0
    @AppStorage("magiaMemoMemory1") var memo = ""
    @AppStorage("magiaDateMemory1") var dateDouble = 0.0
    
    // ///////////////////////
    // ver2.8.0で追加
    // ///////////////////////
    @AppStorage("magiaKokakuStartAfterAtCountNoneMemory1") var kokakuStartAfterAtCountNone: Int = 0
    @AppStorage("magiaKokakuStartAfterAtCountHitMemory1") var kokakuStartAfterAtCountHit: Int = 0
    @AppStorage("magiaKokakuStartAfterAtCountSumMemory1") var kokakuStartAfterAtCountSum: Int = 0
    @AppStorage("magiaKokakuStartAfterBonusCountNoneMemory1") var kokakuStartAfterBonusCountNone: Int = 0
    @AppStorage("magiaKokakuStartAfterBonusCountHitMemory1") var kokakuStartAfterBonusCountHit: Int = 0
    @AppStorage("magiaKokakuStartAfterBonusCountSumMemory1") var kokakuStartAfterBonusCountSum: Int = 0
    @AppStorage("magiaEndingCountKisuMemory1") var endingCountKisu: Int = 0
    @AppStorage("magiaEndingCountGusuMemory1") var endingCountGusu: Int = 0
    @AppStorage("magiaEndingCountHighMemory1") var endingCountHigh: Int = 0
    @AppStorage("magiaEndingCountSumMemory1") var endingCountSum: Int = 0
    
    // ///////////////////
    // ver3.0.0で追加
    // ///////////////////
    @AppStorage("magiaBigScreenCountOver2Memory1") var bigScreenCountOver2: Int = 0
    @AppStorage("magiaBigScreenCountOver4Memory1") var bigScreenCountOver4: Int = 0
    @AppStorage("magiaBigScreenCountOver5Memory1") var bigScreenCountOver5: Int = 0
    @AppStorage("magiaBigScreenCountOver6Memory1") var bigScreenCountOver6: Int = 0
    
    // //////////////
    // ver3.1.0で追加
    // //////////////
    @AppStorage("magiaEndingCountKisuKyoMemory1") var endingCountKisuKyo: Int = 0
    @AppStorage("magiaEndingCountGusuKyoMemory1") var endingCountGusuKyo: Int = 0
    @AppStorage("magiaEndingCountHighKyoMemory1") var endingCountHighKyo: Int = 0
    @AppStorage("magiaEndingCountNegate2Memory1") var endingCountNegate2: Int = 0
    @AppStorage("magiaEndingCountNegate3Memory1") var endingCountNegate3: Int = 0
    @AppStorage("magiaEndingCountNegate4Memory1") var endingCountNegate4: Int = 0
    @AppStorage("magiaEndingCountNegate1HighMemory1") var endingCountNegate1High: Int = 0
    @AppStorage("magiaEndingCountNegate4HighMemory1") var endingCountNegate4High: Int = 0
    @AppStorage("magiaEndingCountOver4Memory1") var endingCountOver4: Int = 0
    @AppStorage("magiaAtScreenCountOver6Memory1") var atScreenCountOver6: Int = 0
    @AppStorage("magiaMgmTransferCountIrohaMemory1") var mgmTransferCountIroha: Int = 0
    @AppStorage("magiaMgmTransferCountYachiyoMemory1") var mgmTransferCountYachiyo: Int = 0
    @AppStorage("magiaMgmTransferCountTsurunoMemory1") var mgmTransferCountTsuruno: Int = 0
    @AppStorage("magiaMgmTransferCountFerishiaMemory1") var mgmTransferCountFerishia: Int = 0
    @AppStorage("magiaMgmTransferCountSanaMemory1") var mgmTransferCountSana: Int = 0
    @AppStorage("magiaMgmTransferCountKuroeMemory1") var mgmTransferCountKuroe: Int = 0
    @AppStorage("magiaMgmTransferCountSumMemory1") var mgmTransferCountSum: Int = 0
    @AppStorage("magiaMgmRisingCountIrohaMemory1") var mgmRisingCountIroha: Int = 0
    @AppStorage("magiaMgmRisingCountYachiyoMemory1") var mgmRisingCountYachiyo: Int = 0
    @AppStorage("magiaMgmRisingCountTsurunoMemory1") var mgmRisingCountTsuruno: Int = 0
    @AppStorage("magiaMgmRisingCountFerishiaMemory1") var mgmRisingCountFerishia: Int = 0
    @AppStorage("magiaMgmRisingCountSanaMemory1") var mgmRisingCountSana: Int = 0
    @AppStorage("magiaMgmRisingCountKuroeMemory1") var mgmRisingCountKuroe: Int = 0
    @AppStorage("magiaMgmRisingCountSumMemory1") var mgmRisingCountSum: Int = 0
}


// //// メモリー2
class MagiaMemory2: ObservableObject {
    @AppStorage("magiaSuikaCzCountSuikaMemory2") var suikaCzCountSuika: Int = 0
    @AppStorage("magiaSuikaCzCountCzMemory2") var suikaCzCountCz: Int = 0
    @AppStorage("magiaBigScreenCountDefaultMemory2") var bigScreenCountDefault: Int = 0
    @AppStorage("magiaBigScreenCount356Memory2") var bigScreenCount356: Int = 0
    @AppStorage("magiaBigScreenCount246Memory2") var bigScreenCount246: Int = 0
    @AppStorage("magiaBigScreenCountHigh1Memory2") var bigScreenCountHigh1: Int = 0
    @AppStorage("magiaBigScreenCountHigh2Memory2") var bigScreenCountHigh2: Int = 0
    @AppStorage("magiaBigScreenCountSumMemory2") var bigScreenCountSum: Int = 0
    @AppStorage("magiaNormalPlayGameMemory2") var normalPlayGame: Int = 0
    @AppStorage("magiaBonusCountBigMemory2") var bonusCountBig : Int = 0
    @AppStorage("magiaBonusCountMitamaMemory2") var bonusCountMitama : Int = 0
    @AppStorage("magiaBonusCountEpisodeMemory2") var bonusCountEpisode : Int = 0
    @AppStorage("magiaBonusCountSumMemory2") var bonusCountSum : Int = 0
    @AppStorage("magiaAtCountMemory2") var atCount : Int = 0
    @AppStorage("magiaAtScreenCountDefaultMemory2") var atScreenCountDefault: Int = 0
    @AppStorage("magiaAtScreenCount356Memory2") var atScreenCount356: Int = 0
    @AppStorage("magiaAtScreenCount246Memory2") var atScreenCount246: Int = 0
    @AppStorage("magiaAtScreenCountSumMemory2") var atScreenCountSum: Int = 0
    @AppStorage("magiaMemoMemory2") var memo = ""
    @AppStorage("magiaDateMemory2") var dateDouble = 0.0
    
    // ///////////////////////
    // ver2.8.0で追加
    // ///////////////////////
    @AppStorage("magiaKokakuStartAfterAtCountNoneMemory2") var kokakuStartAfterAtCountNone: Int = 0
    @AppStorage("magiaKokakuStartAfterAtCountHitMemory2") var kokakuStartAfterAtCountHit: Int = 0
    @AppStorage("magiaKokakuStartAfterAtCountSumMemory2") var kokakuStartAfterAtCountSum: Int = 0
    @AppStorage("magiaKokakuStartAfterBonusCountNoneMemory2") var kokakuStartAfterBonusCountNone: Int = 0
    @AppStorage("magiaKokakuStartAfterBonusCountHitMemory2") var kokakuStartAfterBonusCountHit: Int = 0
    @AppStorage("magiaKokakuStartAfterBonusCountSumMemory2") var kokakuStartAfterBonusCountSum: Int = 0
    @AppStorage("magiaEndingCountKisuMemory2") var endingCountKisu: Int = 0
    @AppStorage("magiaEndingCountGusuMemory2") var endingCountGusu: Int = 0
    @AppStorage("magiaEndingCountHighMemory2") var endingCountHigh: Int = 0
    @AppStorage("magiaEndingCountSumMemory2") var endingCountSum: Int = 0
    
    // ///////////////////
    // ver3.0.0で追加
    // ///////////////////
    @AppStorage("magiaBigScreenCountOver2Memory2") var bigScreenCountOver2: Int = 0
    @AppStorage("magiaBigScreenCountOver4Memory2") var bigScreenCountOver4: Int = 0
    @AppStorage("magiaBigScreenCountOver5Memory2") var bigScreenCountOver5: Int = 0
    @AppStorage("magiaBigScreenCountOver6Memory2") var bigScreenCountOver6: Int = 0
    
    // //////////////
    // ver3.1.0で追加
    // //////////////
    @AppStorage("magiaEndingCountKisuKyoMemory2") var endingCountKisuKyo: Int = 0
    @AppStorage("magiaEndingCountGusuKyoMemory2") var endingCountGusuKyo: Int = 0
    @AppStorage("magiaEndingCountHighKyoMemory2") var endingCountHighKyo: Int = 0
    @AppStorage("magiaEndingCountNegate2Memory2") var endingCountNegate2: Int = 0
    @AppStorage("magiaEndingCountNegate3Memory2") var endingCountNegate3: Int = 0
    @AppStorage("magiaEndingCountNegate4Memory2") var endingCountNegate4: Int = 0
    @AppStorage("magiaEndingCountNegate1HighMemory2") var endingCountNegate1High: Int = 0
    @AppStorage("magiaEndingCountNegate4HighMemory2") var endingCountNegate4High: Int = 0
    @AppStorage("magiaEndingCountOver4Memory2") var endingCountOver4: Int = 0
    @AppStorage("magiaAtScreenCountOver6Memory2") var atScreenCountOver6: Int = 0
    @AppStorage("magiaMgmTransferCountIrohaMemory2") var mgmTransferCountIroha: Int = 0
    @AppStorage("magiaMgmTransferCountYachiyoMemory2") var mgmTransferCountYachiyo: Int = 0
    @AppStorage("magiaMgmTransferCountTsurunoMemory2") var mgmTransferCountTsuruno: Int = 0
    @AppStorage("magiaMgmTransferCountFerishiaMemory2") var mgmTransferCountFerishia: Int = 0
    @AppStorage("magiaMgmTransferCountSanaMemory2") var mgmTransferCountSana: Int = 0
    @AppStorage("magiaMgmTransferCountKuroeMemory2") var mgmTransferCountKuroe: Int = 0
    @AppStorage("magiaMgmTransferCountSumMemory2") var mgmTransferCountSum: Int = 0
    @AppStorage("magiaMgmRisingCountIrohaMemory2") var mgmRisingCountIroha: Int = 0
    @AppStorage("magiaMgmRisingCountYachiyoMemory2") var mgmRisingCountYachiyo: Int = 0
    @AppStorage("magiaMgmRisingCountTsurunoMemory2") var mgmRisingCountTsuruno: Int = 0
    @AppStorage("magiaMgmRisingCountFerishiaMemory2") var mgmRisingCountFerishia: Int = 0
    @AppStorage("magiaMgmRisingCountSanaMemory2") var mgmRisingCountSana: Int = 0
    @AppStorage("magiaMgmRisingCountKuroeMemory2") var mgmRisingCountKuroe: Int = 0
    @AppStorage("magiaMgmRisingCountSumMemory2") var mgmRisingCountSum: Int = 0
}

// //// メモリー3
class MagiaMemory3: ObservableObject {
    @AppStorage("magiaSuikaCzCountSuikaMemory3") var suikaCzCountSuika: Int = 0
    @AppStorage("magiaSuikaCzCountCzMemory3") var suikaCzCountCz: Int = 0
    @AppStorage("magiaBigScreenCountDefaultMemory3") var bigScreenCountDefault: Int = 0
    @AppStorage("magiaBigScreenCount356Memory3") var bigScreenCount356: Int = 0
    @AppStorage("magiaBigScreenCount246Memory3") var bigScreenCount246: Int = 0
    @AppStorage("magiaBigScreenCountHigh1Memory3") var bigScreenCountHigh1: Int = 0
    @AppStorage("magiaBigScreenCountHigh2Memory3") var bigScreenCountHigh2: Int = 0
    @AppStorage("magiaBigScreenCountSumMemory3") var bigScreenCountSum: Int = 0
    @AppStorage("magiaNormalPlayGameMemory3") var normalPlayGame: Int = 0
    @AppStorage("magiaBonusCountBigMemory3") var bonusCountBig : Int = 0
    @AppStorage("magiaBonusCountMitamaMemory3") var bonusCountMitama : Int = 0
    @AppStorage("magiaBonusCountEpisodeMemory3") var bonusCountEpisode : Int = 0
    @AppStorage("magiaBonusCountSumMemory3") var bonusCountSum : Int = 0
    @AppStorage("magiaAtCountMemory3") var atCount : Int = 0
    @AppStorage("magiaAtScreenCountDefaultMemory3") var atScreenCountDefault: Int = 0
    @AppStorage("magiaAtScreenCount356Memory3") var atScreenCount356: Int = 0
    @AppStorage("magiaAtScreenCount246Memory3") var atScreenCount246: Int = 0
    @AppStorage("magiaAtScreenCountSumMemory3") var atScreenCountSum: Int = 0
    @AppStorage("magiaMemoMemory3") var memo = ""
    @AppStorage("magiaDateMemory3") var dateDouble = 0.0
    
    // ///////////////////////
    // ver2.8.0で追加
    // ///////////////////////
    @AppStorage("magiaKokakuStartAfterAtCountNoneMemory3") var kokakuStartAfterAtCountNone: Int = 0
    @AppStorage("magiaKokakuStartAfterAtCountHitMemory3") var kokakuStartAfterAtCountHit: Int = 0
    @AppStorage("magiaKokakuStartAfterAtCountSumMemory3") var kokakuStartAfterAtCountSum: Int = 0
    @AppStorage("magiaKokakuStartAfterBonusCountNoneMemory3") var kokakuStartAfterBonusCountNone: Int = 0
    @AppStorage("magiaKokakuStartAfterBonusCountHitMemory3") var kokakuStartAfterBonusCountHit: Int = 0
    @AppStorage("magiaKokakuStartAfterBonusCountSumMemory3") var kokakuStartAfterBonusCountSum: Int = 0
    @AppStorage("magiaEndingCountKisuMemory3") var endingCountKisu: Int = 0
    @AppStorage("magiaEndingCountGusuMemory3") var endingCountGusu: Int = 0
    @AppStorage("magiaEndingCountHighMemory3") var endingCountHigh: Int = 0
    @AppStorage("magiaEndingCountSumMemory3") var endingCountSum: Int = 0
    
    // ///////////////////
    // ver3.0.0で追加
    // ///////////////////
    @AppStorage("magiaBigScreenCountOver2Memory3") var bigScreenCountOver2: Int = 0
    @AppStorage("magiaBigScreenCountOver4Memory3") var bigScreenCountOver4: Int = 0
    @AppStorage("magiaBigScreenCountOver5Memory3") var bigScreenCountOver5: Int = 0
    @AppStorage("magiaBigScreenCountOver6Memory3") var bigScreenCountOver6: Int = 0
    
    // //////////////
    // ver3.1.0で追加
    // //////////////
    @AppStorage("magiaEndingCountKisuKyoMemory3") var endingCountKisuKyo: Int = 0
    @AppStorage("magiaEndingCountGusuKyoMemory3") var endingCountGusuKyo: Int = 0
    @AppStorage("magiaEndingCountHighKyoMemory3") var endingCountHighKyo: Int = 0
    @AppStorage("magiaEndingCountNegate2Memory3") var endingCountNegate2: Int = 0
    @AppStorage("magiaEndingCountNegate3Memory3") var endingCountNegate3: Int = 0
    @AppStorage("magiaEndingCountNegate4Memory3") var endingCountNegate4: Int = 0
    @AppStorage("magiaEndingCountNegate1HighMemory3") var endingCountNegate1High: Int = 0
    @AppStorage("magiaEndingCountNegate4HighMemory3") var endingCountNegate4High: Int = 0
    @AppStorage("magiaEndingCountOver4Memory3") var endingCountOver4: Int = 0
    @AppStorage("magiaAtScreenCountOver6Memory3") var atScreenCountOver6: Int = 0
    @AppStorage("magiaMgmTransferCountIrohaMemory3") var mgmTransferCountIroha: Int = 0
    @AppStorage("magiaMgmTransferCountYachiyoMemory3") var mgmTransferCountYachiyo: Int = 0
    @AppStorage("magiaMgmTransferCountTsurunoMemory3") var mgmTransferCountTsuruno: Int = 0
    @AppStorage("magiaMgmTransferCountFerishiaMemory3") var mgmTransferCountFerishia: Int = 0
    @AppStorage("magiaMgmTransferCountSanaMemory3") var mgmTransferCountSana: Int = 0
    @AppStorage("magiaMgmTransferCountKuroeMemory3") var mgmTransferCountKuroe: Int = 0
    @AppStorage("magiaMgmTransferCountSumMemory3") var mgmTransferCountSum: Int = 0
    @AppStorage("magiaMgmRisingCountIrohaMemory3") var mgmRisingCountIroha: Int = 0
    @AppStorage("magiaMgmRisingCountYachiyoMemory3") var mgmRisingCountYachiyo: Int = 0
    @AppStorage("magiaMgmRisingCountTsurunoMemory3") var mgmRisingCountTsuruno: Int = 0
    @AppStorage("magiaMgmRisingCountFerishiaMemory3") var mgmRisingCountFerishia: Int = 0
    @AppStorage("magiaMgmRisingCountSanaMemory3") var mgmRisingCountSana: Int = 0
    @AppStorage("magiaMgmRisingCountKuroeMemory3") var mgmRisingCountKuroe: Int = 0
    @AppStorage("magiaMgmRisingCountSumMemory3") var mgmRisingCountSum: Int = 0
}
