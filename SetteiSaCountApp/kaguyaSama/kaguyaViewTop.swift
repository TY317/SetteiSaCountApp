//
//  kaguyaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/10/12.
//

import SwiftUI
import TipKit

// ///////////////////////////
// 変数
// ///////////////////////////
class KaguyaSama: ObservableObject {
    // //////////////////////////
    // ボーナス振分
    // //////////////////////////
    @AppStorage("kaguyaFirstBonusCountBig") var firstBonusCountBig = 0 {
        didSet {
            firstBonusCountSum = countSum(firstBonusCountBig, firstBonusCountReg)
        }
    }
        @AppStorage("kaguyaFirstBonusCountReg") var firstBonusCountReg = 0 {
            didSet {
                firstBonusCountSum = countSum(firstBonusCountBig, firstBonusCountReg)
            }
        }
    @AppStorage("kaguyaFirstBonusCountSum") var firstBonusCountSum = 0
    @AppStorage("kaguyaBigCountNormal") var bigCountNormal = 0 {
        didSet {
            bigCountSum = countSum(bigCountNormal, bigCountSuper, bigCountExtra)
        }
    }
        @AppStorage("kaguyaBigCountSuper") var bigCountSuper = 0 {
            didSet {
                bigCountSum = countSum(bigCountNormal, bigCountSuper, bigCountExtra)
            }
        }
            @AppStorage("kaguyaBigCountExtra") var bigCountExtra = 0 {
                didSet {
                    bigCountSum = countSum(bigCountNormal, bigCountSuper, bigCountExtra)
                }
            }
    @AppStorage("kaguyaBigCountSum") var bigCountSum = 0
    
    func resetBonus() {
        firstBonusCountBig = 0
        firstBonusCountReg = 0
        bigCountNormal = 0
        bigCountSuper = 0
        bigCountExtra = 0
        minusCheck = false
        bigCountUnder3Blue = 0
        bigCountUnder3Red = 0
        bigCount4to6Blue = 0
        bigCount4to6Red = 0
        bigCountOver7Blue = 0
        bigCountOver7Red = 0
    }
    
    // //////////////////////////
    // REG中のキャラ紹介
    // //////////////////////////
    let regCharaSelectListFirst: [String] = ["かぐや", "白銀", "かぐや(虹背景)"]
    @AppStorage("kaguyaRegCharaSelectedFirst") var regCharaSelectedFirst: String = "白銀"
    let regCharaSelectListSecondAfterKaguya: [String] = ["白銀", "白銀パパ", "藤原", "大仏"]
    @AppStorage("kaguyaRegCharaSelectedSecondAfterKaguya") var regCharaSelectedSecondAfterKaguya: String = "白銀"
    let regCharaSelectListSecondAfterShirogane: [String] = ["かぐや", "白銀圭", "ベツィー"]
    @AppStorage("kaguyaRegCharaSelectedSecondAfterShirogane") var regCharaSelectedSecondAfterShirogane: String = "かぐや"
    let regCharaSelectListSecondAfterRainbow: [String] = ["白銀(虹背景)"]
    @AppStorage("kaguyaRegCharaSelectedSecondAfterRainbow") var regCharaSelectedSecondAfterRainbow: String = "白銀(虹背景)"
    @AppStorage("kaguyaRegCharaCountDefault") var regCharaCountDefault = 0 {
        didSet {
            regCharaCountSum = countSum(regCharaCountDefault, regCharaCountKei, regCharaCountPapa, regCharaCountHayasaka, regCharaCountRainbow, regCharaCountOsaragi, regCharaCountBezi)
        }
    }
        @AppStorage("kaguyaRegCharaCountKei") var regCharaCountKei = 0 {
            didSet {
                regCharaCountSum = countSum(regCharaCountDefault, regCharaCountKei, regCharaCountPapa, regCharaCountHayasaka, regCharaCountRainbow, regCharaCountOsaragi, regCharaCountBezi)
            }
        }
            @AppStorage("kaguyaRegCharaCountPapa") var regCharaCountPapa = 0 {
                didSet {
                    regCharaCountSum = countSum(regCharaCountDefault, regCharaCountKei, regCharaCountPapa, regCharaCountHayasaka, regCharaCountRainbow, regCharaCountOsaragi, regCharaCountBezi)
                }
            }
                @AppStorage("kaguyaRegCharaCountHayasaka") var regCharaCountHayasaka = 0 {
                    didSet {
                        regCharaCountSum = countSum(regCharaCountDefault, regCharaCountKei, regCharaCountPapa, regCharaCountHayasaka, regCharaCountRainbow, regCharaCountOsaragi, regCharaCountBezi)
                    }
                }
                    @AppStorage("kaguyaRegCharaCountRainbow") var regCharaCountRainbow = 0 {
                        didSet {
                            regCharaCountSum = countSum(regCharaCountDefault, regCharaCountKei, regCharaCountPapa, regCharaCountHayasaka, regCharaCountRainbow, regCharaCountOsaragi, regCharaCountBezi)
                        }
                    }
                        @AppStorage("kaguyaRegCharaCountOsaragi") var regCharaCountOsaragi = 0 {
                            didSet {
                                regCharaCountSum = countSum(regCharaCountDefault, regCharaCountKei, regCharaCountPapa, regCharaCountHayasaka, regCharaCountRainbow, regCharaCountOsaragi, regCharaCountBezi)
                            }
                        }
                            @AppStorage("kaguyaRegCharaCountBezi") var regCharaCountBezi = 0 {
                                didSet {
                                    regCharaCountSum = countSum(regCharaCountDefault, regCharaCountKei, regCharaCountPapa, regCharaCountHayasaka, regCharaCountRainbow, regCharaCountOsaragi, regCharaCountBezi)
                                }
                            }
    @AppStorage("kaguyaRegCharaCountSum") var regCharaCountSum = 0
    
    func resetRegChara() {
        regCharaSelectedFirst = "白銀"
        regCharaSelectedSecondAfterKaguya = "白銀"
        regCharaSelectedSecondAfterShirogane = "かぐや"
        regCharaSelectedSecondAfterRainbow = "白銀(虹背景)"
        regCharaCountDefault = 0
        regCharaCountKei = 0
        regCharaCountPapa = 0
        regCharaCountHayasaka = 0
        regCharaCountRainbow = 0
        regCharaCountOsaragi = 0
        regCharaCountBezi = 0
        minusCheck = false
    }
    
    // //////////////////////////
    // ボーナス終了画面
    // //////////////////////////
    @AppStorage("kaguyaScreenCurrentKeyword") var screenCurrentKeyword: String = ""
    let screenKeywordList: [String] = ["kaguyaScreenDefault", "kaguyaScreenRedNekomimi", "kaguyaScreenPurple2Men", "kaguyaScreenGekiga", "kaguyaScreenKaguyaFujiwara", "kaguyaScreenShiroganeKaguya", "kaguyaScreenSilverAdult", "kaguyaScreenSilverDeformed", "kaguyaScreenGoldWedding"]
    @AppStorage("kaguyaScreenCountDefault") var screenCountDefault = 0 {
        didSet {
            screenCountSum = countSum(screenCountDefault, screenCountRedNekomimi, screenCountPurple2Men, screenCountGekiga, screenCountKaguyaFujiwara, screenCountShiroganeKaguya, screenCountSilverAdult, screenCountSilverDeformed, screenCountGoldWedding)
        }
    }
        @AppStorage("kaguyaScreenCountRedNekomimi") var screenCountRedNekomimi = 0 {
            didSet {
                screenCountSum = countSum(screenCountDefault, screenCountRedNekomimi, screenCountPurple2Men, screenCountGekiga, screenCountKaguyaFujiwara, screenCountShiroganeKaguya, screenCountSilverAdult, screenCountSilverDeformed, screenCountGoldWedding)
            }
        }
            @AppStorage("kaguyaScreenCountPurple2Men") var screenCountPurple2Men = 0 {
                didSet {
                    screenCountSum = countSum(screenCountDefault, screenCountRedNekomimi, screenCountPurple2Men, screenCountGekiga, screenCountKaguyaFujiwara, screenCountShiroganeKaguya, screenCountSilverAdult, screenCountSilverDeformed, screenCountGoldWedding)
                }
            }
                @AppStorage("kaguyaScreenCountGekiga") var screenCountGekiga = 0 {
                    didSet {
                        screenCountSum = countSum(screenCountDefault, screenCountRedNekomimi, screenCountPurple2Men, screenCountGekiga, screenCountKaguyaFujiwara, screenCountShiroganeKaguya, screenCountSilverAdult, screenCountSilverDeformed, screenCountGoldWedding)
                    }
                }
                    @AppStorage("kaguyaScreenCountKaguyaFujiwara") var screenCountKaguyaFujiwara = 0 {
                        didSet {
                            screenCountSum = countSum(screenCountDefault, screenCountRedNekomimi, screenCountPurple2Men, screenCountGekiga, screenCountKaguyaFujiwara, screenCountShiroganeKaguya, screenCountSilverAdult, screenCountSilverDeformed, screenCountGoldWedding)
                        }
                    }
                        @AppStorage("kaguyaScreenCountShiroganeKaguya") var screenCountShiroganeKaguya = 0 {
                            didSet {
                                screenCountSum = countSum(screenCountDefault, screenCountRedNekomimi, screenCountPurple2Men, screenCountGekiga, screenCountKaguyaFujiwara, screenCountShiroganeKaguya, screenCountSilverAdult, screenCountSilverDeformed, screenCountGoldWedding)
                            }
                        }
                            @AppStorage("kaguyaScreenCountSilverAdult") var screenCountSilverAdult = 0 {
                                didSet {
                                    screenCountSum = countSum(screenCountDefault, screenCountRedNekomimi, screenCountPurple2Men, screenCountGekiga, screenCountKaguyaFujiwara, screenCountShiroganeKaguya, screenCountSilverAdult, screenCountSilverDeformed, screenCountGoldWedding)
                                }
                            }
                                @AppStorage("kaguyaScreenCountSilverDeformed") var screenCountSilverDeformed = 0 {
                                    didSet {
                                        screenCountSum = countSum(screenCountDefault, screenCountRedNekomimi, screenCountPurple2Men, screenCountGekiga, screenCountKaguyaFujiwara, screenCountShiroganeKaguya, screenCountSilverAdult, screenCountSilverDeformed, screenCountGoldWedding)
                                    }
                                }
                                    @AppStorage("kaguyaScreenCountGoldWedding") var screenCountGoldWedding = 0 {
                                        didSet {
                                            screenCountSum = countSum(screenCountDefault, screenCountRedNekomimi, screenCountPurple2Men, screenCountGekiga, screenCountKaguyaFujiwara, screenCountShiroganeKaguya, screenCountSilverAdult, screenCountSilverDeformed, screenCountGoldWedding)
                                        }
                                    }
    @AppStorage("kaguyaScreenCountSum") var screenCountSum = 0
    
    func resetScreen() {
        screenCountDefault = 0
        screenCountRedNekomimi = 0
        screenCountPurple2Men = 0
        screenCountGekiga = 0
        screenCountKaguyaFujiwara = 0
        screenCountShiroganeKaguya = 0
        screenCountSilverAdult = 0
        screenCountSilverDeformed = 0
        screenCountGoldWedding = 0
        minusCheck = false
    }
    
    // //////////////////////////
    // エンディング
    // //////////////////////////
    @AppStorage("kaguyaEndingCountBaloon") var endingCountBaloon = 0 {
        didSet {
            endingCountSum = countSum(endingCountBaloon, endingCountKoiNoYukue, endingCountKaguya, endingCountShirogane)
        }
    }
        @AppStorage("kaguyaEndingCountKoiNoYukue") var endingCountKoiNoYukue = 0 {
            didSet {
                endingCountSum = countSum(endingCountBaloon, endingCountKoiNoYukue, endingCountKaguya, endingCountShirogane)
            }
        }
            @AppStorage("kaguyaEndingCountKaguya") var endingCountKaguya = 0 {
                didSet {
                    endingCountSum = countSum(endingCountBaloon, endingCountKoiNoYukue, endingCountKaguya, endingCountShirogane)
                }
            }
                @AppStorage("kaguyaEndingCountShirogane") var endingCountShirogane = 0 {
                    didSet {
                        endingCountSum = countSum(endingCountBaloon, endingCountKoiNoYukue, endingCountKaguya, endingCountShirogane)
                    }
                }
    @AppStorage("kaguyaEndingCountSum") var endingCountSum = 0
    
    func resetEnding() {
        endingCountBaloon = 0
        endingCountKoiNoYukue = 0
        endingCountKaguya = 0
        endingCountShirogane = 0
        minusCheck = false
    }
    
    // //////////////////////////
    // 共通
    // //////////////////////////
    @AppStorage("kaguyaMinusCheck") var minusCheck: Bool = false
    
    func resetAll() {
        resetBonus()
        resetRegChara()
        resetScreen()
        resetEnding()
    }
    
    // /////////////////////////
    // メモリー
    // /////////////////////////
    @AppStorage("kaguyaSelectedMemory") var selectedMemory = "メモリー1"
    
    // /////////////////////
    // ver2.6.0で追加
    // /////////////////////
    @AppStorage("kaguyaBigCountUnder3Blue") var bigCountUnder3Blue: Int = 0 {
        didSet {
            bigCountUnder3Sum = countSum(bigCountUnder3Blue, bigCountUnder3Red)
        }
    }
        @AppStorage("kaguyaBigCountUnder3Red") var bigCountUnder3Red: Int = 0 {
            didSet {
                bigCountUnder3Sum = countSum(bigCountUnder3Blue, bigCountUnder3Red)
            }
        }
    @AppStorage("kaguyaBigCountUnder3Sum") var bigCountUnder3Sum: Int = 0
    @AppStorage("kaguyaBigCount4to6Blue") var bigCount4to6Blue: Int = 0 {
        didSet {
            bigCount4to6Sum = countSum(bigCount4to6Blue, bigCount4to6Red)
        }
    }
        @AppStorage("kaguyaBigCount4to6Red") var bigCount4to6Red: Int = 0 {
            didSet {
                bigCount4to6Sum = countSum(bigCount4to6Blue, bigCount4to6Red)
            }
        }
    @AppStorage("kaguyaBigCount4to6Sum") var bigCount4to6Sum: Int = 0
    @AppStorage("kaguyaBigCountOver7Blue") var bigCountOver7Blue: Int = 0 {
        didSet {
            bigCountOver7Sum = countSum(bigCountOver7Blue, bigCountOver7Red)
        }
    }
        @AppStorage("kaguyaBigCountOver7Red") var bigCountOver7Red: Int = 0 {
            didSet {
                bigCountOver7Sum = countSum(bigCountOver7Blue, bigCountOver7Red)
            }
        }
    @AppStorage("kaguyaBigCountOver7Sum") var bigCountOver7Sum: Int = 0
}

class KaguyaMemory1: ObservableObject {
    // //// メモリー１
    @AppStorage("kaguyaFirstBonusCountBigMemory1") var firstBonusCountBigMemory1 = 0
    @AppStorage("kaguyaFirstBonusCountRegMemory1") var firstBonusCountRegMemory1 = 0
    @AppStorage("kaguyaFirstBonusCountSumMemory1") var firstBonusCountSumMemory1 = 0
    @AppStorage("kaguyaBigCountNormalMemory1") var bigCountNormalMemory1 = 0
    @AppStorage("kaguyaBigCountSuperMemory1") var bigCountSuperMemory1 = 0
    @AppStorage("kaguyaBigCountExtraMemory1") var bigCountExtraMemory1 = 0
    @AppStorage("kaguyaBigCountSumMemory1") var bigCountSumMemory1 = 0
    @AppStorage("kaguyaRegCharaCountDefaultMemory1") var regCharaCountDefaultMemory1 = 0
    @AppStorage("kaguyaRegCharaCountKeiMemory1") var regCharaCountKeiMemory1 = 0
    @AppStorage("kaguyaRegCharaCountPapaMemory1") var regCharaCountPapaMemory1 = 0
    @AppStorage("kaguyaRegCharaCountHayasakaMemory1") var regCharaCountHayasakaMemory1 = 0
    @AppStorage("kaguyaRegCharaCountRainbowMemory1") var regCharaCountRainbowMemory1 = 0
    @AppStorage("kaguyaRegCharaCountOsaragiMemory1") var regCharaCountOsaragiMemory1 = 0
    @AppStorage("kaguyaRegCharaCountBeziMemory1") var regCharaCountBeziMemory1 = 0
    @AppStorage("kaguyaRegCharaCountSumMemory1") var regCharaCountSumMemory1 = 0
    @AppStorage("kaguyaScreenCountDefaultMemory1") var screenCountDefaultMemory1 = 0
    @AppStorage("kaguyaScreenCountRedNekomimiMemory1") var screenCountRedNekomimiMemory1 = 0
    @AppStorage("kaguyaScreenCountPurple2MenMemory1") var screenCountPurple2MenMemory1 = 0
    @AppStorage("kaguyaScreenCountGekigaMemory1") var screenCountGekigaMemory1 = 0
    @AppStorage("kaguyaScreenCountKaguyaFujiwaraMemory1") var screenCountKaguyaFujiwaraMemory1 = 0
    @AppStorage("kaguyaScreenCountShiroganeKaguyaMemory1") var screenCountShiroganeKaguyaMemory1 = 0
    @AppStorage("kaguyaScreenCountSilverAdultMemory1") var screenCountSilverAdultMemory1 = 0
    @AppStorage("kaguyaScreenCountSilverDeformedMemory1") var screenCountSilverDeformedMemory1 = 0
    @AppStorage("kaguyaScreenCountGoldWeddingMemory1") var screenCountGoldWeddingMemory1 = 0
    @AppStorage("kaguyaScreenCountSumMemory1") var screenCountSumMemory1 = 0
    @AppStorage("kaguyaEndingCountBaloonMemory1") var endingCountBaloonMemory1 = 0
    @AppStorage("kaguyaEndingCountKoiNoYukueMemory1") var endingCountKoiNoYukueMemory1 = 0
    @AppStorage("kaguyaEndingCountKaguyaMemory1") var endingCountKaguyaMemory1 = 0
    @AppStorage("kaguyaEndingCountShiroganeMemory1") var endingCountShiroganeMemory1 = 0
    @AppStorage("kaguyaEndingCountSumMemory1") var endingCountSumMemory1 = 0
    @AppStorage("kaguyaMemoMemory1") var memoMemory1 = ""
    @AppStorage("kaguyaDateMemory1") var dateDoubleMemory1 = 0.0
    // /////////////////////
    // ver2.6.0で追加
    // /////////////////////
    @AppStorage("kaguyaBigCountUnder3BlueMemory1") var bigCountUnder3Blue: Int = 0
    @AppStorage("kaguyaBigCountUnder3RedMemory1") var bigCountUnder3Red: Int = 0
    @AppStorage("kaguyaBigCountUnder3SumMemory1") var bigCountUnder3Sum: Int = 0
    @AppStorage("kaguyaBigCount4to6BlueMemory1") var bigCount4to6Blue: Int = 0
    @AppStorage("kaguyaBigCount4to6RedMemory1") var bigCount4to6Red: Int = 0
    @AppStorage("kaguyaBigCount4to6SumMemory1") var bigCount4to6Sum: Int = 0
    @AppStorage("kaguyaBigCountOver7BlueMemory1") var bigCountOver7Blue: Int = 0
    @AppStorage("kaguyaBigCountOver7RedMemory1") var bigCountOver7Red: Int = 0
    @AppStorage("kaguyaBigCountOver7SumMemory1") var bigCountOver7Sum: Int = 0
}


class KaguyaMemory2: ObservableObject {
    // //// メモリー2
    @AppStorage("kaguyaFirstBonusCountBigMemory2") var firstBonusCountBigMemory2 = 0
    @AppStorage("kaguyaFirstBonusCountRegMemory2") var firstBonusCountRegMemory2 = 0
    @AppStorage("kaguyaFirstBonusCountSumMemory2") var firstBonusCountSumMemory2 = 0
    @AppStorage("kaguyaBigCountNormalMemory2") var bigCountNormalMemory2 = 0
    @AppStorage("kaguyaBigCountSuperMemory2") var bigCountSuperMemory2 = 0
    @AppStorage("kaguyaBigCountExtraMemory2") var bigCountExtraMemory2 = 0
    @AppStorage("kaguyaBigCountSumMemory2") var bigCountSumMemory2 = 0
    @AppStorage("kaguyaRegCharaCountDefaultMemory2") var regCharaCountDefaultMemory2 = 0
    @AppStorage("kaguyaRegCharaCountKeiMemory2") var regCharaCountKeiMemory2 = 0
    @AppStorage("kaguyaRegCharaCountPapaMemory2") var regCharaCountPapaMemory2 = 0
    @AppStorage("kaguyaRegCharaCountHayasakaMemory2") var regCharaCountHayasakaMemory2 = 0
    @AppStorage("kaguyaRegCharaCountRainbowMemory2") var regCharaCountRainbowMemory2 = 0
    @AppStorage("kaguyaRegCharaCountOsaragiMemory2") var regCharaCountOsaragiMemory2 = 0
    @AppStorage("kaguyaRegCharaCountBeziMemory2") var regCharaCountBeziMemory2 = 0
    @AppStorage("kaguyaRegCharaCountSumMemory2") var regCharaCountSumMemory2 = 0
    @AppStorage("kaguyaScreenCountDefaultMemory2") var screenCountDefaultMemory2 = 0
    @AppStorage("kaguyaScreenCountRedNekomimiMemory2") var screenCountRedNekomimiMemory2 = 0
    @AppStorage("kaguyaScreenCountPurple2MenMemory2") var screenCountPurple2MenMemory2 = 0
    @AppStorage("kaguyaScreenCountGekigaMemory2") var screenCountGekigaMemory2 = 0
    @AppStorage("kaguyaScreenCountKaguyaFujiwaraMemory2") var screenCountKaguyaFujiwaraMemory2 = 0
    @AppStorage("kaguyaScreenCountShiroganeKaguyaMemory2") var screenCountShiroganeKaguyaMemory2 = 0
    @AppStorage("kaguyaScreenCountSilverAdultMemory2") var screenCountSilverAdultMemory2 = 0
    @AppStorage("kaguyaScreenCountSilverDeformedMemory2") var screenCountSilverDeformedMemory2 = 0
    @AppStorage("kaguyaScreenCountGoldWeddingMemory2") var screenCountGoldWeddingMemory2 = 0
    @AppStorage("kaguyaScreenCountSumMemory2") var screenCountSumMemory2 = 0
    @AppStorage("kaguyaEndingCountBaloonMemory2") var endingCountBaloonMemory2 = 0
    @AppStorage("kaguyaEndingCountKoiNoYukueMemory2") var endingCountKoiNoYukueMemory2 = 0
    @AppStorage("kaguyaEndingCountKaguyaMemory2") var endingCountKaguyaMemory2 = 0
    @AppStorage("kaguyaEndingCountShiroganeMemory2") var endingCountShiroganeMemory2 = 0
    @AppStorage("kaguyaEndingCountSumMemory2") var endingCountSumMemory2 = 0
    @AppStorage("kaguyaMemoMemory2") var memoMemory2 = ""
    @AppStorage("kaguyaDateMemory2") var dateDoubleMemory2 = 0.0
    // /////////////////////
    // ver2.6.0で追加
    // /////////////////////
    @AppStorage("kaguyaBigCountUnder3BlueMemory2") var bigCountUnder3Blue: Int = 0
    @AppStorage("kaguyaBigCountUnder3RedMemory2") var bigCountUnder3Red: Int = 0
    @AppStorage("kaguyaBigCountUnder3SumMemory2") var bigCountUnder3Sum: Int = 0
    @AppStorage("kaguyaBigCount4to6BlueMemory2") var bigCount4to6Blue: Int = 0
    @AppStorage("kaguyaBigCount4to6RedMemory2") var bigCount4to6Red: Int = 0
    @AppStorage("kaguyaBigCount4to6SumMemory2") var bigCount4to6Sum: Int = 0
    @AppStorage("kaguyaBigCountOver7BlueMemory2") var bigCountOver7Blue: Int = 0
    @AppStorage("kaguyaBigCountOver7RedMemory2") var bigCountOver7Red: Int = 0
    @AppStorage("kaguyaBigCountOver7SumMemory2") var bigCountOver7Sum: Int = 0
}


class KaguyaMemory3: ObservableObject {
    // //// メモリー3
    @AppStorage("kaguyaFirstBonusCountBigMemory3") var firstBonusCountBigMemory3 = 0
    @AppStorage("kaguyaFirstBonusCountRegMemory3") var firstBonusCountRegMemory3 = 0
    @AppStorage("kaguyaFirstBonusCountSumMemory3") var firstBonusCountSumMemory3 = 0
    @AppStorage("kaguyaBigCountNormalMemory3") var bigCountNormalMemory3 = 0
    @AppStorage("kaguyaBigCountSuperMemory3") var bigCountSuperMemory3 = 0
    @AppStorage("kaguyaBigCountExtraMemory3") var bigCountExtraMemory3 = 0
    @AppStorage("kaguyaBigCountSumMemory3") var bigCountSumMemory3 = 0
    @AppStorage("kaguyaRegCharaCountDefaultMemory3") var regCharaCountDefaultMemory3 = 0
    @AppStorage("kaguyaRegCharaCountKeiMemory3") var regCharaCountKeiMemory3 = 0
    @AppStorage("kaguyaRegCharaCountPapaMemory3") var regCharaCountPapaMemory3 = 0
    @AppStorage("kaguyaRegCharaCountHayasakaMemory3") var regCharaCountHayasakaMemory3 = 0
    @AppStorage("kaguyaRegCharaCountRainbowMemory3") var regCharaCountRainbowMemory3 = 0
    @AppStorage("kaguyaRegCharaCountOsaragiMemory3") var regCharaCountOsaragiMemory3 = 0
    @AppStorage("kaguyaRegCharaCountBeziMemory3") var regCharaCountBeziMemory3 = 0
    @AppStorage("kaguyaRegCharaCountSumMemory3") var regCharaCountSumMemory3 = 0
    @AppStorage("kaguyaScreenCountDefaultMemory3") var screenCountDefaultMemory3 = 0
    @AppStorage("kaguyaScreenCountRedNekomimiMemory3") var screenCountRedNekomimiMemory3 = 0
    @AppStorage("kaguyaScreenCountPurple2MenMemory3") var screenCountPurple2MenMemory3 = 0
    @AppStorage("kaguyaScreenCountGekigaMemory3") var screenCountGekigaMemory3 = 0
    @AppStorage("kaguyaScreenCountKaguyaFujiwaraMemory3") var screenCountKaguyaFujiwaraMemory3 = 0
    @AppStorage("kaguyaScreenCountShiroganeKaguyaMemory3") var screenCountShiroganeKaguyaMemory3 = 0
    @AppStorage("kaguyaScreenCountSilverAdultMemory3") var screenCountSilverAdultMemory3 = 0
    @AppStorage("kaguyaScreenCountSilverDeformedMemory3") var screenCountSilverDeformedMemory3 = 0
    @AppStorage("kaguyaScreenCountGoldWeddingMemory3") var screenCountGoldWeddingMemory3 = 0
    @AppStorage("kaguyaScreenCountSumMemory3") var screenCountSumMemory3 = 0
    @AppStorage("kaguyaEndingCountBaloonMemory3") var endingCountBaloonMemory3 = 0
    @AppStorage("kaguyaEndingCountKoiNoYukueMemory3") var endingCountKoiNoYukueMemory3 = 0
    @AppStorage("kaguyaEndingCountKaguyaMemory3") var endingCountKaguyaMemory3 = 0
    @AppStorage("kaguyaEndingCountShiroganeMemory3") var endingCountShiroganeMemory3 = 0
    @AppStorage("kaguyaEndingCountSumMemory3") var endingCountSumMemory3 = 0
    @AppStorage("kaguyaMemoMemory3") var memoMemory3 = ""
    @AppStorage("kaguyaDateMemory3") var dateDoubleMemory3 = 0.0
    // /////////////////////
    // ver2.6.0で追加
    // /////////////////////
    @AppStorage("kaguyaBigCountUnder3BlueMemory3") var bigCountUnder3Blue: Int = 0
    @AppStorage("kaguyaBigCountUnder3RedMemory3") var bigCountUnder3Red: Int = 0
    @AppStorage("kaguyaBigCountUnder3SumMemory3") var bigCountUnder3Sum: Int = 0
    @AppStorage("kaguyaBigCount4to6BlueMemory3") var bigCount4to6Blue: Int = 0
    @AppStorage("kaguyaBigCount4to6RedMemory3") var bigCount4to6Red: Int = 0
    @AppStorage("kaguyaBigCount4to6SumMemory3") var bigCount4to6Sum: Int = 0
    @AppStorage("kaguyaBigCountOver7BlueMemory3") var bigCountOver7Blue: Int = 0
    @AppStorage("kaguyaBigCountOver7RedMemory3") var bigCountOver7Red: Int = 0
    @AppStorage("kaguyaBigCountOver7SumMemory3") var bigCountOver7Sum: Int = 0
}


struct kaguyaViewTop: View {
    @ObservedObject var ver260 = Ver260()
    @ObservedObject var kaguya = KaguyaSama()
    @State var isShowAlert: Bool = false
    @State var isShowSaveView: Bool = false
    @State var isShowLoadView: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時のモード、示唆
                    NavigationLink(destination: kaguyaViewNormalMode()) {
                        unitLabelMenu(imageSystemName: "sparkle.magnifyingglass", textBody: "通常時のモード、示唆")
                    }
                    // ボーナス内訳
                    NavigationLink(destination: kaguyaViewBonus()) {
                        unitLabelMenu(
                            imageSystemName: "signpost.right.and.left",
                            textBody: "ボーナス種類の振分け",
                            badgeStatus: ver260.kaguyaMenuBonusBadgeStatus
                        )
                    }
                    // REG中のキャラ紹介
                    NavigationLink(destination: kaguyaViewReg()) {
                        unitLabelMenu(imageSystemName: "person.3.sequence", textBody: "REG中のキャラ紹介")
                    }
                    // ボーナス終了画面
                    NavigationLink(destination: kaguyaViewScreen()) {
                        unitLabelMenu(imageSystemName: "photo.on.rectangle", textBody: "ボーナス終了画面")
                    }
                    // エンディング
                    NavigationLink(destination: kaguyaViewEnding()) {
                        unitLabelMenu(imageSystemName: "flag.checkered", textBody: "エンディング")
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "かぐや様は告らせたい")
                }
                // 設定推測グラフ
                NavigationLink(destination: kaguyaView95Ci()) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4618")
                    .popoverTip(tipVer220AddLink())
            }
        }
        .onAppear {
            if ver260.kaguyaMachineIconBadgeStatus != "none" {
                ver260.kaguyaMachineIconBadgeStatus = "none"
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    HStack {
                        // //// データ読み出し
                        unitButtonLoadMemory(loadView: AnyView(kaguyaViewLoadMemory()))
    //                        .popoverTip(tipUnitButtonLoadMemory())
                        // //// データ保存
                        unitButtonSaveMemory(saveView: AnyView(kaguyaViewSaveMemory()))
    //                        .popoverTip(tipUnitButtonSaveMemory())
                    }
                    .popoverTip(tipUnitButtonMemory())
                    // //// データリセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: kaguya.resetAll, message: "この機種のデータを全てリセットします")
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}


// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct kaguyaViewSaveMemory: View {
    @ObservedObject var kaguya = KaguyaSama()
    @ObservedObject var kaguyaMemory1 = KaguyaMemory1()
    @ObservedObject var kaguyaMemory2 = KaguyaMemory2()
    @ObservedObject var kaguyaMemory3 = KaguyaMemory3()
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "かぐや様は告らせたい",
            selectedMemory: $kaguya.selectedMemory,
            memoMemory1: $kaguyaMemory1.memoMemory1,
            dateDoubleMemory1: $kaguyaMemory1.dateDoubleMemory1,
            actionMemory1: saveMemory1,
            memoMemory2: $kaguyaMemory2.memoMemory2,
            dateDoubleMemory2: $kaguyaMemory2.dateDoubleMemory2,
            actionMemory2: saveMemory2,
            memoMemory3: $kaguyaMemory3.memoMemory3,
            dateDoubleMemory3: $kaguyaMemory3.dateDoubleMemory3,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        kaguyaMemory1.firstBonusCountBigMemory1 = kaguya.firstBonusCountBig
        kaguyaMemory1.firstBonusCountRegMemory1 = kaguya.firstBonusCountReg
        kaguyaMemory1.firstBonusCountSumMemory1 = kaguya.firstBonusCountSum
        kaguyaMemory1.bigCountNormalMemory1 = kaguya.bigCountNormal
        kaguyaMemory1.bigCountSuperMemory1 = kaguya.bigCountSuper
        kaguyaMemory1.bigCountExtraMemory1 = kaguya.bigCountExtra
        kaguyaMemory1.bigCountSumMemory1 = kaguya.bigCountSum
        kaguyaMemory1.regCharaCountDefaultMemory1 = kaguya.regCharaCountDefault
        kaguyaMemory1.regCharaCountKeiMemory1 = kaguya.regCharaCountKei
        kaguyaMemory1.regCharaCountPapaMemory1 = kaguya.regCharaCountPapa
        kaguyaMemory1.regCharaCountHayasakaMemory1 = kaguya.regCharaCountHayasaka
        kaguyaMemory1.regCharaCountRainbowMemory1 = kaguya.regCharaCountRainbow
        kaguyaMemory1.regCharaCountOsaragiMemory1 = kaguya.regCharaCountOsaragi
        kaguyaMemory1.regCharaCountBeziMemory1 = kaguya.regCharaCountBezi
        kaguyaMemory1.regCharaCountSumMemory1 = kaguya.regCharaCountSum
        kaguyaMemory1.screenCountDefaultMemory1 = kaguya.screenCountDefault
        kaguyaMemory1.screenCountRedNekomimiMemory1 = kaguya.screenCountRedNekomimi
        kaguyaMemory1.screenCountPurple2MenMemory1 = kaguya.screenCountPurple2Men
        kaguyaMemory1.screenCountGekigaMemory1 = kaguya.screenCountGekiga
        kaguyaMemory1.screenCountKaguyaFujiwaraMemory1 = kaguya.screenCountKaguyaFujiwara
        kaguyaMemory1.screenCountShiroganeKaguyaMemory1 = kaguya.screenCountShiroganeKaguya
        kaguyaMemory1.screenCountSilverAdultMemory1 = kaguya.screenCountSilverAdult
        kaguyaMemory1.screenCountSilverDeformedMemory1 = kaguya.screenCountSilverDeformed
        kaguyaMemory1.screenCountGoldWeddingMemory1 = kaguya.screenCountGoldWedding
        kaguyaMemory1.screenCountSumMemory1 = kaguya.screenCountSum
        kaguyaMemory1.endingCountBaloonMemory1 = kaguya.endingCountBaloon
        kaguyaMemory1.endingCountKoiNoYukueMemory1 = kaguya.endingCountKoiNoYukue
        kaguyaMemory1.endingCountKaguyaMemory1 = kaguya.endingCountKaguya
        kaguyaMemory1.endingCountShiroganeMemory1 = kaguya.endingCountShirogane
        kaguyaMemory1.endingCountSumMemory1 = kaguya.endingCountSum
        // /////////////////////
        // ver2.6.0で追加
        // /////////////////////
        kaguyaMemory1.bigCountUnder3Blue = kaguya.bigCountUnder3Blue
        kaguyaMemory1.bigCountUnder3Red = kaguya.bigCountUnder3Red
        kaguyaMemory1.bigCountUnder3Sum = kaguya.bigCountUnder3Sum
        kaguyaMemory1.bigCount4to6Blue = kaguya.bigCount4to6Blue
        kaguyaMemory1.bigCount4to6Red = kaguya.bigCount4to6Red
        kaguyaMemory1.bigCount4to6Sum = kaguya.bigCount4to6Sum
        kaguyaMemory1.bigCountOver7Blue = kaguya.bigCountOver7Blue
        kaguyaMemory1.bigCountOver7Red = kaguya.bigCountOver7Red
        kaguyaMemory1.bigCountOver7Sum = kaguya.bigCountOver7Sum
    }
    
    func saveMemory2() {
        kaguyaMemory2.firstBonusCountBigMemory2 = kaguya.firstBonusCountBig
        kaguyaMemory2.firstBonusCountRegMemory2 = kaguya.firstBonusCountReg
        kaguyaMemory2.firstBonusCountSumMemory2 = kaguya.firstBonusCountSum
        kaguyaMemory2.bigCountNormalMemory2 = kaguya.bigCountNormal
        kaguyaMemory2.bigCountSuperMemory2 = kaguya.bigCountSuper
        kaguyaMemory2.bigCountExtraMemory2 = kaguya.bigCountExtra
        kaguyaMemory2.bigCountSumMemory2 = kaguya.bigCountSum
        kaguyaMemory2.regCharaCountDefaultMemory2 = kaguya.regCharaCountDefault
        kaguyaMemory2.regCharaCountKeiMemory2 = kaguya.regCharaCountKei
        kaguyaMemory2.regCharaCountPapaMemory2 = kaguya.regCharaCountPapa
        kaguyaMemory2.regCharaCountHayasakaMemory2 = kaguya.regCharaCountHayasaka
        kaguyaMemory2.regCharaCountRainbowMemory2 = kaguya.regCharaCountRainbow
        kaguyaMemory2.regCharaCountOsaragiMemory2 = kaguya.regCharaCountOsaragi
        kaguyaMemory2.regCharaCountBeziMemory2 = kaguya.regCharaCountBezi
        kaguyaMemory2.regCharaCountSumMemory2 = kaguya.regCharaCountSum
        kaguyaMemory2.screenCountDefaultMemory2 = kaguya.screenCountDefault
        kaguyaMemory2.screenCountRedNekomimiMemory2 = kaguya.screenCountRedNekomimi
        kaguyaMemory2.screenCountPurple2MenMemory2 = kaguya.screenCountPurple2Men
        kaguyaMemory2.screenCountGekigaMemory2 = kaguya.screenCountGekiga
        kaguyaMemory2.screenCountKaguyaFujiwaraMemory2 = kaguya.screenCountKaguyaFujiwara
        kaguyaMemory2.screenCountShiroganeKaguyaMemory2 = kaguya.screenCountShiroganeKaguya
        kaguyaMemory2.screenCountSilverAdultMemory2 = kaguya.screenCountSilverAdult
        kaguyaMemory2.screenCountSilverDeformedMemory2 = kaguya.screenCountSilverDeformed
        kaguyaMemory2.screenCountGoldWeddingMemory2 = kaguya.screenCountGoldWedding
        kaguyaMemory2.screenCountSumMemory2 = kaguya.screenCountSum
        kaguyaMemory2.endingCountBaloonMemory2 = kaguya.endingCountBaloon
        kaguyaMemory2.endingCountKoiNoYukueMemory2 = kaguya.endingCountKoiNoYukue
        kaguyaMemory2.endingCountKaguyaMemory2 = kaguya.endingCountKaguya
        kaguyaMemory2.endingCountShiroganeMemory2 = kaguya.endingCountShirogane
        kaguyaMemory2.endingCountSumMemory2 = kaguya.endingCountSum
        // /////////////////////
        // ver2.6.0で追加
        // /////////////////////
        kaguyaMemory2.bigCountUnder3Blue = kaguya.bigCountUnder3Blue
        kaguyaMemory2.bigCountUnder3Red = kaguya.bigCountUnder3Red
        kaguyaMemory2.bigCountUnder3Sum = kaguya.bigCountUnder3Sum
        kaguyaMemory2.bigCount4to6Blue = kaguya.bigCount4to6Blue
        kaguyaMemory2.bigCount4to6Red = kaguya.bigCount4to6Red
        kaguyaMemory2.bigCount4to6Sum = kaguya.bigCount4to6Sum
        kaguyaMemory2.bigCountOver7Blue = kaguya.bigCountOver7Blue
        kaguyaMemory2.bigCountOver7Red = kaguya.bigCountOver7Red
        kaguyaMemory2.bigCountOver7Sum = kaguya.bigCountOver7Sum
    }
    
    func saveMemory3() {
        kaguyaMemory3.firstBonusCountBigMemory3 = kaguya.firstBonusCountBig
        kaguyaMemory3.firstBonusCountRegMemory3 = kaguya.firstBonusCountReg
        kaguyaMemory3.firstBonusCountSumMemory3 = kaguya.firstBonusCountSum
        kaguyaMemory3.bigCountNormalMemory3 = kaguya.bigCountNormal
        kaguyaMemory3.bigCountSuperMemory3 = kaguya.bigCountSuper
        kaguyaMemory3.bigCountExtraMemory3 = kaguya.bigCountExtra
        kaguyaMemory3.bigCountSumMemory3 = kaguya.bigCountSum
        kaguyaMemory3.regCharaCountDefaultMemory3 = kaguya.regCharaCountDefault
        kaguyaMemory3.regCharaCountKeiMemory3 = kaguya.regCharaCountKei
        kaguyaMemory3.regCharaCountPapaMemory3 = kaguya.regCharaCountPapa
        kaguyaMemory3.regCharaCountHayasakaMemory3 = kaguya.regCharaCountHayasaka
        kaguyaMemory3.regCharaCountRainbowMemory3 = kaguya.regCharaCountRainbow
        kaguyaMemory3.regCharaCountOsaragiMemory3 = kaguya.regCharaCountOsaragi
        kaguyaMemory3.regCharaCountBeziMemory3 = kaguya.regCharaCountBezi
        kaguyaMemory3.regCharaCountSumMemory3 = kaguya.regCharaCountSum
        kaguyaMemory3.screenCountDefaultMemory3 = kaguya.screenCountDefault
        kaguyaMemory3.screenCountRedNekomimiMemory3 = kaguya.screenCountRedNekomimi
        kaguyaMemory3.screenCountPurple2MenMemory3 = kaguya.screenCountPurple2Men
        kaguyaMemory3.screenCountGekigaMemory3 = kaguya.screenCountGekiga
        kaguyaMemory3.screenCountKaguyaFujiwaraMemory3 = kaguya.screenCountKaguyaFujiwara
        kaguyaMemory3.screenCountShiroganeKaguyaMemory3 = kaguya.screenCountShiroganeKaguya
        kaguyaMemory3.screenCountSilverAdultMemory3 = kaguya.screenCountSilverAdult
        kaguyaMemory3.screenCountSilverDeformedMemory3 = kaguya.screenCountSilverDeformed
        kaguyaMemory3.screenCountGoldWeddingMemory3 = kaguya.screenCountGoldWedding
        kaguyaMemory3.screenCountSumMemory3 = kaguya.screenCountSum
        kaguyaMemory3.endingCountBaloonMemory3 = kaguya.endingCountBaloon
        kaguyaMemory3.endingCountKoiNoYukueMemory3 = kaguya.endingCountKoiNoYukue
        kaguyaMemory3.endingCountKaguyaMemory3 = kaguya.endingCountKaguya
        kaguyaMemory3.endingCountShiroganeMemory3 = kaguya.endingCountShirogane
        kaguyaMemory3.endingCountSumMemory3 = kaguya.endingCountSum
        // /////////////////////
        // ver2.6.0で追加
        // /////////////////////
        kaguyaMemory3.bigCountUnder3Blue = kaguya.bigCountUnder3Blue
        kaguyaMemory3.bigCountUnder3Red = kaguya.bigCountUnder3Red
        kaguyaMemory3.bigCountUnder3Sum = kaguya.bigCountUnder3Sum
        kaguyaMemory3.bigCount4to6Blue = kaguya.bigCount4to6Blue
        kaguyaMemory3.bigCount4to6Red = kaguya.bigCount4to6Red
        kaguyaMemory3.bigCount4to6Sum = kaguya.bigCount4to6Sum
        kaguyaMemory3.bigCountOver7Blue = kaguya.bigCountOver7Blue
        kaguyaMemory3.bigCountOver7Red = kaguya.bigCountOver7Red
        kaguyaMemory3.bigCountOver7Sum = kaguya.bigCountOver7Sum
    }
}


// ///////////////////////////
// メモリーロード画面
// ///////////////////////////
struct kaguyaViewLoadMemory: View {
    @ObservedObject var kaguya = KaguyaSama()
    @ObservedObject var kaguyaMemory1 = KaguyaMemory1()
    @ObservedObject var kaguyaMemory2 = KaguyaMemory2()
    @ObservedObject var kaguyaMemory3 = KaguyaMemory3()
    @State var isShowLoadAlert: Bool = false
    var body: some View {
        unitViewLoadMemory(
            machineName: "かぐや様は告らせたい",
            selectedMemory: $kaguya.selectedMemory,
            memoMemory1: kaguyaMemory1.memoMemory1,
            dateDoubleMemory1: kaguyaMemory1.dateDoubleMemory1,
            actionMemory1: loadMemory1,
            memoMemory2: kaguyaMemory2.memoMemory2,
            dateDoubleMemory2: kaguyaMemory2.dateDoubleMemory2,
            actionMemory2: loadMemory2,
            memoMemory3: kaguyaMemory3.memoMemory3,
            dateDoubleMemory3: kaguyaMemory3.dateDoubleMemory3,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowLoadAlert
        )
    }
    func loadMemory1() {
        kaguya.firstBonusCountBig = kaguyaMemory1.firstBonusCountBigMemory1
        kaguya.firstBonusCountReg = kaguyaMemory1.firstBonusCountRegMemory1
        kaguya.firstBonusCountSum = kaguyaMemory1.firstBonusCountSumMemory1
        kaguya.bigCountNormal = kaguyaMemory1.bigCountNormalMemory1
        kaguya.bigCountSuper = kaguyaMemory1.bigCountSuperMemory1
        kaguya.bigCountExtra = kaguyaMemory1.bigCountExtraMemory1
        kaguya.bigCountSum = kaguyaMemory1.bigCountSumMemory1
        kaguya.regCharaCountDefault = kaguyaMemory1.regCharaCountDefaultMemory1
        kaguya.regCharaCountKei = kaguyaMemory1.regCharaCountKeiMemory1
        kaguya.regCharaCountPapa = kaguyaMemory1.regCharaCountPapaMemory1
        kaguya.regCharaCountHayasaka = kaguyaMemory1.regCharaCountHayasakaMemory1
        kaguya.regCharaCountRainbow = kaguyaMemory1.regCharaCountRainbowMemory1
        kaguya.regCharaCountOsaragi = kaguyaMemory1.regCharaCountOsaragiMemory1
        kaguya.regCharaCountBezi = kaguyaMemory1.regCharaCountBeziMemory1
        kaguya.regCharaCountSum = kaguyaMemory1.regCharaCountSumMemory1
        kaguya.screenCountDefault = kaguyaMemory1.screenCountDefaultMemory1
        kaguya.screenCountRedNekomimi = kaguyaMemory1.screenCountRedNekomimiMemory1
        kaguya.screenCountPurple2Men = kaguyaMemory1.screenCountPurple2MenMemory1
        kaguya.screenCountGekiga = kaguyaMemory1.screenCountGekigaMemory1
        kaguya.screenCountKaguyaFujiwara = kaguyaMemory1.screenCountKaguyaFujiwaraMemory1
        kaguya.screenCountShiroganeKaguya = kaguyaMemory1.screenCountShiroganeKaguyaMemory1
        kaguya.screenCountSilverAdult = kaguyaMemory1.screenCountSilverAdultMemory1
        kaguya.screenCountSilverDeformed = kaguyaMemory1.screenCountSilverDeformedMemory1
        kaguya.screenCountGoldWedding = kaguyaMemory1.screenCountGoldWeddingMemory1
        kaguya.screenCountSum = kaguyaMemory1.screenCountSumMemory1
        kaguya.endingCountBaloon = kaguyaMemory1.endingCountBaloonMemory1
        kaguya.endingCountKoiNoYukue = kaguyaMemory1.endingCountKoiNoYukueMemory1
        kaguya.endingCountKaguya = kaguyaMemory1.endingCountKaguyaMemory1
        kaguya.endingCountShirogane = kaguyaMemory1.endingCountShiroganeMemory1
        kaguya.endingCountSum = kaguyaMemory1.endingCountSumMemory1
        // /////////////////////
        // ver2.6.0で追加
        // /////////////////////
        kaguya.bigCountUnder3Blue = kaguyaMemory1.bigCountUnder3Blue
        kaguya.bigCountUnder3Red = kaguyaMemory1.bigCountUnder3Red
        kaguya.bigCountUnder3Sum = kaguyaMemory1.bigCountUnder3Sum
        kaguya.bigCount4to6Blue = kaguyaMemory1.bigCount4to6Blue
        kaguya.bigCount4to6Red = kaguyaMemory1.bigCount4to6Red
        kaguya.bigCount4to6Sum = kaguyaMemory1.bigCount4to6Sum
        kaguya.bigCountOver7Blue = kaguyaMemory1.bigCountOver7Blue
        kaguya.bigCountOver7Red = kaguyaMemory1.bigCountOver7Red
        kaguya.bigCountOver7Sum = kaguyaMemory1.bigCountOver7Sum
    }
    
    func loadMemory2() {
        kaguya.firstBonusCountBig = kaguyaMemory2.firstBonusCountBigMemory2
        kaguya.firstBonusCountReg = kaguyaMemory2.firstBonusCountRegMemory2
        kaguya.firstBonusCountSum = kaguyaMemory2.firstBonusCountSumMemory2
        kaguya.bigCountNormal = kaguyaMemory2.bigCountNormalMemory2
        kaguya.bigCountSuper = kaguyaMemory2.bigCountSuperMemory2
        kaguya.bigCountExtra = kaguyaMemory2.bigCountExtraMemory2
        kaguya.bigCountSum = kaguyaMemory2.bigCountSumMemory2
        kaguya.regCharaCountDefault = kaguyaMemory2.regCharaCountDefaultMemory2
        kaguya.regCharaCountKei = kaguyaMemory2.regCharaCountKeiMemory2
        kaguya.regCharaCountPapa = kaguyaMemory2.regCharaCountPapaMemory2
        kaguya.regCharaCountHayasaka = kaguyaMemory2.regCharaCountHayasakaMemory2
        kaguya.regCharaCountRainbow = kaguyaMemory2.regCharaCountRainbowMemory2
        kaguya.regCharaCountOsaragi = kaguyaMemory2.regCharaCountOsaragiMemory2
        kaguya.regCharaCountBezi = kaguyaMemory2.regCharaCountBeziMemory2
        kaguya.regCharaCountSum = kaguyaMemory2.regCharaCountSumMemory2
        kaguya.screenCountDefault = kaguyaMemory2.screenCountDefaultMemory2
        kaguya.screenCountRedNekomimi = kaguyaMemory2.screenCountRedNekomimiMemory2
        kaguya.screenCountPurple2Men = kaguyaMemory2.screenCountPurple2MenMemory2
        kaguya.screenCountGekiga = kaguyaMemory2.screenCountGekigaMemory2
        kaguya.screenCountKaguyaFujiwara = kaguyaMemory2.screenCountKaguyaFujiwaraMemory2
        kaguya.screenCountShiroganeKaguya = kaguyaMemory2.screenCountShiroganeKaguyaMemory2
        kaguya.screenCountSilverAdult = kaguyaMemory2.screenCountSilverAdultMemory2
        kaguya.screenCountSilverDeformed = kaguyaMemory2.screenCountSilverDeformedMemory2
        kaguya.screenCountGoldWedding = kaguyaMemory2.screenCountGoldWeddingMemory2
        kaguya.screenCountSum = kaguyaMemory2.screenCountSumMemory2
        kaguya.endingCountBaloon = kaguyaMemory2.endingCountBaloonMemory2
        kaguya.endingCountKoiNoYukue = kaguyaMemory2.endingCountKoiNoYukueMemory2
        kaguya.endingCountKaguya = kaguyaMemory2.endingCountKaguyaMemory2
        kaguya.endingCountShirogane = kaguyaMemory2.endingCountShiroganeMemory2
        kaguya.endingCountSum = kaguyaMemory2.endingCountSumMemory2
        // /////////////////////
        // ver2.6.0で追加
        // /////////////////////
        kaguya.bigCountUnder3Blue = kaguyaMemory2.bigCountUnder3Blue
        kaguya.bigCountUnder3Red = kaguyaMemory2.bigCountUnder3Red
        kaguya.bigCountUnder3Sum = kaguyaMemory2.bigCountUnder3Sum
        kaguya.bigCount4to6Blue = kaguyaMemory2.bigCount4to6Blue
        kaguya.bigCount4to6Red = kaguyaMemory2.bigCount4to6Red
        kaguya.bigCount4to6Sum = kaguyaMemory2.bigCount4to6Sum
        kaguya.bigCountOver7Blue = kaguyaMemory2.bigCountOver7Blue
        kaguya.bigCountOver7Red = kaguyaMemory2.bigCountOver7Red
        kaguya.bigCountOver7Sum = kaguyaMemory2.bigCountOver7Sum
    }
    
    func loadMemory3() {
        kaguya.firstBonusCountBig = kaguyaMemory3.firstBonusCountBigMemory3
        kaguya.firstBonusCountReg = kaguyaMemory3.firstBonusCountRegMemory3
        kaguya.firstBonusCountSum = kaguyaMemory3.firstBonusCountSumMemory3
        kaguya.bigCountNormal = kaguyaMemory3.bigCountNormalMemory3
        kaguya.bigCountSuper = kaguyaMemory3.bigCountSuperMemory3
        kaguya.bigCountExtra = kaguyaMemory3.bigCountExtraMemory3
        kaguya.bigCountSum = kaguyaMemory3.bigCountSumMemory3
        kaguya.regCharaCountDefault = kaguyaMemory3.regCharaCountDefaultMemory3
        kaguya.regCharaCountKei = kaguyaMemory3.regCharaCountKeiMemory3
        kaguya.regCharaCountPapa = kaguyaMemory3.regCharaCountPapaMemory3
        kaguya.regCharaCountHayasaka = kaguyaMemory3.regCharaCountHayasakaMemory3
        kaguya.regCharaCountRainbow = kaguyaMemory3.regCharaCountRainbowMemory3
        kaguya.regCharaCountOsaragi = kaguyaMemory3.regCharaCountOsaragiMemory3
        kaguya.regCharaCountBezi = kaguyaMemory3.regCharaCountBeziMemory3
        kaguya.regCharaCountSum = kaguyaMemory3.regCharaCountSumMemory3
        kaguya.screenCountDefault = kaguyaMemory3.screenCountDefaultMemory3
        kaguya.screenCountRedNekomimi = kaguyaMemory3.screenCountRedNekomimiMemory3
        kaguya.screenCountPurple2Men = kaguyaMemory3.screenCountPurple2MenMemory3
        kaguya.screenCountGekiga = kaguyaMemory3.screenCountGekigaMemory3
        kaguya.screenCountKaguyaFujiwara = kaguyaMemory3.screenCountKaguyaFujiwaraMemory3
        kaguya.screenCountShiroganeKaguya = kaguyaMemory3.screenCountShiroganeKaguyaMemory3
        kaguya.screenCountSilverAdult = kaguyaMemory3.screenCountSilverAdultMemory3
        kaguya.screenCountSilverDeformed = kaguyaMemory3.screenCountSilverDeformedMemory3
        kaguya.screenCountGoldWedding = kaguyaMemory3.screenCountGoldWeddingMemory3
        kaguya.screenCountSum = kaguyaMemory3.screenCountSumMemory3
        kaguya.endingCountBaloon = kaguyaMemory3.endingCountBaloonMemory3
        kaguya.endingCountKoiNoYukue = kaguyaMemory3.endingCountKoiNoYukueMemory3
        kaguya.endingCountKaguya = kaguyaMemory3.endingCountKaguyaMemory3
        kaguya.endingCountShirogane = kaguyaMemory3.endingCountShiroganeMemory3
        kaguya.endingCountSum = kaguyaMemory3.endingCountSumMemory3
        // /////////////////////
        // ver2.6.0で追加
        // /////////////////////
        kaguya.bigCountUnder3Blue = kaguyaMemory3.bigCountUnder3Blue
        kaguya.bigCountUnder3Red = kaguyaMemory3.bigCountUnder3Red
        kaguya.bigCountUnder3Sum = kaguyaMemory3.bigCountUnder3Sum
        kaguya.bigCount4to6Blue = kaguyaMemory3.bigCount4to6Blue
        kaguya.bigCount4to6Red = kaguyaMemory3.bigCount4to6Red
        kaguya.bigCount4to6Sum = kaguyaMemory3.bigCount4to6Sum
        kaguya.bigCountOver7Blue = kaguyaMemory3.bigCountOver7Blue
        kaguya.bigCountOver7Red = kaguyaMemory3.bigCountOver7Red
        kaguya.bigCountOver7Sum = kaguyaMemory3.bigCountOver7Sum
    }
}

#Preview {
    kaguyaViewTop()
}
