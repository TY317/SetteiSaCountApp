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
    @AppStorage("goevaSelectedMemory") var selectedMemory = "メモリー1"
    
    func resetAll() {
        resetNormalSuika()
        resetBonusScreen()
        resetAtSuika()
        resetAtScreen()
    }
}

// //// メモリー1
class GoevaMemory1: ObservableObject {
    @AppStorage("goevaNormalSuikaCountMemory1") var normalSuikaCount = 0
    @AppStorage("goevaNormalCzCountMemory1") var normalCzCount = 0
    @AppStorage("goevaNormalHenniKoyakuCountMemory1") var normalHenniKoyakuCount = 0
    @AppStorage("goevaNormalHenniZoshokuCountMemory1") var normalHenniZoshokuCount = 0
    @AppStorage("goevaNormalHenniUchuCountMemory1") var normalHenniUchuCount = 0
    @AppStorage("goevaNormalHenniKasseikaCountMemory1") var normalHenniKasseikaCount = 0
    @AppStorage("goevaNormalHenniCountSumMemory1") var normalHenniCountSum = 0
    @AppStorage("goevaBonusScreenShinjiCountMemory1") var bonusScreenShinjiCount = 0
    @AppStorage("goevaBonusScreenReiCountMemory1") var bonusScreenReiCount = 0
    @AppStorage("goevaBonusScreenMariCountMemory1") var bonusScreenMariCount = 0
    @AppStorage("goevaBonusScreenAsukaCountMemory1") var bonusScreenAsukaCount = 0
    @AppStorage("goevaBonusScreenReiBackCountMemory1") var bonusScreenReiBackCount = 0
    @AppStorage("goevaBonusScreenGoevaCountMemory1") var bonusScreenGoevaCount = 0
    @AppStorage("goevaBonusScreenCountSumMemory1") var bonusScreenCountSum = 0
    @AppStorage("goevaAtSuikaCountMemory1") var atSuikaCount = 0
    @AppStorage("goevaAtCzCountMemory1") var atCzCount = 0
    @AppStorage("goevaAtCzWinCountMemory1") var atCzWinCount = 0
    @AppStorage("goevaAtScreenShogokiCountMemory1") var atScreenShogokiCount = 0
    @AppStorage("goevaAtScreenZerogokiCountMemory1") var atScreenZerogokiCount = 0
    @AppStorage("goevaAtScreen8gokiCountMemory1") var atScreen8gokiCount = 0
    @AppStorage("goevaAtScreen2gokiCountMemory1") var atScreen2gokiCount = 0
    @AppStorage("goevaAtScreenMosuraCountMemory1") var atScreenMosuraCount = 0
    @AppStorage("goevaAtScreenGoevaCountMemory1") var atScreenGoevaCount = 0
    @AppStorage("goevaAtScreenKaoruCountMemory1") var atScreenKaoruCount = 0
    @AppStorage("goevaAtScreenCountSumMemory1") var atScreenCountSum = 0
    @AppStorage("goevaMemoMemory1") var memo = ""
    @AppStorage("goevaDateMemory1") var dateDouble = 0.0
}

// //// メモリー2
class GoevaMemory2: ObservableObject {
    @AppStorage("goevaNormalSuikaCountMemory2") var normalSuikaCount = 0
    @AppStorage("goevaNormalCzCountMemory2") var normalCzCount = 0
    @AppStorage("goevaNormalHenniKoyakuCountMemory2") var normalHenniKoyakuCount = 0
    @AppStorage("goevaNormalHenniZoshokuCountMemory2") var normalHenniZoshokuCount = 0
    @AppStorage("goevaNormalHenniUchuCountMemory2") var normalHenniUchuCount = 0
    @AppStorage("goevaNormalHenniKasseikaCountMemory2") var normalHenniKasseikaCount = 0
    @AppStorage("goevaNormalHenniCountSumMemory2") var normalHenniCountSum = 0
    @AppStorage("goevaBonusScreenShinjiCountMemory2") var bonusScreenShinjiCount = 0
    @AppStorage("goevaBonusScreenReiCountMemory2") var bonusScreenReiCount = 0
    @AppStorage("goevaBonusScreenMariCountMemory2") var bonusScreenMariCount = 0
    @AppStorage("goevaBonusScreenAsukaCountMemory2") var bonusScreenAsukaCount = 0
    @AppStorage("goevaBonusScreenReiBackCountMemory2") var bonusScreenReiBackCount = 0
    @AppStorage("goevaBonusScreenGoevaCountMemory2") var bonusScreenGoevaCount = 0
    @AppStorage("goevaBonusScreenCountSumMemory2") var bonusScreenCountSum = 0
    @AppStorage("goevaAtSuikaCountMemory2") var atSuikaCount = 0
    @AppStorage("goevaAtCzCountMemory2") var atCzCount = 0
    @AppStorage("goevaAtCzWinCountMemory2") var atCzWinCount = 0
    @AppStorage("goevaAtScreenShogokiCountMemory2") var atScreenShogokiCount = 0
    @AppStorage("goevaAtScreenZerogokiCountMemory2") var atScreenZerogokiCount = 0
    @AppStorage("goevaAtScreen8gokiCountMemory2") var atScreen8gokiCount = 0
    @AppStorage("goevaAtScreen2gokiCountMemory2") var atScreen2gokiCount = 0
    @AppStorage("goevaAtScreenMosuraCountMemory2") var atScreenMosuraCount = 0
    @AppStorage("goevaAtScreenGoevaCountMemory2") var atScreenGoevaCount = 0
    @AppStorage("goevaAtScreenKaoruCountMemory2") var atScreenKaoruCount = 0
    @AppStorage("goevaAtScreenCountSumMemory2") var atScreenCountSum = 0
    @AppStorage("goevaMemoMemory2") var memo = ""
    @AppStorage("goevaDateMemory2") var dateDouble = 0.0
}

// //// メモリー3
class GoevaMemory3: ObservableObject {
    @AppStorage("goevaNormalSuikaCountMemory3") var normalSuikaCount = 0
    @AppStorage("goevaNormalCzCountMemory3") var normalCzCount = 0
    @AppStorage("goevaNormalHenniKoyakuCountMemory3") var normalHenniKoyakuCount = 0
    @AppStorage("goevaNormalHenniZoshokuCountMemory3") var normalHenniZoshokuCount = 0
    @AppStorage("goevaNormalHenniUchuCountMemory3") var normalHenniUchuCount = 0
    @AppStorage("goevaNormalHenniKasseikaCountMemory3") var normalHenniKasseikaCount = 0
    @AppStorage("goevaNormalHenniCountSumMemory3") var normalHenniCountSum = 0
    @AppStorage("goevaBonusScreenShinjiCountMemory3") var bonusScreenShinjiCount = 0
    @AppStorage("goevaBonusScreenReiCountMemory3") var bonusScreenReiCount = 0
    @AppStorage("goevaBonusScreenMariCountMemory3") var bonusScreenMariCount = 0
    @AppStorage("goevaBonusScreenAsukaCountMemory3") var bonusScreenAsukaCount = 0
    @AppStorage("goevaBonusScreenReiBackCountMemory3") var bonusScreenReiBackCount = 0
    @AppStorage("goevaBonusScreenGoevaCountMemory3") var bonusScreenGoevaCount = 0
    @AppStorage("goevaBonusScreenCountSumMemory3") var bonusScreenCountSum = 0
    @AppStorage("goevaAtSuikaCountMemory3") var atSuikaCount = 0
    @AppStorage("goevaAtCzCountMemory3") var atCzCount = 0
    @AppStorage("goevaAtCzWinCountMemory3") var atCzWinCount = 0
    @AppStorage("goevaAtScreenShogokiCountMemory3") var atScreenShogokiCount = 0
    @AppStorage("goevaAtScreenZerogokiCountMemory3") var atScreenZerogokiCount = 0
    @AppStorage("goevaAtScreen8gokiCountMemory3") var atScreen8gokiCount = 0
    @AppStorage("goevaAtScreen2gokiCountMemory3") var atScreen2gokiCount = 0
    @AppStorage("goevaAtScreenMosuraCountMemory3") var atScreenMosuraCount = 0
    @AppStorage("goevaAtScreenGoevaCountMemory3") var atScreenGoevaCount = 0
    @AppStorage("goevaAtScreenKaoruCountMemory3") var atScreenKaoruCount = 0
    @AppStorage("goevaAtScreenCountSumMemory3") var atScreenCountSum = 0
    @AppStorage("goevaMemoMemory3") var memo = ""
    @AppStorage("goevaDateMemory3") var dateDouble = 0.0
}


struct goevaViewTop: View {
//    @ObservedObject var goeva = Goeva()
    @StateObject var goeva = Goeva()
    @State var isShowAlert = false
    @StateObject var goevaMemory1 = GoevaMemory1()
    @StateObject var goevaMemory2 = GoevaMemory2()
    @StateObject var goevaMemory3 = GoevaMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 通常時スイカからのCZ
                    NavigationLink(destination: goevaNormalSuika(goeva: goeva)) {
                        unitLabelMenu(imageSystemName: "figure.2.circle", textBody: "通常時のCZ、変異")
                    }
                    // ボーナス終了画面
                    NavigationLink(destination: goevaViewBonusScreen(goeva: goeva)) {
                        unitLabelMenu(imageSystemName: "photo.on.rectangle", textBody: "ボーナス終了画面")
                    }
                    // AT中のスイカ
                    NavigationLink(destination: goevaViewAtSuika(goeva: goeva)) {
                        unitLabelMenu(imageSystemName: "shield.lefthalf.filled", textBody: "AT中スイカからのCZ")
                    }
                    // AT終了画面
                    NavigationLink(destination: goevaViewAtScreen(goeva: goeva)) {
                        unitLabelMenu(imageSystemName: "photo.on.rectangle", textBody: "AT終了画面")
                    }
                    // エンディング
                    NavigationLink(destination: goevaViewEnding()) {
                        unitLabelMenu(imageSystemName: "flag.checkered", textBody: "エンディング")
                    }
                } header: {
                    unitLabelMachineTopTitle(machineName: "ゴジラvsエヴァ")
                }
                // 設定推測グラフ
                NavigationLink(destination: goevaView95Ci(goeva: goeva)) {
                    unitLabelMenu(imageSystemName: "chart.bar.xaxis", textBody: "設定推測グラフ")
                }
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4501")
//                    .popoverTip(tipVer220AddLink())
            }
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                HStack {
                    HStack {
                        // //// データ読み出し
                        unitButtonLoadMemory(loadView: AnyView(goevaViewLoadMemory(
                            goeva: goeva,
                            goevaMemory1: goevaMemory1,
                            goevaMemory2: goevaMemory2,
                            goevaMemory3: goevaMemory3
                        )))
                        // //// データ保存
                        unitButtonSaveMemory(saveView: AnyView(goevaViewSaveMemory(
                            goeva: goeva,
                            goevaMemory1: goevaMemory1,
                            goevaMemory2: goevaMemory2,
                            goevaMemory3: goevaMemory3
                        )))
                    }
                    .popoverTip(tipUnitButtonMemory())
                    unitButtonReset(isShowAlert: $isShowAlert, action: goeva.resetAll, message: "この機種のデータを全てリセットします")
                        .popoverTip(tipUnitButtonReset())
                }
            }
        }
    }
}


// /////////////////////////////
// メモリーセーブ画面
// /////////////////////////////
struct goevaViewSaveMemory: View {
    @ObservedObject var goeva: Goeva
    @ObservedObject var goevaMemory1: GoevaMemory1
    @ObservedObject var goevaMemory2: GoevaMemory2
    @ObservedObject var goevaMemory3: GoevaMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: "ゴジラvsエヴァンゲリオン",
            selectedMemory: $goeva.selectedMemory,
            memoMemory1: $goevaMemory1.memo,
            dateDoubleMemory1: $goevaMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $goevaMemory2.memo,
            dateDoubleMemory2: $goevaMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $goevaMemory3.memo,
            dateDoubleMemory3: $goevaMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        goevaMemory1.normalSuikaCount = goeva.normalSuikaCount
        goevaMemory1.normalCzCount = goeva.normalCzCount
        goevaMemory1.normalHenniKoyakuCount = goeva.normalHenniKoyakuCount
        goevaMemory1.normalHenniZoshokuCount = goeva.normalHenniZoshokuCount
        goevaMemory1.normalHenniUchuCount = goeva.normalHenniUchuCount
        goevaMemory1.normalHenniKasseikaCount = goeva.normalHenniKasseikaCount
        goevaMemory1.normalHenniCountSum = goeva.normalHenniCountSum
        goevaMemory1.bonusScreenShinjiCount = goeva.bonusScreenShinjiCount
        goevaMemory1.bonusScreenReiCount = goeva.bonusScreenReiCount
        goevaMemory1.bonusScreenMariCount = goeva.bonusScreenMariCount
        goevaMemory1.bonusScreenAsukaCount = goeva.bonusScreenAsukaCount
        goevaMemory1.bonusScreenReiBackCount = goeva.bonusScreenReiBackCount
        goevaMemory1.bonusScreenGoevaCount = goeva.bonusScreenGoevaCount
        goevaMemory1.bonusScreenCountSum = goeva.bonusScreenCountSum
        goevaMemory1.atSuikaCount = goeva.atSuikaCount
        goevaMemory1.atCzCount = goeva.atCzCount
        goevaMemory1.atCzWinCount = goeva.atCzWinCount
        goevaMemory1.atScreenShogokiCount = goeva.atScreenShogokiCount
        goevaMemory1.atScreenZerogokiCount = goeva.atScreenZerogokiCount
        goevaMemory1.atScreen8gokiCount = goeva.atScreen8gokiCount
        goevaMemory1.atScreen2gokiCount = goeva.atScreen2gokiCount
        goevaMemory1.atScreenMosuraCount = goeva.atScreenMosuraCount
        goevaMemory1.atScreenGoevaCount = goeva.atScreenGoevaCount
        goevaMemory1.atScreenKaoruCount = goeva.atScreenKaoruCount
        goevaMemory1.atScreenCountSum = goeva.atScreenCountSum
    }
    func saveMemory2() {
        goevaMemory2.normalSuikaCount = goeva.normalSuikaCount
        goevaMemory2.normalCzCount = goeva.normalCzCount
        goevaMemory2.normalHenniKoyakuCount = goeva.normalHenniKoyakuCount
        goevaMemory2.normalHenniZoshokuCount = goeva.normalHenniZoshokuCount
        goevaMemory2.normalHenniUchuCount = goeva.normalHenniUchuCount
        goevaMemory2.normalHenniKasseikaCount = goeva.normalHenniKasseikaCount
        goevaMemory2.normalHenniCountSum = goeva.normalHenniCountSum
        goevaMemory2.bonusScreenShinjiCount = goeva.bonusScreenShinjiCount
        goevaMemory2.bonusScreenReiCount = goeva.bonusScreenReiCount
        goevaMemory2.bonusScreenMariCount = goeva.bonusScreenMariCount
        goevaMemory2.bonusScreenAsukaCount = goeva.bonusScreenAsukaCount
        goevaMemory2.bonusScreenReiBackCount = goeva.bonusScreenReiBackCount
        goevaMemory2.bonusScreenGoevaCount = goeva.bonusScreenGoevaCount
        goevaMemory2.bonusScreenCountSum = goeva.bonusScreenCountSum
        goevaMemory2.atSuikaCount = goeva.atSuikaCount
        goevaMemory2.atCzCount = goeva.atCzCount
        goevaMemory2.atCzWinCount = goeva.atCzWinCount
        goevaMemory2.atScreenShogokiCount = goeva.atScreenShogokiCount
        goevaMemory2.atScreenZerogokiCount = goeva.atScreenZerogokiCount
        goevaMemory2.atScreen8gokiCount = goeva.atScreen8gokiCount
        goevaMemory2.atScreen2gokiCount = goeva.atScreen2gokiCount
        goevaMemory2.atScreenMosuraCount = goeva.atScreenMosuraCount
        goevaMemory2.atScreenGoevaCount = goeva.atScreenGoevaCount
        goevaMemory2.atScreenKaoruCount = goeva.atScreenKaoruCount
        goevaMemory2.atScreenCountSum = goeva.atScreenCountSum
    }
    func saveMemory3() {
        goevaMemory3.normalSuikaCount = goeva.normalSuikaCount
        goevaMemory3.normalCzCount = goeva.normalCzCount
        goevaMemory3.normalHenniKoyakuCount = goeva.normalHenniKoyakuCount
        goevaMemory3.normalHenniZoshokuCount = goeva.normalHenniZoshokuCount
        goevaMemory3.normalHenniUchuCount = goeva.normalHenniUchuCount
        goevaMemory3.normalHenniKasseikaCount = goeva.normalHenniKasseikaCount
        goevaMemory3.normalHenniCountSum = goeva.normalHenniCountSum
        goevaMemory3.bonusScreenShinjiCount = goeva.bonusScreenShinjiCount
        goevaMemory3.bonusScreenReiCount = goeva.bonusScreenReiCount
        goevaMemory3.bonusScreenMariCount = goeva.bonusScreenMariCount
        goevaMemory3.bonusScreenAsukaCount = goeva.bonusScreenAsukaCount
        goevaMemory3.bonusScreenReiBackCount = goeva.bonusScreenReiBackCount
        goevaMemory3.bonusScreenGoevaCount = goeva.bonusScreenGoevaCount
        goevaMemory3.bonusScreenCountSum = goeva.bonusScreenCountSum
        goevaMemory3.atSuikaCount = goeva.atSuikaCount
        goevaMemory3.atCzCount = goeva.atCzCount
        goevaMemory3.atCzWinCount = goeva.atCzWinCount
        goevaMemory3.atScreenShogokiCount = goeva.atScreenShogokiCount
        goevaMemory3.atScreenZerogokiCount = goeva.atScreenZerogokiCount
        goevaMemory3.atScreen8gokiCount = goeva.atScreen8gokiCount
        goevaMemory3.atScreen2gokiCount = goeva.atScreen2gokiCount
        goevaMemory3.atScreenMosuraCount = goeva.atScreenMosuraCount
        goevaMemory3.atScreenGoevaCount = goeva.atScreenGoevaCount
        goevaMemory3.atScreenKaoruCount = goeva.atScreenKaoruCount
        goevaMemory3.atScreenCountSum = goeva.atScreenCountSum
    }
}


// /////////////////////////////
// メモリーロード画面
// /////////////////////////////
struct goevaViewLoadMemory: View {
    @ObservedObject var goeva: Goeva
    @ObservedObject var goevaMemory1: GoevaMemory1
    @ObservedObject var goevaMemory2: GoevaMemory2
    @ObservedObject var goevaMemory3: GoevaMemory3
    @State var isShowLoadAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: "ゴジラvsエヴァンゲリオン",
            selectedMemory: $goeva.selectedMemory,
            memoMemory1: goevaMemory1.memo,
            dateDoubleMemory1: goevaMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: goevaMemory2.memo,
            dateDoubleMemory2: goevaMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: goevaMemory3.memo,
            dateDoubleMemory3: goevaMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowLoadAlert
        )
    }
    func loadMemory1() {
        goeva.normalSuikaCount = goevaMemory1.normalSuikaCount
        goeva.normalCzCount = goevaMemory1.normalCzCount
        goeva.normalHenniKoyakuCount = goevaMemory1.normalHenniKoyakuCount
        goeva.normalHenniZoshokuCount = goevaMemory1.normalHenniZoshokuCount
        goeva.normalHenniUchuCount = goevaMemory1.normalHenniUchuCount
        goeva.normalHenniKasseikaCount = goevaMemory1.normalHenniKasseikaCount
        goeva.normalHenniCountSum = goevaMemory1.normalHenniCountSum
        goeva.bonusScreenShinjiCount = goevaMemory1.bonusScreenShinjiCount
        goeva.bonusScreenReiCount = goevaMemory1.bonusScreenReiCount
        goeva.bonusScreenMariCount = goevaMemory1.bonusScreenMariCount
        goeva.bonusScreenAsukaCount = goevaMemory1.bonusScreenAsukaCount
        goeva.bonusScreenReiBackCount = goevaMemory1.bonusScreenReiBackCount
        goeva.bonusScreenGoevaCount = goevaMemory1.bonusScreenGoevaCount
        goeva.bonusScreenCountSum = goevaMemory1.bonusScreenCountSum
        goeva.atSuikaCount = goevaMemory1.atSuikaCount
        goeva.atCzCount = goevaMemory1.atCzCount
        goeva.atCzWinCount = goevaMemory1.atCzWinCount
        goeva.atScreenShogokiCount = goevaMemory1.atScreenShogokiCount
        goeva.atScreenZerogokiCount = goevaMemory1.atScreenZerogokiCount
        goeva.atScreen8gokiCount = goevaMemory1.atScreen8gokiCount
        goeva.atScreen2gokiCount = goevaMemory1.atScreen2gokiCount
        goeva.atScreenMosuraCount = goevaMemory1.atScreenMosuraCount
        goeva.atScreenGoevaCount = goevaMemory1.atScreenGoevaCount
        goeva.atScreenKaoruCount = goevaMemory1.atScreenKaoruCount
        goeva.atScreenCountSum = goevaMemory1.atScreenCountSum
    }
    func loadMemory2() {
        goeva.normalSuikaCount = goevaMemory2.normalSuikaCount
        goeva.normalCzCount = goevaMemory2.normalCzCount
        goeva.normalHenniKoyakuCount = goevaMemory2.normalHenniKoyakuCount
        goeva.normalHenniZoshokuCount = goevaMemory2.normalHenniZoshokuCount
        goeva.normalHenniUchuCount = goevaMemory2.normalHenniUchuCount
        goeva.normalHenniKasseikaCount = goevaMemory2.normalHenniKasseikaCount
        goeva.normalHenniCountSum = goevaMemory2.normalHenniCountSum
        goeva.bonusScreenShinjiCount = goevaMemory2.bonusScreenShinjiCount
        goeva.bonusScreenReiCount = goevaMemory2.bonusScreenReiCount
        goeva.bonusScreenMariCount = goevaMemory2.bonusScreenMariCount
        goeva.bonusScreenAsukaCount = goevaMemory2.bonusScreenAsukaCount
        goeva.bonusScreenReiBackCount = goevaMemory2.bonusScreenReiBackCount
        goeva.bonusScreenGoevaCount = goevaMemory2.bonusScreenGoevaCount
        goeva.bonusScreenCountSum = goevaMemory2.bonusScreenCountSum
        goeva.atSuikaCount = goevaMemory2.atSuikaCount
        goeva.atCzCount = goevaMemory2.atCzCount
        goeva.atCzWinCount = goevaMemory2.atCzWinCount
        goeva.atScreenShogokiCount = goevaMemory2.atScreenShogokiCount
        goeva.atScreenZerogokiCount = goevaMemory2.atScreenZerogokiCount
        goeva.atScreen8gokiCount = goevaMemory2.atScreen8gokiCount
        goeva.atScreen2gokiCount = goevaMemory2.atScreen2gokiCount
        goeva.atScreenMosuraCount = goevaMemory2.atScreenMosuraCount
        goeva.atScreenGoevaCount = goevaMemory2.atScreenGoevaCount
        goeva.atScreenKaoruCount = goevaMemory2.atScreenKaoruCount
        goeva.atScreenCountSum = goevaMemory2.atScreenCountSum
    }
    func loadMemory3() {
        goeva.normalSuikaCount = goevaMemory3.normalSuikaCount
        goeva.normalCzCount = goevaMemory3.normalCzCount
        goeva.normalHenniKoyakuCount = goevaMemory3.normalHenniKoyakuCount
        goeva.normalHenniZoshokuCount = goevaMemory3.normalHenniZoshokuCount
        goeva.normalHenniUchuCount = goevaMemory3.normalHenniUchuCount
        goeva.normalHenniKasseikaCount = goevaMemory3.normalHenniKasseikaCount
        goeva.normalHenniCountSum = goevaMemory3.normalHenniCountSum
        goeva.bonusScreenShinjiCount = goevaMemory3.bonusScreenShinjiCount
        goeva.bonusScreenReiCount = goevaMemory3.bonusScreenReiCount
        goeva.bonusScreenMariCount = goevaMemory3.bonusScreenMariCount
        goeva.bonusScreenAsukaCount = goevaMemory3.bonusScreenAsukaCount
        goeva.bonusScreenReiBackCount = goevaMemory3.bonusScreenReiBackCount
        goeva.bonusScreenGoevaCount = goevaMemory3.bonusScreenGoevaCount
        goeva.bonusScreenCountSum = goevaMemory3.bonusScreenCountSum
        goeva.atSuikaCount = goevaMemory3.atSuikaCount
        goeva.atCzCount = goevaMemory3.atCzCount
        goeva.atCzWinCount = goevaMemory3.atCzWinCount
        goeva.atScreenShogokiCount = goevaMemory3.atScreenShogokiCount
        goeva.atScreenZerogokiCount = goevaMemory3.atScreenZerogokiCount
        goeva.atScreen8gokiCount = goevaMemory3.atScreen8gokiCount
        goeva.atScreen2gokiCount = goevaMemory3.atScreen2gokiCount
        goeva.atScreenMosuraCount = goevaMemory3.atScreenMosuraCount
        goeva.atScreenGoevaCount = goevaMemory3.atScreenGoevaCount
        goeva.atScreenKaoruCount = goevaMemory3.atScreenKaoruCount
        goeva.atScreenCountSum = goevaMemory3.atScreenCountSum
    }
}

#Preview {
    goevaViewTop()
}
