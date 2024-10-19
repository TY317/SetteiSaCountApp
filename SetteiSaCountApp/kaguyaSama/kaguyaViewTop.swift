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
}

struct kaguyaViewTop: View {
    @ObservedObject var kaguya = KaguyaSama()
    @State var isShowAlert: Bool = false
    
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
                unitButtonReset(isShowAlert: $isShowAlert, action: kaguya.resetAll, message: "この機種のデータを全てリセットします")
            }
        }
    }
}

#Preview {
    kaguyaViewTop()
}
