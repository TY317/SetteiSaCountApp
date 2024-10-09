//
//  goevaViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2024/08/27.
//

import SwiftUI


// //////////////////
// 変数
// //////////////////
class Goeva: ObservableObject {
    // ////////////////////////
    // 通常時のスイカからのCZ、変異
    // ////////////////////////
    @AppStorage("goevaNormalSuikaCount") var normalSuikaCount = 0
    @AppStorage("goevaNormalCzCount") var normalCzCount = 0
    @AppStorage("goevaNormalHenniKoyakuCount") var normalHenniKoyakuCount = 0 {
        didSet {
            normalHenniCountSum = countSum(normalHenniKoyakuCount, normalHenniZoshokuCount, normalHenniUchuCount, normalHenniKasseikaCount)
        }
    }
    @AppStorage("goevaNormalHenniZoshokuCount") var normalHenniZoshokuCount = 0 {
        didSet {
            normalHenniCountSum = countSum(normalHenniKoyakuCount, normalHenniZoshokuCount, normalHenniUchuCount, normalHenniKasseikaCount)
        }
    }
    @AppStorage("goevaNormalHenniUchuCount") var normalHenniUchuCount = 0 {
        didSet {
            normalHenniCountSum = countSum(normalHenniKoyakuCount, normalHenniZoshokuCount, normalHenniUchuCount, normalHenniKasseikaCount)
        }
    }
    @AppStorage("goevaNormalHenniKasseikaCount") var normalHenniKasseikaCount = 0 {
        didSet {
            normalHenniCountSum = countSum(normalHenniKoyakuCount, normalHenniZoshokuCount, normalHenniUchuCount, normalHenniKasseikaCount)
        }
    }
    @AppStorage("goevaNormalHenniCountSum") var normalHenniCountSum = 0
    
    
    func resetNormalSuika() {
        normalSuikaCount = 0
        normalCzCount = 0
        normalHenniKoyakuCount = 0
        normalHenniZoshokuCount = 0
        normalHenniUchuCount = 0
        normalHenniKasseikaCount = 0
        minusCheck = false
    }
    
    // ////////////////////////
    // ボーナス終了画面
    // ////////////////////////
    @AppStorage("goevaBonusScreenCurrentKeyword") var bonusScreenCurrentKeyword = ""
    @Published var bonusScreenShinjiKeyword = "シンジ"
    @Published var bonusScreenReiKeyword = "レイ"
    @Published var bonusScreenMariKeyword = "マリ"
    @Published var bonusScreenAsukaKeyword = "アスカ"
    @Published var bonusScreenReiBackKeyword = "レイ背景"
    @Published var bonusScreenGoevaKeyword = "ゴジエヴァ"
    @AppStorage("goevaBonusScreenShinjiCount") var bonusScreenShinjiCount = 0 {
        didSet {
            bonusScreenCountSum = countSum(bonusScreenShinjiCount, bonusScreenReiCount, bonusScreenMariCount, bonusScreenAsukaCount, bonusScreenReiBackCount, bonusScreenGoevaCount)
        }
    }
    @AppStorage("goevaBonusScreenReiCount") var bonusScreenReiCount = 0 {
        didSet {
            bonusScreenCountSum = countSum(bonusScreenShinjiCount, bonusScreenReiCount, bonusScreenMariCount, bonusScreenAsukaCount, bonusScreenReiBackCount, bonusScreenGoevaCount)
        }
    }
    @AppStorage("goevaBonusScreenMariCount") var bonusScreenMariCount = 0 {
        didSet {
            bonusScreenCountSum = countSum(bonusScreenShinjiCount, bonusScreenReiCount, bonusScreenMariCount, bonusScreenAsukaCount, bonusScreenReiBackCount, bonusScreenGoevaCount)
        }
    }
    @AppStorage("goevaBonusScreenAsukaCount") var bonusScreenAsukaCount = 0 {
        didSet {
            bonusScreenCountSum = countSum(bonusScreenShinjiCount, bonusScreenReiCount, bonusScreenMariCount, bonusScreenAsukaCount, bonusScreenReiBackCount, bonusScreenGoevaCount)
        }
    }
    @AppStorage("goevaBonusScreenReiBackCount") var bonusScreenReiBackCount = 0 {
        didSet {
            bonusScreenCountSum = countSum(bonusScreenShinjiCount, bonusScreenReiCount, bonusScreenMariCount, bonusScreenAsukaCount, bonusScreenReiBackCount, bonusScreenGoevaCount)
        }
    }
    @AppStorage("goevaBonusScreenGoevaCount") var bonusScreenGoevaCount = 0 {
        didSet {
            bonusScreenCountSum = countSum(bonusScreenShinjiCount, bonusScreenReiCount, bonusScreenMariCount, bonusScreenAsukaCount, bonusScreenReiBackCount, bonusScreenGoevaCount)
        }
    }
    @AppStorage("goevaBonusScreenCountSum") var bonusScreenCountSum = 0
    
    func resetBonusScreen() {
        bonusScreenCurrentKeyword = ""
        bonusScreenShinjiCount = 0
        bonusScreenReiCount = 0
        bonusScreenMariCount = 0
        bonusScreenAsukaCount = 0
        bonusScreenReiBackCount = 0
        bonusScreenGoevaCount = 0
        minusCheck = false
    }
    
    
    // ///////////////////
    // AT中のスイカからのCZ、変異
    // ///////////////////
    @AppStorage("goevaAtSuikaCount") var atSuikaCount = 0
    @AppStorage("goevaAtCzCount") var atCzCount = 0
    @AppStorage("goevaAtCzWinCount") var atCzWinCount = 0
    
    func resetAtSuika() {
        atSuikaCount = 0
        atCzCount = 0
        atCzWinCount = 0
        minusCheck = false
    }
    
    
    // ////////////////////
    // AT終了画面
    // ////////////////////
    @AppStorage("goevaAtScreenCurrentKeyword") var atScreenCurrentKeyword = ""
    @Published var atScreenShogokiKeyword = "初号機"
    @Published var atScreenZerogokiKeyword = "零号機"
    @Published var atScreen8gokiKeyword = "8号機"
    @Published var atScreen2gokiKeyword = "2号機"
    @Published var atScreenMosuraKeyword = "モスラ"
    @Published var atScreenGoevaKeyword = "ゴジエヴァ"
    @Published var atScreenKaoruKeyword = "カヲル"
    @AppStorage("goevaAtScreenShogokiCount") var atScreenShogokiCount = 0 {
        didSet {
            atScreenCountSum = countSum(atScreenShogokiCount, atScreenZerogokiCount, atScreen8gokiCount, atScreen2gokiCount, atScreenMosuraCount, atScreenGoevaCount, atScreenKaoruCount)
        }
    }
    @AppStorage("goevaAtScreenZerogokiCount") var atScreenZerogokiCount = 0 {
        didSet {
            atScreenCountSum = countSum(atScreenShogokiCount, atScreenZerogokiCount, atScreen8gokiCount, atScreen2gokiCount, atScreenMosuraCount, atScreenGoevaCount, atScreenKaoruCount)
        }
    }
    @AppStorage("goevaAtScreen8gokiCount") var atScreen8gokiCount = 0 {
        didSet {
            atScreenCountSum = countSum(atScreenShogokiCount, atScreenZerogokiCount, atScreen8gokiCount, atScreen2gokiCount, atScreenMosuraCount, atScreenGoevaCount, atScreenKaoruCount)
        }
    }
    @AppStorage("goevaAtScreen2gokiCount") var atScreen2gokiCount = 0 {
        didSet {
            atScreenCountSum = countSum(atScreenShogokiCount, atScreenZerogokiCount, atScreen8gokiCount, atScreen2gokiCount, atScreenMosuraCount, atScreenGoevaCount, atScreenKaoruCount)
        }
    }
    @AppStorage("goevaAtScreenMosuraCount") var atScreenMosuraCount = 0 {
        didSet {
            atScreenCountSum = countSum(atScreenShogokiCount, atScreenZerogokiCount, atScreen8gokiCount, atScreen2gokiCount, atScreenMosuraCount, atScreenGoevaCount, atScreenKaoruCount)
        }
    }
    @AppStorage("goevaAtScreenGoevaCount") var atScreenGoevaCount = 0 {
        didSet {
            atScreenCountSum = countSum(atScreenShogokiCount, atScreenZerogokiCount, atScreen8gokiCount, atScreen2gokiCount, atScreenMosuraCount, atScreenGoevaCount, atScreenKaoruCount)
        }
    }
    @AppStorage("goevaAtScreenKaoruCount") var atScreenKaoruCount = 0 {
        didSet {
            atScreenCountSum = countSum(atScreenShogokiCount, atScreenZerogokiCount, atScreen8gokiCount, atScreen2gokiCount, atScreenMosuraCount, atScreenGoevaCount, atScreenKaoruCount)
        }
    }
    @AppStorage("goevaAtScreenCountSum") var atScreenCountSum = 0
    
    func resetAtScreen() {
        atScreenCurrentKeyword = ""
        atScreenShogokiCount = 0
        atScreenZerogokiCount = 0
        atScreen8gokiCount = 0
        atScreen2gokiCount = 0
        atScreenMosuraCount = 0
        atScreenGoevaCount = 0
        atScreenKaoruCount = 0
        atScreenCountSum = 0
        minusCheck = false
    }
    
    // ///////////////////
    // 共通
    // ///////////////////
    @AppStorage("goevaMinusCheck") var minusCheck = false
    
    func resetAll() {
        resetNormalSuika()
        resetBonusScreen()
        resetAtSuika()
        resetAtScreen()
    }
    
}

struct goevaViewTop: View {
    @ObservedObject var goeva = Goeva()
    @State var isShowAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時スイカからのCZ
                    NavigationLink(destination: goevaNormalSuika()) {
                        unitLabelMenu(imageSystemName: "figure.2.circle", textBody: "通常時のCZ、変異")
//                        Image(systemName: "figure.2.circle")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("通常時のCZ、変異")
                    }
                    // ボーナス終了画面
                    NavigationLink(destination: goevaViewBonusScreen()) {
                        unitLabelMenu(imageSystemName: "photo.on.rectangle", textBody: "ボーナス終了画面")
//                        Image(systemName: "photo.on.rectangle")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("ボーナス終了画面")
                    }
                    // AT中のスイカ
                    NavigationLink(destination: goevaViewAtSuika()) {
                        unitLabelMenu(imageSystemName: "shield.lefthalf.filled", textBody: "AT中スイカからのCZ")
//                        Image(systemName: "shield.lefthalf.filled")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("AT中スイカからのCZ")
                    }
                    // AT終了画面
                    NavigationLink(destination: goevaViewAtScreen()) {
                        unitLabelMenu(imageSystemName: "photo.on.rectangle", textBody: "AT終了画面")
//                        Image(systemName: "photo.on.rectangle")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("AT終了画面")
                    }
                    // エンディング
                    NavigationLink(destination: goevaViewEnding()) {
                        unitLabelMenu(imageSystemName: "flag.checkered", textBody: "エンディング")
//                        Image(systemName: "flag.checkered")
//                            .foregroundColor(Color.gray)
//                            .font(.title2)
//                        Text("エンディング")
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "ゴジラvsエヴァ")
                }
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                unitButtonReset(isShowAlert: $isShowAlert, action: goeva.resetAll, message: "この機種のデータを全てリセットします")
                    .popoverTip(tipUnitButtonReset())
            }
        }
    }
}

#Preview {
    goevaViewTop()
}
