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
    @AppStorage("kaguyaRegCharaSelectedSecondAfterKaguya") var regCharaSelectedSecondAfterKaguya: String = "白銀パパ"
    let regCharaSelectListSecondAfterShirogane: [String] = ["かぐや", "白銀圭", "ベツィー"]
    @AppStorage("kaguyaRegCharaSelectedSecondAfterShirogane") var regCharaSelectedSecondAfterShirogane: String = "かぐや"
    let regCharaSelectListSecondAfterRainbow: [String] = ["白銀(虹背景)"]
    @AppStorage("kaguyaRegCharaSelectedSecondAfterRainbow") var regCharaSelectedSecondAfterRainbow: String = "白銀(虹背景)"
    
    
    
    // //////////////////////////
    // 共通
    // //////////////////////////
    @AppStorage("kaguyaMinusCheck") var minusCheck: Bool = false
    
    func resetAll() {
        resetBonus()
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
