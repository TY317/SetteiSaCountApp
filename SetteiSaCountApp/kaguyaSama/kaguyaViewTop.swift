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
    @AppStorage("kaguyaMemoMemory1") var memoMemory1 = "未使用"
    @AppStorage("kaguyaDateMemory1") var dateDoubleMemory1 = 1725235200.0
    func saveMemory1() {
        firstBonusCountBigMemory1 = firstBonusCountBig
        firstBonusCountRegMemory1 = firstBonusCountReg
        firstBonusCountSumMemory1 = firstBonusCountSum
        bigCountNormalMemory1 = bigCountNormal
        bigCountSuperMemory1 = bigCountSuper
        bigCountExtraMemory1 = bigCountExtra
        bigCountSumMemory1 = bigCountSum
        regCharaCountDefaultMemory1 = regCharaCountDefault
        regCharaCountKeiMemory1 = regCharaCountKei
        regCharaCountPapaMemory1 = regCharaCountPapa
        regCharaCountHayasakaMemory1 = regCharaCountHayasaka
        regCharaCountRainbowMemory1 = regCharaCountRainbow
        regCharaCountOsaragiMemory1 = regCharaCountOsaragi
        regCharaCountBeziMemory1 = regCharaCountBezi
        regCharaCountSumMemory1 = regCharaCountSum
        screenCountDefaultMemory1 = screenCountDefault
        screenCountRedNekomimiMemory1 = screenCountRedNekomimi
        screenCountPurple2MenMemory1 = screenCountPurple2Men
        screenCountGekigaMemory1 = screenCountGekiga
        screenCountKaguyaFujiwaraMemory1 = screenCountKaguyaFujiwara
        screenCountShiroganeKaguyaMemory1 = screenCountShiroganeKaguya
        screenCountSilverAdultMemory1 = screenCountSilverAdult
        screenCountSilverDeformedMemory1 = screenCountSilverDeformed
        screenCountGoldWeddingMemory1 = screenCountGoldWedding
        screenCountSumMemory1 = screenCountSum
        endingCountBaloonMemory1 = endingCountBaloon
        endingCountKoiNoYukueMemory1 = endingCountKoiNoYukue
        endingCountKaguyaMemory1 = endingCountKaguya
        endingCountShiroganeMemory1 = endingCountShirogane
        endingCountSumMemory1 = endingCountSum
    }
    func loadMemory1() {
        firstBonusCountBig = firstBonusCountBigMemory1
        firstBonusCountReg = firstBonusCountRegMemory1
        firstBonusCountSum = firstBonusCountSumMemory1
        bigCountNormal = bigCountNormalMemory1
        bigCountSuper = bigCountSuperMemory1
        bigCountExtra = bigCountExtraMemory1
        bigCountSum = bigCountSumMemory1
        regCharaCountDefault = regCharaCountDefaultMemory1
        regCharaCountKei = regCharaCountKeiMemory1
        regCharaCountPapa = regCharaCountPapaMemory1
        regCharaCountHayasaka = regCharaCountHayasakaMemory1
        regCharaCountRainbow = regCharaCountRainbowMemory1
        regCharaCountOsaragi = regCharaCountOsaragiMemory1
        regCharaCountBezi = regCharaCountBeziMemory1
        regCharaCountSum = regCharaCountSumMemory1
        screenCountDefault = screenCountDefaultMemory1
        screenCountRedNekomimi = screenCountRedNekomimiMemory1
        screenCountPurple2Men = screenCountPurple2MenMemory1
        screenCountGekiga = screenCountGekigaMemory1
        screenCountKaguyaFujiwara = screenCountKaguyaFujiwaraMemory1
        screenCountShiroganeKaguya = screenCountShiroganeKaguyaMemory1
        screenCountSilverAdult = screenCountSilverAdultMemory1
        screenCountSilverDeformed = screenCountSilverDeformedMemory1
        screenCountGoldWedding = screenCountGoldWeddingMemory1
        screenCountSum = screenCountSumMemory1
        endingCountBaloon = endingCountBaloonMemory1
        endingCountKoiNoYukue = endingCountKoiNoYukueMemory1
        endingCountKaguya = endingCountKaguyaMemory1
        endingCountShirogane = endingCountShiroganeMemory1
        endingCountSum = endingCountSumMemory1
    }
    
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
    @AppStorage("kaguyaMemoMemory2") var memoMemory2 = "未使用"
    @AppStorage("kaguyaDateMemory2") var dateDoubleMemory2 = 1725235200.0
    func saveMemory2() {
        firstBonusCountBigMemory2 = firstBonusCountBig
        firstBonusCountRegMemory2 = firstBonusCountReg
        firstBonusCountSumMemory2 = firstBonusCountSum
        bigCountNormalMemory2 = bigCountNormal
        bigCountSuperMemory2 = bigCountSuper
        bigCountExtraMemory2 = bigCountExtra
        bigCountSumMemory2 = bigCountSum
        regCharaCountDefaultMemory2 = regCharaCountDefault
        regCharaCountKeiMemory2 = regCharaCountKei
        regCharaCountPapaMemory2 = regCharaCountPapa
        regCharaCountHayasakaMemory2 = regCharaCountHayasaka
        regCharaCountRainbowMemory2 = regCharaCountRainbow
        regCharaCountOsaragiMemory2 = regCharaCountOsaragi
        regCharaCountBeziMemory2 = regCharaCountBezi
        regCharaCountSumMemory2 = regCharaCountSum
        screenCountDefaultMemory2 = screenCountDefault
        screenCountRedNekomimiMemory2 = screenCountRedNekomimi
        screenCountPurple2MenMemory2 = screenCountPurple2Men
        screenCountGekigaMemory2 = screenCountGekiga
        screenCountKaguyaFujiwaraMemory2 = screenCountKaguyaFujiwara
        screenCountShiroganeKaguyaMemory2 = screenCountShiroganeKaguya
        screenCountSilverAdultMemory2 = screenCountSilverAdult
        screenCountSilverDeformedMemory2 = screenCountSilverDeformed
        screenCountGoldWeddingMemory2 = screenCountGoldWedding
        screenCountSumMemory2 = screenCountSum
        endingCountBaloonMemory2 = endingCountBaloon
        endingCountKoiNoYukueMemory2 = endingCountKoiNoYukue
        endingCountKaguyaMemory2 = endingCountKaguya
        endingCountShiroganeMemory2 = endingCountShirogane
        endingCountSumMemory2 = endingCountSum
    }
    func loadMemory2() {
        firstBonusCountBig = firstBonusCountBigMemory2
        firstBonusCountReg = firstBonusCountRegMemory2
        firstBonusCountSum = firstBonusCountSumMemory2
        bigCountNormal = bigCountNormalMemory2
        bigCountSuper = bigCountSuperMemory2
        bigCountExtra = bigCountExtraMemory2
        bigCountSum = bigCountSumMemory2
        regCharaCountDefault = regCharaCountDefaultMemory2
        regCharaCountKei = regCharaCountKeiMemory2
        regCharaCountPapa = regCharaCountPapaMemory2
        regCharaCountHayasaka = regCharaCountHayasakaMemory2
        regCharaCountRainbow = regCharaCountRainbowMemory2
        regCharaCountOsaragi = regCharaCountOsaragiMemory2
        regCharaCountBezi = regCharaCountBeziMemory2
        regCharaCountSum = regCharaCountSumMemory2
        screenCountDefault = screenCountDefaultMemory2
        screenCountRedNekomimi = screenCountRedNekomimiMemory2
        screenCountPurple2Men = screenCountPurple2MenMemory2
        screenCountGekiga = screenCountGekigaMemory2
        screenCountKaguyaFujiwara = screenCountKaguyaFujiwaraMemory2
        screenCountShiroganeKaguya = screenCountShiroganeKaguyaMemory2
        screenCountSilverAdult = screenCountSilverAdultMemory2
        screenCountSilverDeformed = screenCountSilverDeformedMemory2
        screenCountGoldWedding = screenCountGoldWeddingMemory2
        screenCountSum = screenCountSumMemory2
        endingCountBaloon = endingCountBaloonMemory2
        endingCountKoiNoYukue = endingCountKoiNoYukueMemory2
        endingCountKaguya = endingCountKaguyaMemory2
        endingCountShirogane = endingCountShiroganeMemory2
        endingCountSum = endingCountSumMemory2
    }
    
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
    @AppStorage("kaguyaMemoMemory3") var memoMemory3 = "未使用"
    @AppStorage("kaguyaDateMemory3") var dateDoubleMemory3 = 1725235200.0
    func saveMemory3() {
        firstBonusCountBigMemory3 = firstBonusCountBig
        firstBonusCountRegMemory3 = firstBonusCountReg
        firstBonusCountSumMemory3 = firstBonusCountSum
        bigCountNormalMemory3 = bigCountNormal
        bigCountSuperMemory3 = bigCountSuper
        bigCountExtraMemory3 = bigCountExtra
        bigCountSumMemory3 = bigCountSum
        regCharaCountDefaultMemory3 = regCharaCountDefault
        regCharaCountKeiMemory3 = regCharaCountKei
        regCharaCountPapaMemory3 = regCharaCountPapa
        regCharaCountHayasakaMemory3 = regCharaCountHayasaka
        regCharaCountRainbowMemory3 = regCharaCountRainbow
        regCharaCountOsaragiMemory3 = regCharaCountOsaragi
        regCharaCountBeziMemory3 = regCharaCountBezi
        regCharaCountSumMemory3 = regCharaCountSum
        screenCountDefaultMemory3 = screenCountDefault
        screenCountRedNekomimiMemory3 = screenCountRedNekomimi
        screenCountPurple2MenMemory3 = screenCountPurple2Men
        screenCountGekigaMemory3 = screenCountGekiga
        screenCountKaguyaFujiwaraMemory3 = screenCountKaguyaFujiwara
        screenCountShiroganeKaguyaMemory3 = screenCountShiroganeKaguya
        screenCountSilverAdultMemory3 = screenCountSilverAdult
        screenCountSilverDeformedMemory3 = screenCountSilverDeformed
        screenCountGoldWeddingMemory3 = screenCountGoldWedding
        screenCountSumMemory3 = screenCountSum
        endingCountBaloonMemory3 = endingCountBaloon
        endingCountKoiNoYukueMemory3 = endingCountKoiNoYukue
        endingCountKaguyaMemory3 = endingCountKaguya
        endingCountShiroganeMemory3 = endingCountShirogane
        endingCountSumMemory3 = endingCountSum
    }
    func loadMemory3() {
        firstBonusCountBig = firstBonusCountBigMemory3
        firstBonusCountReg = firstBonusCountRegMemory3
        firstBonusCountSum = firstBonusCountSumMemory3
        bigCountNormal = bigCountNormalMemory3
        bigCountSuper = bigCountSuperMemory3
        bigCountExtra = bigCountExtraMemory3
        bigCountSum = bigCountSumMemory3
        regCharaCountDefault = regCharaCountDefaultMemory3
        regCharaCountKei = regCharaCountKeiMemory3
        regCharaCountPapa = regCharaCountPapaMemory3
        regCharaCountHayasaka = regCharaCountHayasakaMemory3
        regCharaCountRainbow = regCharaCountRainbowMemory3
        regCharaCountOsaragi = regCharaCountOsaragiMemory3
        regCharaCountBezi = regCharaCountBeziMemory3
        regCharaCountSum = regCharaCountSumMemory3
        screenCountDefault = screenCountDefaultMemory3
        screenCountRedNekomimi = screenCountRedNekomimiMemory3
        screenCountPurple2Men = screenCountPurple2MenMemory3
        screenCountGekiga = screenCountGekigaMemory3
        screenCountKaguyaFujiwara = screenCountKaguyaFujiwaraMemory3
        screenCountShiroganeKaguya = screenCountShiroganeKaguyaMemory3
        screenCountSilverAdult = screenCountSilverAdultMemory3
        screenCountSilverDeformed = screenCountSilverDeformedMemory3
        screenCountGoldWedding = screenCountGoldWeddingMemory3
        screenCountSum = screenCountSumMemory3
        endingCountBaloon = endingCountBaloonMemory3
        endingCountKoiNoYukue = endingCountKoiNoYukueMemory3
        endingCountKaguya = endingCountKaguyaMemory3
        endingCountShirogane = endingCountShiroganeMemory3
        endingCountSum = endingCountSumMemory3
    }
}

struct kaguyaViewTop: View {
    @ObservedObject var kaguya = KaguyaSama()
    @State var isShowAlert: Bool = false
    @State var isShowSaveView: Bool = false
    @State var isShowSaveAlert: Bool = false
    @State var isShowLoadView: Bool = false
    @State var isShowLoadAlert: Bool = false
    
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
                        unitLabelMenu(imageSystemName: "signpost.right.and.left", textBody: "ボーナス種類の振分け")
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
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    // //// データ読み出し
                    Button {
                        self.isShowLoadView.toggle()
                    } label: {
                        Image(systemName: "folder")
                    }
                    .sheet(isPresented: $isShowLoadView) {
                        unitViewLoadMemory(
                            machineName: "かぐや様は告らせたい",
                            selectedMemory: $kaguya.selectedMemory,
                            memoMemory1: kaguya.memoMemory1,
                            dateDoubleMemory1: kaguya.dateDoubleMemory1,
                            actionMemory1: kaguya.loadMemory1,
                            memoMemory2: kaguya.memoMemory2,
                            dateDoubleMemory2: kaguya.dateDoubleMemory2,
                            actionMemory2: kaguya.loadMemory2,
                            memoMemory3: kaguya.memoMemory3,
                            dateDoubleMemory3: kaguya.dateDoubleMemory3,
                            actionMemory3: kaguya.loadMemory3,
                            isShowLoadAlert: $isShowLoadAlert
                        )
                            .presentationDetents([.large])
                    }

                    // //// データ保存
                    Button {
                        self.isShowSaveView.toggle()
                    } label: {
                        Image(systemName: "externaldrive.badge.plus")
                    }
                    .sheet(isPresented: $isShowSaveView) {
                        unitViewSaveMemory(
                            machineName: "かぐや様は告らせたい",
                            selectedMemory: $kaguya.selectedMemory,
                            memoMemory1: $kaguya.memoMemory1,
                            dateDoubleMemory1: $kaguya.dateDoubleMemory1,
                            actionMemory1: kaguya.saveMemory1,
                            memoMemory2: $kaguya.memoMemory2,
                            dateDoubleMemory2: $kaguya.dateDoubleMemory2,
                            actionMemory2: kaguya.saveMemory2,
                            memoMemory3: $kaguya.memoMemory3,
                            dateDoubleMemory3: $kaguya.dateDoubleMemory3,
                            actionMemory3: kaguya.saveMemory3,
                            isShowSaveAlert: $isShowSaveAlert
                        )
                    }

                    // //// データリセット
                    unitButtonReset(isShowAlert: $isShowAlert, action: kaguya.resetAll, message: "この機種のデータを全てリセットします")
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}


#Preview {
    kaguyaViewTop()
}
