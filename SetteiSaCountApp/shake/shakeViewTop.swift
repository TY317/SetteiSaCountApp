//
//  shakeViewTop.swift
//  SetteiSaCountApp
//
//  Created by 横田徹 on 2026/01/05.
//

import SwiftUI

struct shakeViewTop: View {
    @EnvironmentObject var common: commonVar
    @ObservedObject var bayes: Bayes
    @ObservedObject var viewModel: InterstitialViewModel
    @StateObject var shake = Shake()
    @State var isShowAlert: Bool = false
    @StateObject var shakeMemory1 = ShakeMemory1()
    @StateObject var shakeMemory2 = ShakeMemory2()
    @StateObject var shakeMemory3 = ShakeMemory3()
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // 注意事項
                    Text("ダイトモの利用を前提としています\n遊技前にダイトモを開始してください")
                        .foregroundStyle(Color.secondary)
                        .font(.footnote)
                } header: {
                    unitLabelMachineTopTitle(machineName: shake.machineName)
                }
                
                Section {
                    // 通常時
                    NavigationLink(destination: shakeViewNormal(
                        shake: shake,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "bell.fill",
                            textBody: "通常時",
                            badgeStatus: common.shakeMenuNormalBadge,
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: shakeViewFirstHit(
                        shake: shake,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "party.popper.fill",
                            textBody: "初当り",
                            badgeStatus: common.shakeMenuFirstHitBadge,
                        )
                    }
                    
                    // 初当り
                    NavigationLink(destination: shakeViewReg(
                        shake: shake,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "message.fill",
                            textBody: "REG中",
                            badgeStatus: common.shakeMenuRegBadge,
                        )
                    }
                    
                    // BT
                    NavigationLink(destination: shakeViewBt(
                        shake: shake,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "signpost.right.and.left",
                            textBody: "BT中",
                            badgeStatus: common.shakeMenuBtBadge,
                        )
                    }
                    
                    // BT
                    NavigationLink(destination: shakeViewScreen(
                        shake: shake,
                        bayes: bayes,
                        viewModel: viewModel,
                    )) {
                        unitLabelMenu(
                            imageSystemName: "photo.on.rectangle.angled.fill",
                            textBody: "BIG終了画面",
                            badgeStatus: common.shakeMenuScreenBadge,
                        )
                    }
                    
                    // トロフィー
                    NavigationLink(destination: commonViewKopandaTrophy()) {
                        unitLabelMenu(imageSystemName: "trophy.fill", textBody: "コパンダトロフィー")
                    }
                }
                
                // 設定推測グラフ
                NavigationLink(destination: shakeView95Ci(
                    shake: shake,
                    selection: 1,
                )) {
                    unitLabelMenu(
                        imageSystemName: "chart.bar.xaxis",
                        textBody: "設定推測グラフ"
                    )
                }

                // 設定期待値計算
                NavigationLink(destination: shakeViewBayes(
                    shake: shake,
                    bayes: bayes,
                    viewModel: viewModel,
                )) {
                    unitLabelMenu(
                        imageSystemName: "gauge.open.with.lines.needle.33percent",
                        textBody: "設定期待値",
                        badgeStatus: common.shakeMenuBayesBadge,
                    )
                }
                
                // 解析サイトへのリンク
                unitLinkSectionDMM(urlString: "https://p-town.dmm.com/machines/4893")
                
                // コピーライト
                unitSectionCopyright {
                    Text("©︎DAITO GIKEN,INC.")
                }
            }
        }
        // //// バッジのリセット
        .resetBadgeOnAppear($common.shakeMachineIconBadge)
        // //// firebaseログ
        .onAppear {
            let screenClass = String(describing: Self.self)
            logEventFirebaseScreen(
                screenName: shake.machineName,
                screenClass: screenClass
            )
        }
        .navigationTitle("メニュー")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                // データ読み出し
                unitButtonLoadMemory(loadView: AnyView(shakeSubViewLoadMemory(
                    shake: shake,
                    shakeMemory1: shakeMemory1,
                    shakeMemory2: shakeMemory2,
                    shakeMemory3: shakeMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データ保存
                unitButtonSaveMemory(saveView: AnyView(shakeSubViewSaveMemory(
                    shake: shake,
                    shakeMemory1: shakeMemory1,
                    shakeMemory2: shakeMemory2,
                    shakeMemory3: shakeMemory3
                )))
            }
            ToolbarItem(placement: .automatic) {
                // データリセット
                unitButtonReset(
                    isShowAlert: $isShowAlert,
                    action: shake.resetAll,
                    message: "この機種のデータを全てリセットします"
                )
            }
        }
    }
}

// ///////////////////////
// メモリーセーブ画面
// ///////////////////////
struct shakeSubViewSaveMemory: View {
    @ObservedObject var shake: Shake
    @ObservedObject var shakeMemory1: ShakeMemory1
    @ObservedObject var shakeMemory2: ShakeMemory2
    @ObservedObject var shakeMemory3: ShakeMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewSaveMemory(
            machineName: shake.machineName,
            selectedMemory: $shake.selectedMemory,
            memoMemory1: $shakeMemory1.memo,
            dateDoubleMemory1: $shakeMemory1.dateDouble,
            actionMemory1: saveMemory1,
            memoMemory2: $shakeMemory2.memo,
            dateDoubleMemory2: $shakeMemory2.dateDouble,
            actionMemory2: saveMemory2,
            memoMemory3: $shakeMemory3.memo,
            dateDoubleMemory3: $shakeMemory3.dateDouble,
            actionMemory3: saveMemory3,
            isShowSaveAlert: $isShowSaveAlert
        )
    }
    func saveMemory1() {
        shakeMemory1.gameNumberStart = shake.gameNumberStart
        shakeMemory1.gameNumberCurrent = shake.gameNumberCurrent
        shakeMemory1.gameNumberPlay = shake.gameNumberPlay
        shakeMemory1.koyakuCountBell = shake.koyakuCountBell
        shakeMemory1.koyakuCountCherry = shake.koyakuCountCherry
        shakeMemory1.koyakuCountSuika = shake.koyakuCountSuika
        shakeMemory1.normalGame = shake.normalGame
        shakeMemory1.bonusCountBig = shake.bonusCountBig
        shakeMemory1.bonusCountReg = shake.bonusCountReg
        shakeMemory1.bonusCountSum = shake.bonusCountSum
        shakeMemory1.idenBonusCountSuika = shake.idenBonusCountSuika
        shakeMemory1.idenBonusCountBell = shake.idenBonusCountBell
        shakeMemory1.idenBonusCountSpecialI = shake.idenBonusCountSpecialI
        shakeMemory1.idenBonusCountSum = shake.idenBonusCountSum
        shakeMemory1.voiceCountDefault = shake.voiceCountDefault
        shakeMemory1.voiceCountHighJaku = shake.voiceCountHighJaku
        shakeMemory1.voiceCountHighChu = shake.voiceCountHighChu
        shakeMemory1.voiceCountHighKyo = shake.voiceCountHighKyo
        shakeMemory1.voiceCountOver5 = shake.voiceCountOver5
        shakeMemory1.voiceCountSum = shake.voiceCountSum
        shakeMemory1.jacCountEnd = shake.jacCountEnd
        shakeMemory1.jacCountContinue = shake.jacCountContinue
        shakeMemory1.jacCountSpecial = shake.jacCountSpecial
        shakeMemory1.jacCountSum = shake.jacCountSum
        shakeMemory1.screenCountDefault = shake.screenCountDefault
        shakeMemory1.screenCountHighJaku = shake.screenCountHighJaku
        shakeMemory1.screenCountHighChu = shake.screenCountHighChu
        shakeMemory1.screenCountHighKyo = shake.screenCountHighKyo
        shakeMemory1.screenCountOver6 = shake.screenCountOver6
        shakeMemory1.screenCountOver1000 = shake.screenCountOver1000
        shakeMemory1.screenCountOver1500 = shake.screenCountOver1500
        shakeMemory1.screenCountSum = shake.screenCountSum
    }
    func saveMemory2() {
        shakeMemory2.gameNumberStart = shake.gameNumberStart
        shakeMemory2.gameNumberCurrent = shake.gameNumberCurrent
        shakeMemory2.gameNumberPlay = shake.gameNumberPlay
        shakeMemory2.koyakuCountBell = shake.koyakuCountBell
        shakeMemory2.koyakuCountCherry = shake.koyakuCountCherry
        shakeMemory2.koyakuCountSuika = shake.koyakuCountSuika
        shakeMemory2.normalGame = shake.normalGame
        shakeMemory2.bonusCountBig = shake.bonusCountBig
        shakeMemory2.bonusCountReg = shake.bonusCountReg
        shakeMemory2.bonusCountSum = shake.bonusCountSum
        shakeMemory2.idenBonusCountSuika = shake.idenBonusCountSuika
        shakeMemory2.idenBonusCountBell = shake.idenBonusCountBell
        shakeMemory2.idenBonusCountSpecialI = shake.idenBonusCountSpecialI
        shakeMemory2.idenBonusCountSum = shake.idenBonusCountSum
        shakeMemory2.voiceCountDefault = shake.voiceCountDefault
        shakeMemory2.voiceCountHighJaku = shake.voiceCountHighJaku
        shakeMemory2.voiceCountHighChu = shake.voiceCountHighChu
        shakeMemory2.voiceCountHighKyo = shake.voiceCountHighKyo
        shakeMemory2.voiceCountOver5 = shake.voiceCountOver5
        shakeMemory2.voiceCountSum = shake.voiceCountSum
        shakeMemory2.jacCountEnd = shake.jacCountEnd
        shakeMemory2.jacCountContinue = shake.jacCountContinue
        shakeMemory2.jacCountSpecial = shake.jacCountSpecial
        shakeMemory2.jacCountSum = shake.jacCountSum
        shakeMemory2.screenCountDefault = shake.screenCountDefault
        shakeMemory2.screenCountHighJaku = shake.screenCountHighJaku
        shakeMemory2.screenCountHighChu = shake.screenCountHighChu
        shakeMemory2.screenCountHighKyo = shake.screenCountHighKyo
        shakeMemory2.screenCountOver6 = shake.screenCountOver6
        shakeMemory2.screenCountOver1000 = shake.screenCountOver1000
        shakeMemory2.screenCountOver1500 = shake.screenCountOver1500
        shakeMemory2.screenCountSum = shake.screenCountSum
    }
    func saveMemory3() {
        shakeMemory3.gameNumberStart = shake.gameNumberStart
        shakeMemory3.gameNumberCurrent = shake.gameNumberCurrent
        shakeMemory3.gameNumberPlay = shake.gameNumberPlay
        shakeMemory3.koyakuCountBell = shake.koyakuCountBell
        shakeMemory3.koyakuCountCherry = shake.koyakuCountCherry
        shakeMemory3.koyakuCountSuika = shake.koyakuCountSuika
        shakeMemory3.normalGame = shake.normalGame
        shakeMemory3.bonusCountBig = shake.bonusCountBig
        shakeMemory3.bonusCountReg = shake.bonusCountReg
        shakeMemory3.bonusCountSum = shake.bonusCountSum
        shakeMemory3.idenBonusCountSuika = shake.idenBonusCountSuika
        shakeMemory3.idenBonusCountBell = shake.idenBonusCountBell
        shakeMemory3.idenBonusCountSpecialI = shake.idenBonusCountSpecialI
        shakeMemory3.idenBonusCountSum = shake.idenBonusCountSum
        shakeMemory3.voiceCountDefault = shake.voiceCountDefault
        shakeMemory3.voiceCountHighJaku = shake.voiceCountHighJaku
        shakeMemory3.voiceCountHighChu = shake.voiceCountHighChu
        shakeMemory3.voiceCountHighKyo = shake.voiceCountHighKyo
        shakeMemory3.voiceCountOver5 = shake.voiceCountOver5
        shakeMemory3.voiceCountSum = shake.voiceCountSum
        shakeMemory3.jacCountEnd = shake.jacCountEnd
        shakeMemory3.jacCountContinue = shake.jacCountContinue
        shakeMemory3.jacCountSpecial = shake.jacCountSpecial
        shakeMemory3.jacCountSum = shake.jacCountSum
        shakeMemory3.screenCountDefault = shake.screenCountDefault
        shakeMemory3.screenCountHighJaku = shake.screenCountHighJaku
        shakeMemory3.screenCountHighChu = shake.screenCountHighChu
        shakeMemory3.screenCountHighKyo = shake.screenCountHighKyo
        shakeMemory3.screenCountOver6 = shake.screenCountOver6
        shakeMemory3.screenCountOver1000 = shake.screenCountOver1000
        shakeMemory3.screenCountOver1500 = shake.screenCountOver1500
        shakeMemory3.screenCountSum = shake.screenCountSum
    }
}


// ///////////////////////
// メモリーロード画面
// ///////////////////////
struct shakeSubViewLoadMemory: View {
    @ObservedObject var shake: Shake
    @ObservedObject var shakeMemory1: ShakeMemory1
    @ObservedObject var shakeMemory2: ShakeMemory2
    @ObservedObject var shakeMemory3: ShakeMemory3
    @State var isShowSaveAlert: Bool = false
    
    var body: some View {
        unitViewLoadMemory(
            machineName: shake.machineName,
            selectedMemory: $shake.selectedMemory,
            memoMemory1: shakeMemory1.memo,
            dateDoubleMemory1: shakeMemory1.dateDouble,
            actionMemory1: loadMemory1,
            memoMemory2: shakeMemory2.memo,
            dateDoubleMemory2: shakeMemory2.dateDouble,
            actionMemory2: loadMemory2,
            memoMemory3: shakeMemory3.memo,
            dateDoubleMemory3: shakeMemory3.dateDouble,
            actionMemory3: loadMemory3,
            isShowLoadAlert: $isShowSaveAlert
        )
    }
    func loadMemory1() {
        shake.gameNumberStart = shakeMemory1.gameNumberStart
        shake.gameNumberCurrent = shakeMemory1.gameNumberCurrent
        shake.gameNumberPlay = shakeMemory1.gameNumberPlay
        shake.koyakuCountBell = shakeMemory1.koyakuCountBell
        shake.koyakuCountCherry = shakeMemory1.koyakuCountCherry
        shake.koyakuCountSuika = shakeMemory1.koyakuCountSuika
        shake.normalGame = shakeMemory1.normalGame
        shake.bonusCountBig = shakeMemory1.bonusCountBig
        shake.bonusCountReg = shakeMemory1.bonusCountReg
        shake.bonusCountSum = shakeMemory1.bonusCountSum
        shake.idenBonusCountSuika = shakeMemory1.idenBonusCountSuika
        shake.idenBonusCountBell = shakeMemory1.idenBonusCountBell
        shake.idenBonusCountSpecialI = shakeMemory1.idenBonusCountSpecialI
        shake.idenBonusCountSum = shakeMemory1.idenBonusCountSum
        shake.voiceCountDefault = shakeMemory1.voiceCountDefault
        shake.voiceCountHighJaku = shakeMemory1.voiceCountHighJaku
        shake.voiceCountHighChu = shakeMemory1.voiceCountHighChu
        shake.voiceCountHighKyo = shakeMemory1.voiceCountHighKyo
        shake.voiceCountOver5 = shakeMemory1.voiceCountOver5
        shake.voiceCountSum = shakeMemory1.voiceCountSum
        shake.jacCountEnd = shakeMemory1.jacCountEnd
        shake.jacCountContinue = shakeMemory1.jacCountContinue
        shake.jacCountSpecial = shakeMemory1.jacCountSpecial
        shake.jacCountSum = shakeMemory1.jacCountSum
        shake.screenCountDefault = shakeMemory1.screenCountDefault
        shake.screenCountHighJaku = shakeMemory1.screenCountHighJaku
        shake.screenCountHighChu = shakeMemory1.screenCountHighChu
        shake.screenCountHighKyo = shakeMemory1.screenCountHighKyo
        shake.screenCountOver6 = shakeMemory1.screenCountOver6
        shake.screenCountOver1000 = shakeMemory1.screenCountOver1000
        shake.screenCountOver1500 = shakeMemory1.screenCountOver1500
        shake.screenCountSum = shakeMemory1.screenCountSum
    }
    func loadMemory2() {
        shake.gameNumberStart = shakeMemory2.gameNumberStart
        shake.gameNumberCurrent = shakeMemory2.gameNumberCurrent
        shake.gameNumberPlay = shakeMemory2.gameNumberPlay
        shake.koyakuCountBell = shakeMemory2.koyakuCountBell
        shake.koyakuCountCherry = shakeMemory2.koyakuCountCherry
        shake.koyakuCountSuika = shakeMemory2.koyakuCountSuika
        shake.normalGame = shakeMemory2.normalGame
        shake.bonusCountBig = shakeMemory2.bonusCountBig
        shake.bonusCountReg = shakeMemory2.bonusCountReg
        shake.bonusCountSum = shakeMemory2.bonusCountSum
        shake.idenBonusCountSuika = shakeMemory2.idenBonusCountSuika
        shake.idenBonusCountBell = shakeMemory2.idenBonusCountBell
        shake.idenBonusCountSpecialI = shakeMemory2.idenBonusCountSpecialI
        shake.idenBonusCountSum = shakeMemory2.idenBonusCountSum
        shake.voiceCountDefault = shakeMemory2.voiceCountDefault
        shake.voiceCountHighJaku = shakeMemory2.voiceCountHighJaku
        shake.voiceCountHighChu = shakeMemory2.voiceCountHighChu
        shake.voiceCountHighKyo = shakeMemory2.voiceCountHighKyo
        shake.voiceCountOver5 = shakeMemory2.voiceCountOver5
        shake.voiceCountSum = shakeMemory2.voiceCountSum
        shake.jacCountEnd = shakeMemory2.jacCountEnd
        shake.jacCountContinue = shakeMemory2.jacCountContinue
        shake.jacCountSpecial = shakeMemory2.jacCountSpecial
        shake.jacCountSum = shakeMemory2.jacCountSum
        shake.screenCountDefault = shakeMemory2.screenCountDefault
        shake.screenCountHighJaku = shakeMemory2.screenCountHighJaku
        shake.screenCountHighChu = shakeMemory2.screenCountHighChu
        shake.screenCountHighKyo = shakeMemory2.screenCountHighKyo
        shake.screenCountOver6 = shakeMemory2.screenCountOver6
        shake.screenCountOver1000 = shakeMemory2.screenCountOver1000
        shake.screenCountOver1500 = shakeMemory2.screenCountOver1500
        shake.screenCountSum = shakeMemory2.screenCountSum
    }
    func loadMemory3() {
        shake.gameNumberStart = shakeMemory3.gameNumberStart
        shake.gameNumberCurrent = shakeMemory3.gameNumberCurrent
        shake.gameNumberPlay = shakeMemory3.gameNumberPlay
        shake.koyakuCountBell = shakeMemory3.koyakuCountBell
        shake.koyakuCountCherry = shakeMemory3.koyakuCountCherry
        shake.koyakuCountSuika = shakeMemory3.koyakuCountSuika
        shake.normalGame = shakeMemory3.normalGame
        shake.bonusCountBig = shakeMemory3.bonusCountBig
        shake.bonusCountReg = shakeMemory3.bonusCountReg
        shake.bonusCountSum = shakeMemory3.bonusCountSum
        shake.idenBonusCountSuika = shakeMemory3.idenBonusCountSuika
        shake.idenBonusCountBell = shakeMemory3.idenBonusCountBell
        shake.idenBonusCountSpecialI = shakeMemory3.idenBonusCountSpecialI
        shake.idenBonusCountSum = shakeMemory3.idenBonusCountSum
        shake.voiceCountDefault = shakeMemory3.voiceCountDefault
        shake.voiceCountHighJaku = shakeMemory3.voiceCountHighJaku
        shake.voiceCountHighChu = shakeMemory3.voiceCountHighChu
        shake.voiceCountHighKyo = shakeMemory3.voiceCountHighKyo
        shake.voiceCountOver5 = shakeMemory3.voiceCountOver5
        shake.voiceCountSum = shakeMemory3.voiceCountSum
        shake.jacCountEnd = shakeMemory3.jacCountEnd
        shake.jacCountContinue = shakeMemory3.jacCountContinue
        shake.jacCountSpecial = shakeMemory3.jacCountSpecial
        shake.jacCountSum = shakeMemory3.jacCountSum
        shake.screenCountDefault = shakeMemory3.screenCountDefault
        shake.screenCountHighJaku = shakeMemory3.screenCountHighJaku
        shake.screenCountHighChu = shakeMemory3.screenCountHighChu
        shake.screenCountHighKyo = shakeMemory3.screenCountHighKyo
        shake.screenCountOver6 = shakeMemory3.screenCountOver6
        shake.screenCountOver1000 = shakeMemory3.screenCountOver1000
        shake.screenCountOver1500 = shakeMemory3.screenCountOver1500
        shake.screenCountSum = shakeMemory3.screenCountSum
    }
}

#Preview {
    shakeViewTop(
        bayes: Bayes(),
        viewModel: InterstitialViewModel(),
    )
    .environmentObject(commonVar())
}
